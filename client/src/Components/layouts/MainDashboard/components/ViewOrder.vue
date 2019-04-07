<template>
  <v-container>
    <v-layout row class="pa-3 mb-2">
      <v-flex md7 sm12>
        <div class="orderHeader">
          <h3>Order: #{{this.$route.query.order}}</h3>
          <div>
            <h4>Status:</h4>
            <h5 v-bind:class="orderStatus" id="status">{{this.orderStatus}}</h5>
          </div>
        </div>
        <div v-if="isLoading">
          <v-progress-linear :indeterminate="true" height="10"></v-progress-linear>
        </div>
        <v-data-table :items="items" hide-headers class="elevation-1">
          <template slot="items" slot-scope="props">
            <td align="center" class="hidden-sm-and-down">
              <img :src="props.item.product_url" class="checkout-img">
            </td>
            <td class="body-2">{{ props.item.product_name }}</td>
            <td class="text-xs-left">${{ props.item.price }}</td>
            <td class="text-xs-left">{{ props.item.quantity }}</td>
          </template>
          <template slot="footer">
            <td class="text-xs-right" :colspan="2">
              <strong>Total</strong>
            </td>
            <td class="text-xs-left" :colspan="4">${{total.toFixed(2)}}</td>
          </template>
        </v-data-table>
      </v-flex>
      <v-spacer></v-spacer>
      <div v-if="!updatedCourierInfo"></div>
      <v-flex md4 sm12 lg4 v-else>
        <h3 class="courierInfoHeader">Courier Information</h3>
        <v-card class="text-xs-center courierInfo">
          <div>
            <span>{{updatedCourierInfo.first_name}} {{updatedCourierInfo.last_name}}</span>
          </div>
          <div>
            <span>{{updatedCourierInfo.phone_number}}</span>
          </div>
          <div>
            <span>Delivered Orders: {{updatedCourierInfo.delivered}}</span>
          </div>
          <v-divider></v-divider>
          <CreateChat :order_id="CurrentOrderId"></CreateChat>
        </v-card>
      </v-flex>
    </v-layout>
    <v-btn color="#F5F5F5" @click="$router.push('/orders')">
      <v-icon black>arrow_back</v-icon>&nbsp; &nbsp;Back to Orders
    </v-btn >
  </v-container>
</template>

<script>
import browserCookies from "browser-cookies";
import axios from "../../../../axios.js";
import CreateChat from "../../MainDashboard/components/ChatCreateConversation.vue";

export default {
  data() {
    return {
      CurrentOrderId: parseInt(this.$route.query.order),
      items: [],
      total: 0.0,
      isLoading: false
    };
  },
  components: {
    CreateChat: CreateChat
  },
  computed: {
    orderStatus() {
      return this.$store.getters["orders/status"];
    },
    updatedCourierInfo() {
      return this.$store.getters["orders/info"];
    }
  },
  mounted: function() {
    this.getOrderSummary();
  },
  methods: {
    getOrderSummary: function() {
      this.isLoading = true;
      axios
        .get(`/api/orders/${this.$route.query.order}/summary`)
        .then(response => {
          this.isLoading = false;
          let orderInfo = response.data.orderInfo[0];
          if (orderInfo.customer_id != browserCookies.get("user_id")) {
            this.$router.push("/orders");
          }
          this.items = response.data.productList;
          this.$store.commit("orders/changeStatus", orderInfo.delivery_status);
          this.items.forEach(item => {
            item.item_total = item.price * item.quantity;
            this.total += item.item_total;
          });
          this.$store.commit("orders/changeOrder", this.$route.query.order);
          this.$store.dispatch("orders/getInfo", this.$route.query.order, {
            root: true
          });
        });
    }
  }
};
</script>
<style scoped lang="css">
.checkout-img {
  max-height: 75px;
  margin: 10px;
}
.orderHeader {
  display: flex;
  flex-direction: column;
}
.orderHeader div {
  display: flex;
  flex-direction: row;
}
.courierInfoHeader {
  text-align: center;
  margin: 19px 0;
}
.courierInfo {
  padding: 15px 0;
}
.courierInfo div {
  margin-bottom: 1.5em;
}
#status {
  font-size: 1em;
  margin: 0;
  text-transform: uppercase;
  padding: 0.4em;
}
.delivered {
  color: green;
}
.pending {
  color: #666666;
}
.in-progress {
  color: rgb(249, 170, 51);
}
</style>
