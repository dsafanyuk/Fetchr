<template>
  <v-container fluid>
    <h3>Checkout</h3>
    <v-layout row class="pa-3 mb-2">
      <v-flex md8 xs12>
        <v-data-table :items="items" hide-headers :hide-actions="!isMobile" class="elevation-1">
          <template slot="items" slot-scope="props">
            <td align="text-xs-center" class="hidden-sm-and-down">
              <img :src="props.item.product_url" class="checkout-img">
            </td>
            <td class="body-2 text-xs-left">{{ props.item.product_name }}</td>
            <td class="text-xs-left">${{ (props.item.price).toFixed(2) }}</td>
            <td class="text-xs-center">
              <v-btn icon v-on:click="incQuantity(props.item)">
                <v-icon color="primary">add_circle</v-icon>
              </v-btn>
              <span>{{ props.item.quantity }}</span>
              <v-btn icon v-on:click="decQuantity(props.item)">
                <v-icon color="primary">remove_circle</v-icon>
              </v-btn>
            </td>
            <td class="text-xs-left">
              <v-btn icon v-on:click="removeItem(props.item)">
                <v-icon color="error">delete_forever</v-icon>
              </v-btn>
            </td>
          </template>
          <template slot="footer">
            <td class="text-xs-right" :colspan="2">
              <strong>Total</strong>
            </td>
            <td class="text-xs-left" :colspan="4">{{total}}</td>
          </template>
        </v-data-table>
      </v-flex>
      <v-spacer></v-spacer>
      <v-flex md3>
        <br class="hidden-md-and-up">
        <v-card>
          <div
            class="submitOrderButton text-xs-center"
            v-if="sufficientFunds == true && items.length"
          >
            <v-alert outline :value="true" type="success">
              <h4>Ready to Order!</h4>
              <br>
              <strong>Remaing Balance after order:</strong>
              <h5>{{walletAfterTransaction}}</h5>
              <v-btn
                :loading="loading"
                :disabled="loading"
                type="submit"
                v-on:click="checkout"
                color="accent"
              >Submit Order</v-btn>
            </v-alert>
          </div>
          <div v-else-if="sufficientFunds == false" class="text-xs-center">
            <v-alert outline :value="true" type="warning">
              <strong>Insufficient Funds:</strong>
              <br>
              <h4>{{walletBalance}}</h4>
              <v-btn type="submit" color="success" v-on:click="showWallet(true)">
                Refill Wallet &nbsp;&nbsp;
                <v-icon>fas fa-money-bill-wave</v-icon>
              </v-btn>
            </v-alert>
          </div>
        </v-card>
      </v-flex>
    </v-layout>
  </v-container>
</template>
    
    <script>
import browserCookies from "browser-cookies";
import axios from "../../../../axios";
import { mapState, mapActions, mapGetters } from "vuex";

export default {
  data() {
    return {
      loading: false
    };
  },
  // Returns an array of objects
  computed: {
    ...mapGetters("cart", {
      items: "cartItems",
      total: "totalCartPrice"
    }),
    ...mapGetters("wallet", {
      walletBalance: "walletBalance"
    }),
    walletAfterTransaction: function() {
      let balance = this.walletBalance - this.total;
      return balance.toFixed(2);
    },
    sufficientFunds: function() {
      if (parseFloat(this.walletBalance, 10) >= parseFloat(this.total, 10)) {
        return true;
      } else {
        return false;
      }
    },
    isMobile() {
      if (
        /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(
          navigator.userAgent
        )
      ) {
        return true;
      } else {
        return false;
      }
    }
  },
  mounted: function() {
    this.$store.dispatch("wallet/getWalletBalance");
  },
  methods: {
    checkout: function(event) {
      let socket = this.$socket;
      let router = this.$router;
      let productsWithQuantity = [];

      this.loading = true;

      this.items.map(product => {
        //put all the products into a json array
        productsWithQuantity.push({
          product_id: product.product_id,
          quantity: product.quantity
        });
      });
      this.$store.dispatch("wallet/getWalletBalance");
      console.log(productsWithQuantity);
      if (this.sufficientFunds) {
        axios
          .post("/api/orders/", {
            customer_id: browserCookies.get("user_id"),
            delivery_status: "pending",
            order_total: this.$store.getters["cart/totalCartPrice"],
            productsWithQuantity: productsWithQuantity
          })
          .then(response => {
            socket.emit("ORDER_CREATED");
            //go to the confirmation page and send it the order id
            router.push("/confirmation?order=" + response.data.message);
            this.$store.dispatch("wallet/getWalletBalance");
          });
      } else {
      }
    },
    // Remove an item from cart
    removeItem: function(product) {
      this.$store.commit("cart/removeItem", product);
    },
    // Increase quantity for a product
    incQuantity: function(product) {
      this.$store.commit("cart/incQuantity", product);
    },
    // Decrease quantity for a product
    decQuantity: function(product) {
      if (product.quantity > 1) {
        this.$store.commit("cart/decQuantity", product);
      }
    },
    showWallet: function(value) {
      this.$store.commit("wallet/toggleWallet", value);
    }
  }
};
</script>
<style scoped lang="css">
.checkout-img {
  max-height: 75px;
}
</style>
    
