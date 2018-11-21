<template>
    <v-app>
        <LandingHeader v-on:showcart="displayCart" ></LandingHeader>
        <ShoppingCart v-if="seen"></ShoppingCart>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <div class="category-wrapper">
                        <input v-model="selectedCategory" id="tab1" type="radio" name="tabs" value="Popular">
                        <label for="tab1">
                            <span>Popular
                            <i class="material-icons" style="vertical-align: middle;">whatshot</i>
                            </span>
                        </label>
                        <input v-model="selectedCategory" id="tab2" type="radio" name="tabs" value="Snacks">
                        <label for="tab2">Snacks</label>
                        <input v-model="selectedCategory" id="tab3" type="radio" name="tabs" value="Drinks">
                        <label for="tab3">Drinks</label>
                        <input v-model="selectedCategory" id="tab4" type="radio" name="tabs" value="School Supplies">
                        <label for="tab4">School Supplies</label>
                        <input v-model="selectedCategory" id="tab5" type="radio" name="tabs" value="Misc">
                        <label for="tab5">Misc</label>
                    </div>
                </div>
            </div>
            <div class="row">
                <LandingCard
                    v-for="product in filteredProducts"
                    :key="product.product_id"
                    :product="product"
                ></LandingCard>
            </div>
        </div>
        <LandingFooter></LandingFooter>
    </v-app>
</template>

<script>
    import LandingHeader from './mini-components/LandingHeader.vue';
    import LandingFooter from './mini-components/LandingFooter.vue';
    import LandingCard from './mini-components/LandingCard.vue';
    import ShoppingCart from './mini-components/ShoppingCart.vue';
    import axios from 'axios';
    import Toasted from 'vue-toasted';

    const api = axios.create({
        withCredentials: true,
    });


export default {
  data() {
    return {
      seen : false,
      products: {},
      selectedCategory: 'Popular',
    };
  },
  props: {},
  created: function loadProducts() {
    let loadingProductsToast = this.$toasted.show('Loading products...');
    axios
      .get('http://127.0.0.1:3000/api/products')
      .then((response) => {
        this.products = response.data;
        loadingProductsToast.text('Products loaded!').goAway(5000);
      })
      .catch((error) => {
          console.log(error);
        loadingProductsToast.goAway();
        this.$toasted.error('Something went wrong');
      });
  },
  computed: {
    filteredProducts() {
        var category = this.selectedCategory.toLowerCase().split(' ').join('_')
        console.log(`Category = ${category}`)
        if (category === 'popular' || !category){
            return this.products;
        } else {
            return this.products.filter((product) => {
                return product.category === category;
            });
        }
    },
},
  components: {
    LandingHeader: LandingHeader,
    LandingFooter: LandingFooter,
    LandingCard: LandingCard,
    ShoppingCart: ShoppingCart,
  },
  methods : {
    displayCart(show){
     if (this.seen)
      this.seen = false;
      else {
        this.seen = true;
      }
    }
  }

};
</script>

<style lang="scss">
    @import 'custom_css/landing.scss';
</style>
