<template>
<v-app>
    <LandingHeader> </LandingHeader>
    <div class="container-fluid">
        <div class="row">
            <div class=" cat_menu col-md-12">
                <ul class="  nav justify-content-center">
                    <li class="nav-item">
                        <a class="nav-link" href="#">Food</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Snacks</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Drink</a>
                    </li>
                    <li class="nav-item">
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
import ProductInfo from './mini-components/ProductInfo.vue';
import ShoppingCart from './mini-components/ShoppingCart.vue'
import axios from 'axios';

export default {
  data() {
    return {
      products : {},
    };
  },
  props : {
  },
  mounted: function() {
    axios.get('http://localhost:3000/api/products').then((response) => {
      this.products = response.data;
      console.log("Hey ");
    });
  },
  components: {
    LandingHeader: LandingHeader,
    LandingFooter: LandingFooter,
    LandingCard: LandingCard,
    ProductInfo: ProductInfo,
    ShoppingCart : ShoppingCart,
  },
};
</script>

<style lang="css">
@import 'custom_css/landing.scss';
</style>
