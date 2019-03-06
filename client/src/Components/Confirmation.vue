<template>
    <v-app>
        <LandingHeader></LandingHeader>
        <div class="confirmation">
            <h3 class="thankyou">Thank you for using our service!</h3>
            <div class="userInfo">
                <p>Your order number is {{this.$route.query.order}}.</p>
                <p>You can check the status of your orders in the My Orders tab.</p>
            </div>
        </div>
        <LandingFooter></LandingFooter>
    </v-app>
</template>


<script>
        import LandingHeader from './mini-components/LandingHeader.vue';
        import LandingFooter from './mini-components/LandingFooter.vue';
        
        export default {
        
          data () {
            name: 
            return {
            };
          },
          components: {
            LandingHeader: LandingHeader,
            LandingFooter: LandingFooter,
          },
        }
        
</script>
        
<style scoped lang="css" src='./custom_css/confirmation.css'>
</style>