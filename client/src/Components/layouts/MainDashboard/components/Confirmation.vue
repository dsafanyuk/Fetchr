<template>
  <v-app>
    <div class="confirmation">
      <h3 class="thankyou">Thank you for using our service!</h3>
      <div class="userInfo">
        <p>Your order number is {{this.$route.query.order}}.</p>
        <p>You can check the status of your orders in the My Orders tab.</p>
      </div>
    </div>
  </v-app>
</template>


<script>

export default {
  data() {
    name: return {};
  },
  // Clear the cart
  created: function emptyCart() {
    this.$store.getters["cart/cartItems"].map(product => {
      this.$store.commit("cart/removeItem", product);
    });
  }
};
</script>
        
<style scoped lang="css" src='../../../custom_css/confirmation.css'>
</style>
