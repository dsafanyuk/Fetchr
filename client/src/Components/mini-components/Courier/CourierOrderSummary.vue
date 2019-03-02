<template>
  <v-dialog v-model="dialog" width="570">
    <v-card>
      <v-card-title class="headline grey lighten-2" primary-title>Order Summary</v-card-title>
      <v-data-table :headers="headers" :items="products">
        <template slot="items" slot-scope="props">
          <td>{{ props.item.product_name }}</td>
          <td class="text-xs-left">{{ props.item.price }}</td>
          <td class="text-xs-left">{{ props.item.quantity }}</td>
        </template>
      </v-data-table>
      <div class="text-xs-center pt-2" v-if="order.delivery_status">
        <v-btn
          v-if="order.delivery_status == 'pending'"
          color="orange"
          v-on:click="acceptOrder"
        >Accept</v-btn>
        <v-btn
          v-if="order.delivery_status == 'in-progress'"
          color="green"
          v-on:click="deliverOrder"
        >Deliver</v-btn>
      </div>
    </v-card>
  </v-dialog>
</template>
        
<script>
import axios from "../../../axios";
import browserCookies from "browser-cookies";
import Toasted from "vue-toasted";

export default {
  name: "CourierOrderSummary",
  props: {
    selectedOrder: {
      delivery_status: String,
      first_name: String,
      order_id: Number,
      order_total: String,
      room_num: String,
      time_created: String
    },
    summaryIsActive: Boolean
  },
  data() {
    return {
      headers: [
        { text: "Product", align: "left", value: "product_name" },
        { text: "Total", align: "left", value: "price" },
        { text: "Quantity", align: "left", value: "quantity" }
      ],
      products: []
    };
  },
  computed: {
    order: function() {
      return this.selectedOrder;
    },
    dialog: {
      get() {
        return this.summaryIsActive;
      },
      set(value) {
        this.$emit("input", value);
      }
    }
  },
  methods: {
    getProducts: function() {
      return new Promise((resolve, reject) => {
        axios
          .get(`/api/orders/${this.order.order_id}/summary`)
          .then(response => {
            let prod = [];
            prod = response.data.productList.map(product => {
              product.price = "$" + product.price.toFixed(2);
              product.value = false;
              return product;
            });
            resolve(prod);
          })
          .catch(err => {
            console.error(err);
          });
      });
    },
    acceptOrder: function(event) {
      if (event) {
        axios
          .post(`/api/courier/accept`, {
            courier_id: browserCookies.get("user_id"),
            order_id: this.order.order_id
          })
          .then(response => {
            if (response.data == "success") {
              this.dialog = false;
              this.$toasted.show("Order Accepted! Go pick it up plz", {
                position: "top-center",
                duration: 5000
              });
              this.$socket.emit("ORDER_ACCEPTED", {
                user: this.order.user_id,
                order: this.order.order_id
              });
            } else {
              this.$toasted.error(
                "Oops! This order has already been accepted. :(",
                {
                  position: "top-center",
                  duration: 5000
                }
              );
            }
          })
          .then(() => {
            this.$store.dispatch("courier/clearAllOrders");
          })
          .then(() => {
            this.$store.dispatch("courier/refreshAllOrders");
          });
      }
    },
    deliverOrder: function(event) {
      axios
        .post(`/api/courier/deliver`, {
          courier_id: browserCookies.get("user_id"),
          order_id: this.order.order_id
        })
        .then(response => {
          if (response.data == "success") {
            this.dialog = false;
            this.$toasted.show("Order delivered!", {
              position: "top-center",
              duration: 5000
            });
            this.$socket.emit("ORDER_DELIVERED", {
              user: this.order.user_id,
              order: this.order.order_id
            });
          } else {
            this.$toasted.error("Oops! :(", {
              position: "top-center",
              duration: 5000
            });
          }
        })
        .then(() => {
          this.$store.dispatch("courier/clearAllOrders");
        })
        .then(() => {
          this.$store.dispatch("courier/refreshAllOrders");
        });
    }
  },
  watch: {
    selectedOrder: {
      immediate: true,
      handler() {
        if (this.order) {
          this.getProducts().then(value => {
            this.products = value;
          });
        }
      }
    }
  }
};
</script>
    