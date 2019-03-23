<template>
  <div class="checkout">
    <v-layout row>
      <v-flex md7>
        <div class="orderHeader">
          <h3>Order: #{{this.$route.query.order}}</h3>
          <div>
            <h4>Status:</h4>
            <h5 v-bind:class="orderStatus" id="status">{{this.orderStatus}}</h5>
          </div>
        </div>
        <v-data-table
          :items="items"
          hide-headers
          :total-items="items.length"
          hide-actions
          class="elevation-1"
        >
          <template slot="items" slot-scope="props">
            <td align="center">
              <img :src="props.item.product_url" class="checkout-img">
            </td>
            <td class="body-2">{{ props.item.product_name }}</td>
            <td class="text-xs-left">${{ (props.item.item_total).toFixed(2) }}</td>
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
      <v-flex md4 v-else>
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
          <v-btn type="submit" color="success" class="chatButton">Chat with me!</v-btn>
        </v-card>
      </v-flex>
    </v-layout>
  </div>
</template>
      
      <script>
import browserCookies from "browser-cookies";
import axios from "../../../../axios.js";

export default {
  data() {
    return {
      items: [],
      total: 0.0,
    }
  },
  computed: {
    orderStatus() {
      return this.$store.getters["orders/status"];
    },
    updatedCourierInfo() {
      return this.$store.getters["orders/info"];
    },
  },
  mounted: function() {
    this.getOrderSummary();
  },
  methods: {
    getOrderSummary: function() {
      axios
      .get(`/api/orders/${this.$route.query.order}/summary`)
      .then(response => {
        let orderInfo = response.data.orderInfo[0];
        if (orderInfo.customer_id != browserCookies.get("user_id")) {
          this.$router.push("/orders");
        }
        this.items = response.data.productList;
        this.$store.commit('orders/changeStatus', orderInfo.delivery_status);
        this.items.forEach(item => {
          item.item_total = item.price * item.quantity;
          this.total += item.item_total;
        });
        this.$store.commit('orders/changeOrder', this.$route.query.order);
        this.$store.dispatch('orders/getInfo', this.$route.query.order, {root:true})
      });
    },
  }
};
</script>
<style scoped lang="css">
.checkout {
  padding-top: 3em;
  padding-bottom: 3em;
  padding-left: 10em;
  padding-right: 10em;
}
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
  