<template>
  <div class="col-lg-3 col-md-4 col-sm-6 col-6">
    <div class="product-card">
      <div class="card z-depth-4 shadow">
        <div class="card-content">
          <span class="card-title text-center text-truncate heading">{{product.product_name}}</span>
        </div>
        <div class="card-img">
          <img :src="product.product_url" :alt="product.product_name">
        </div>
        <hr>
        <h5 class="text-center headline">${{product.price.toFixed(2)}}</h5>
        <div style="display:flex" class="btn_container">
          <div class="favorite_button">
            <v-btn
              id="fave_btn"
              block
              color="primary"
              v-if="isFavorite == 'true'"
              v-on:click="unfavorite()"
              dark
              :ripple="false"
            >
              <v-icon medium>favorite</v-icon>
            </v-btn>
            <v-btn
              id="fave_btn"
              block
              color="primary"
              v-if="isFavorite == 'false'"
              v-on:click="favorite()"
              :ripple="false"
            >
              <v-icon medium>favorite_border</v-icon>
            </v-btn>
          </div>
          <div style="display:flex" class="cart_button">
            <v-btn
              id="cart_btn"
              depressed
              block
              color="accent"
              v-on:click="addItem"
              :ripple="false"
            >
              <v-icon medium v-if="inCart">check</v-icon>
              <v-icon medium v-if="!inCart">add_shopping_cart</v-icon>
            </v-btn>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "../../../../axios";
import Toasted from "vue-toasted";
import browserCookies from "browser-cookies";

export default {
  props: {
    product: {
      product_id: String,
      product_name: String,
      price: Number,
      category: String,
      product_url: String,
      is_favorite: Boolean
    }
  },
  data() {
    return {
      isFavorite: this.product.is_favorite,
      productDetail: this.product.is_favorite
    };
  },
  components: {},
  watch: {},
  computed: {
    // Check if item is in cart, returns boolean value
    inCart: function() {
      return this.$store.getters["cart/cartItems"].includes(this.product);
    }
  },
  methods: {
    favorite: function() {
      axios
        .post("api/users/favorite", {
          user_id: browserCookies.get("user_id"),
          product_id: this.product.product_id
        })
        .then(response => {
          if (response.status == 200) {
            console.log(response);
            this.isFavorite = "true";
            this.product.is_favorite = "true";
            this.$toasted.success("Added to favorites!").goAway(1000);
          }
        })
        .catch(error => {
          console.log(error);
          this.$toasted.error("Error favoriting").goAway(1000);
          if (error.response) {
            // The request was made and the server responded with a status code
            // that falls out of the range of 2xx
            console.log(error.response.data);
            console.log(error.response.status);
            console.log(error.response.headers);
          }
        });
    },
    unfavorite: function() {
      axios
        .post("/api/users/unfavorite", {
          user_id: browserCookies.get("user_id"),
          product_id: this.product.product_id
        })
        .then(response => {
          if (response.status == 200) {
            this.isFavorite = "false";
            this.product.is_favorite = "false";
            console.log(`After unfavoriting, isFavorite = ${this.isFavorite}`);
            this.$toasted.success("Removed from favorites!").goAway(1000);
          }
        })
        .catch(error => {
          console.log(error);
          this.$toasted.error("Error unfavoriting").goAway(1000);
          if (error.response) {
            // The request was made and the server responded with a status code
            // that falls out of the range of 2xx
            console.log(error.response.data);
            console.log(error.response.status);
            console.log(error.response.headers);
          }
        });
    },
    // Add item to cart
    addItem: function() {
      this.$toasted.success("Added to cart").goAway(1000);
      this.$store.commit("cart/addItem", this.product);
      this.$forceUpdate();
    }
  }
};
</script>

<style scoped lang="css" src="../../../custom_css/landing_card.scss">
.btn-floating {
  background-color: #344955 !important;
}
</style>
