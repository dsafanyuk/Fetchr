<template>
  <v-app>
    <LandingHeader v-on:showcart="displayCart" v-model="search_input"></LandingHeader>
    <ShoppingCart v-if="seen"></ShoppingCart>
    <div class="category-wrapper shadow">
      <v-tabs centered light icons-and-text v-model.lazy="active" show-arrows max>
        <v-tabs-slider color="orange"></v-tabs-slider>
        <v-tab href="#Popular">Popular
          <v-icon>fas fa-fire-alt</v-icon>
        </v-tab>

        <v-tab href="#Snacks">Snacks
          <v-icon>fas fa-hamburger</v-icon>
        </v-tab>

        <v-tab href="#Drinks">Drinks
          <v-icon>fas fa-mug-hot</v-icon>
        </v-tab>

        <v-tab href="#Personal">Personal
          <v-icon>fas fa-toilet-paper</v-icon>
        </v-tab>
        <v-tab href="#Electronics">Electronics
          <v-icon>fas fa-headphones-alt</v-icon>
        </v-tab>
        <v-tab href="#School Supplies">School Supplies
          <v-icon>fas fa-paperclip</v-icon>
        </v-tab>
        <v-tab href="#Misc">Misc
          <v-icon>fas fa-random</v-icon>
        </v-tab>

        <v-tab href="#Favorites">Favorites
          <v-icon>fas fa-heart</v-icon>
        </v-tab>
      </v-tabs>
    </div>
    <div class="container-fluid">
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
import LandingHeader from "./mini-components/LandingHeader.vue";
import LandingFooter from "./mini-components/LandingFooter.vue";
import LandingCard from "./mini-components/LandingCard.vue";
import ShoppingCart from "./mini-components/ShoppingCart.vue";
import browserCookies from "browser-cookies";
import axios from "axios";
import Toasted from "vue-toasted";

const api = axios.create();

export default {
  data() {
    return {
      active: "Popular",
      seen: false,
      products: [],
      interval: null,
      search_input: "",
      snacksProducts: [],
      drinksProducts: [],
      personalProducts: [],
      electronicsProducts: [],
      school_suppliesProducts: [],
      miscProducts: [],
      favoriteProducts: []
    };
  },
  created: function loadProducts() {
    let loadingProductsToast = this.$toasted.show("Loading products...");
    api
      .get(`/api/products`, {
        headers: {
          user_id: browserCookies.get("user_id")
        }
      })
      .then(response => {
        this.products = response.data;
        loadingProductsToast.text("Products loaded!").goAway(500);
      })
      .catch(error => {
        if (error.response) {
          console.log(error.response.data);
          console.log(error.response.status);
          console.log(error.response.headers);
        } else if (error.request) {
          console.log(error.request);
        } else {
          // Something happened in setting up the request that triggered an Error
          console.log("Error", error.message);
        }
        loadingProductsToast.goAway();
        this.$toasted.error("Something went wrong");
      });
  },
  computed: {
    filteredProducts() {
      if (this.search_input) {
        return this.products.filter(product => {
          return (
            product.product_name
              .toLowerCase()
              .includes(this.search_input.toLowerCase()) ||
            product.category
              .toLowerCase()
              .includes(this.search_input.toLowerCase())
          );
        });
      }
      var category = this.active
        .toLowerCase()
        .split(" ")
        .join("_");
      if (category === "popular" || !category) {
        return this.products;
      } else if (category === "favorites") {
        return this.products.filter(product => {
          return product.is_favorite == "true";
        });
      } else {
        return this.products.filter(product => {
          return product.category === category;
        });
      }
    }
  },
  components: {
    LandingHeader: LandingHeader,
    LandingFooter: LandingFooter,
    LandingCard: LandingCard,
    ShoppingCart: ShoppingCart
  },
  methods: {
    displayCart(show) {
      if (this.seen) this.seen = false;
      else {
        this.seen = true;
      }
    },
    sortProducts() {
      let allProducts = this.products;
      this.snacksProducts = allProducts.filter(product => {
        allProducts.splice(
          allProducts.indexOf(allProducts[product]),
          allProducts.indexOf(allProducts[product]) + 1
        );
        return product.category == "snacks";
      });
      this.drinksProducts = allProducts.filter(product => {
        allProducts.splice(
          allProducts.indexOf(allProducts[product]),
          allProducts.indexOf(allProducts[product]) + 1
        );

        return product.category == "drinks";
      });
      this.personalProducts = allProducts.filter(product => {
        allProducts.splice(
          allProducts.indexOf(allProducts[product]),
          allProducts.indexOf(allProducts[product]) + 1
        );
        return product.category == "personal";
      });
      this.electronicsProducts = allProducts.filter(product => {
        console.log(allProducts.indexOf(allProducts[product]));
        return product.category == "electronics";
      });
      this.school_suppliesProducts = allProducts.filter(product => {
        allProducts.splice(
          allProducts.indexOf(allProducts[product]),
          allProducts.indexOf(allProducts[product]) + 1
        );
        return product.category == "school_supplies";
      });
      this.miscProducts = allProducts.filter(product => {
        console.log(allProducts.indexOf(allProducts[product]));
        return product.category == "misc";
      });
    }
  }
};
</script>

<style lang="scss">
@import "custom_css/landing.scss";
a {
  text-decoration: none !important;
}
a:hover {
  color: #4a6572 !important;
}
</style>
