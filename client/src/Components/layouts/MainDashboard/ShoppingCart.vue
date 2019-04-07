<template>
  <div class="text-xs-center">
    <v-dialog v-model="show" width="750" transition="false">
      <v-card>
        <div class="text-xs-right">
          <v-btn icon small color="gray " top @click="show = !show">
            <v-icon>clear</v-icon>
          </v-btn>
        </div>
        <v-card-title
          class="headline justify-center text-xs-center font-weight-bold"
          primary-title
        >Your Shopping Cart</v-card-title>
        <v-data-table :items="items" hide-headers :total-items="10" hide-actions>
          <template slot="items" slot-scope="props">
            <td>{{ props.item.product_name }}</td>
            <td class="text-xs-center">
              <v-btn icon v-on:click="incQuantity(props.item)">
                <v-icon color="primary">add_circle</v-icon>
              </v-btn>
              {{ props.item.quantity }}
              <v-btn icon v-on:click="decQuantity(props.item)">
                <v-icon color="primary">remove_circle</v-icon>
              </v-btn>
            </td>

            <td
              class="text-xs-right"
              :colspan="2"
            >{{ (props.item.price * props.item.quantity).toFixed(2) }}</td>
            <td class="text-xs-center">
              <v-btn icon v-on:click="removeItem(props.item)">
                <v-icon color="error">delete_forever</v-icon>
              </v-btn>
            </td>
          </template>
          <template slot="footer">
            <td></td>
            <td class="text-xs-right">
              <strong>Total</strong>
            </td>
            <td class="text-xs-left" :colspan="4">{{total}}</td>
          </template>
        </v-data-table>
        <div class="text-xs-center">
          <v-btn color="gray" @click="show = !show" to="/dashboard">Continue Shopping</v-btn>

          <v-btn :disabled="isEmpty" v-on:click="checkout(false)" color="success">
            Checkout &nbsp;&nbsp;
            <v-icon>check</v-icon>
          </v-btn>
        </div>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import { mapState, mapActions, mapGetters } from "vuex";

export default {
  props: {
    value: Boolean
  },
  data() {
    return {};
  },
  computed: {
    ...mapGetters("cart", {
      items: "cartItems",
      total: "totalCartPrice",
      numberOfItems: "totalCartItems"
    }),
    isEmpty() {
      if (this.$store.getters["cart/totalCartItems"]) {
        return false;
      } else {
        return true;
      }
    },
    show: {
      get() {
        return this.$store.getters["cart/cartIsActive"];
      },
      set(value) {
        this.$store.commit("cart/toggleCart", value);
      }
    }
  },
  methods: {
    // Go to checkout page
    checkout: function(value) {
      this.$router.push("/checkout");
      this.$store.commit("cart/toggleCart", value);
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
    // Remove a product from cart
    removeItem: function(product) {
      this.$store.commit("cart/removeItem", product);
    }
  }
};
</script>

<style scoped lang="scss">
</style>
