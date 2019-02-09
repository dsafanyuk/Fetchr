<template>
  <div class="text-xs-center">
    <v-dialog v-model="show" width="750">
      <v-card>
        <v-card-title
          class="headline justify-center text-xs-center font-weight-bold"
          primary-title
        >Your Shopping Cart</v-card-title>
        <v-data-table
          :headers="headers"
          :items="items"
          hide-headers
          :total-items="10"
          hide-actions
        >
          <template slot="items" slot-scope="props">
            <td>{{ props.item.product_name }}</td>
            <td class="text-xs-right">
              <v-btn icon v-on:click="decQuantity(props.item)">
                <v-icon color="primary">remove_circle</v-icon>
              </v-btn>{{ props.item.quantity }}
              <v-btn icon v-on:click="incQuantity(props.item)">
                <v-icon color="primary">add_circle</v-icon>
              </v-btn>
            </td>
            <td class="text-xs-right" :colspan="2">{{ (props.item.price * props.item.quantity).toFixed(2) }}</td>
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
            <td class="text-xs-left" :colspan="headers.length">{{total}}</td>
          </template>
        </v-data-table>
        <div class="text-xs-center">
          <v-btn color="gray">Continue Shopping</v-btn>
          <v-btn v-on:click="checkout" dark color="green">Checkout &nbsp;&nbsp;
            <v-icon>check</v-icon>
          </v-btn>
        </div>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
export default {
  props: {
    value: Boolean
  },
  data() {
    return {
    };
  },
  computed: {
    // Return all items in the cart
    items: function() {
      return this.$store.getters.cartItems
    },
    // Return total price in the cart
    total: function() {
      return this.$store.getters.totalCartPrice;
    },
    // Return number of items
    numberOfItems: function() {
      return this.$store.getters.totalCartItems;
    },
    show: {
      get() {
        return this.value;
      },
      set(value) {
        this.$emit("input", value);
      }
    }
  },
  methods: {
    // Go to checkout page
    checkout: function(event) {
      this.$router.push("/checkout");
    },
    // Increase quantity for a product
    incQuantity: function (product) {
      this.$store.commit("incQuantity", product);
    },
    // Decrease quantity for a product
    decQuantity: function (product) {
      if(product.quantity > 1) {
        this.$store.commit("decQuantity", product);
      }
    },
    // Remove a product from cart
    removeItem: function (product) {
      this.$store.commit("removeItem", product);
    },
  },
};
</script>

<style scoped lang="scss">
@import "../custom_css/ShoppingCart.scss";
</style>
