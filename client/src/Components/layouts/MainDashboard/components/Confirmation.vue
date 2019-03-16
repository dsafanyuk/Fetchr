<template>
  <v-app>
    <div class="confirmation">
      <h3 class="thankyou">Thank you for using our service!</h3>
      <div class="userInfo">
        <p>Your order number is {{this.$route.query.order}}.</p>
        <p>You can check the status of your orders in the My Orders tab.</p><br>
        <p>Redirecting to your order page in... {{countdownTime}}</p><br>
        <p> OR </p><br>
        <v-btn type="submit" v-on:click="goToView" color="accent" class="white--text">Click here now!</v-btn>
      </div>
    </div>
  </v-app>
</template>


<script>

export default {
  data() {
    return {
      countdownTime: 10,
    };
  },
  created: function emptyCart() {
    this.$store.getters["cart/cartItems"].map(product => {
      this.$store.commit("cart/removeItem", product);
    })

    var countdownTimer = setInterval(() => {
      this.countdownTime--;
    }, 1000);

    setTimeout(() => {
      clearInterval(countdownTimer);

      this.$router.push('/view?order=' + this.$route.query.order);
    }, 10000);
  },
  methods: {
    goToView() {
      this.$router.push('/view?order=' + this.$route.query.order);
    }
  }
};
</script>
        
<style scoped lang="css" src='../../../custom_css/confirmation.css'>
</style>
