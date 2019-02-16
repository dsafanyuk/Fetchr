<template>
  <v-dialog v-model="dialog" width="570">
    <button slot="activator" class="btn btn-outline-dark my-2 my-sm-0" type="button">View</button>
    <v-card>
      <v-card-title class="headline grey lighten-2" primary-title>Order Summary</v-card-title>
      <v-data-table :headers="headers" :items="products">
        <template slot="items" slot-scope="props">
          <td>{{ props.item.product_name }}</td>
          <td class="text-xs-left">{{ props.item.price }}</td>
          <td class="text-xs-left">{{ props.item.quantity }}</td>
        </template>
      </v-data-table>
      <div class="text-xs-center pt-2">
        <v-btn v-if="accept" color="orange" v-on:click="acceptOrder">Accept</v-btn>
        <v-btn v-if="deliver" color="green" v-on:click="deliverOrder">Deliver</v-btn>
      </div>
    </v-card>
  </v-dialog>
</template>
        
<script>
import axios from "axios";
import browserCookies from "browser-cookies";
import Toasted from "vue-toasted";
const api = axios.create();

export default {
  name: "CourierOrderSummary",
  props: {
    orderID: Number,
    accept: Boolean,
    deliver: Boolean
  },
  data() {
    return {
      headers: [
        { text: "Product", align: "left", value: "product_name" },
        { text: "Total", align: "left", value: "price" },
        { text: "Quantity", align: "left", value: "quantity" }
      ],
      products: [],
      dialog: false
    };
  },
  methods: {
    acceptOrder: function(event) {
      if (event) {
        api
          .post(`/api/courier/accept`, {
            courier_id: browserCookies.get("user_id"),
            order_id: this.orderID
          })
          .then(response => {
            if (response.data == "success") {
              this.dialog = false;
              this.$toasted.show("Order Accepted! Go pick it up plz", {
                position: "top-center",
                duration: 5000
              });
              this.$emit("accepted");
            } else {
              this.$toasted.error(
                "Oops! This order has already been accepted. :(",
                {
                  position: "top-center",
                  duration: 5000
                }
              );
            }
          });
      }
    },
    deliverOrder: function(event) {
      if (event) {
        api.post(`/api/courier/${this.orderID}/deliverOrder`).then(response => {
          if (response.data == "success") {
            this.dialog = false;
            this.$toasted.show("Order delivered!", {
              position: "top-center",
              duration: 5000
            });
            this.$emit("delivered");
          } else {
            this.$toasted.error("Oops! :(", {
              position: "top-center",
              duration: 5000
            });
          }
        });
      }
    }
  },
  mounted: function() {
    if (this.orderID != "") {
      api.get(`/api/orders/${this.orderID}/summary`).then(response => {
        this.products = response.data.map(product => {
          product.price = "$" + product.price.toFixed(2);
          product.value = false;
          return product;
        });
      });
    }
  }
};
</script>
    