<template>
<v-app>
    <LandingHeader> </LandingHeader>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <ul class="  nav justify-content-center">
                    <li class="cat_menu nav-item">
                        <a class="nav-link" href="#">Food</a>
                    </li>
                    <li class="cat_menu nav-item">
                        <a class="nav-link" href="#">Snacks</a>
                    </li>
                    <li class="cat_menu nav-item">
                        <a class="nav-link" href="#">Drink</a>
                    </li>
                    <li class="cat_menu nav-item">
                        <a class="nav-link" href="#">  </a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="row">
                <LandingCard v-for="product in products" :key="product.product_id" :product=product ></LandingCard>
        </div>
        </div>
        <LandingFooter> </LandingFooter>


    </v-app>
</template>

<script>
import LandingHeader from './mini-components/LandingHeader.vue';
import LandingFooter from './mini-components/LandingFooter.vue';
import LandingCard from './mini-components/LandingCard.vue';
import ShoppingCart from './mini-components/ShoppingCart.vue';
import axios from 'axios';
import Toasted from 'vue-toasted';

export default {
  data() {
    return {
      products: {},
    };
  },
  props: {},
  mounted: function loadProducts() {
    let loadingProductsToast = this.$toasted.show('Loading products...');
    axios
      .get('http://localhost:3000/api/products')
      .then((response) => {
        this.products = response.data;
        console.log(this.products);
        loadingProductsToast.text('Products loaded!').goAway(5000);
      })
      .catch((error) => {
        console.log(error);
        loadingProductsToast.goAway();
        this.$toasted.error('Something went wrong');
      });
  },
  components: {
    LandingHeader: LandingHeader,
    LandingFooter: LandingFooter,
    LandingCard: LandingCard,
    ShoppingCart: ShoppingCart,
  },
};
</script>

<style lang="css">
    @import 'custom_css/landing.scss';
</style>