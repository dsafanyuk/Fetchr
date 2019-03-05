<template>
  <v-app class="scroll-y">
    <!-- Product list -->
    <v-container>
      <v-layout class="row">
        <LandingCard
          v-for="product in filteredProducts"
          :key="product.product_id"
          :product="product"
        ></LandingCard>
      </v-layout>
    </v-container>
  </v-app>
</template>

<script>
import LandingCard from "./LandingCard.vue";
import ShoppingCart from "../ShoppingCart.vue";
import browserCookies from "browser-cookies";
import axios from "../../../../axios";
import Toasted from "vue-toasted";

export default {
  props: ["search", "selectedCategory"],
  data() {
    return {
      products: [],
      interval: null,
      snacksProducts: [],
      drinksProducts: [],
      personalProducts: [],
      electronicsProducts: [],
      school_suppliesProducts: [],
      miscProducts: [],
      favoriteProducts: []
    };
  },
  mounted: function loadProducts() {
    let loadingProductsToast = this.$toasted.show("Loading products...");
    axios
      .get(`/api/products`)
      .then(response => {
        this.products = response.data;
        loadingProductsToast.text("Products loaded!").goAway(500);
        this.sortProducts();
      })
      .catch(error => {
        if (error.response) {
          console.log(error);
          loadingProductsToast.goAway();
          this.$toasted.error("Something went wrong");
        }
      });
  },
  computed: {
    filteredProducts() {
      if (this.search) {
        return this.products.filter(product => {
          return (
            product.product_name
              .toLowerCase()
              .includes(this.search.toLowerCase()) ||
            product.category.toLowerCase().includes(this.search.toLowerCase())
          );
        });
      }
      var category = this.selectedCategory
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
    LandingCard: LandingCard,
    ShoppingCart: ShoppingCart
  },
  methods: {
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
        return product.category == "misc";
      });
    }
  }
};
</script>

<style lang="scss">
@import "../../../custom_css/landing.scss";
a {
  text-decoration: none !important;
}
</style>
