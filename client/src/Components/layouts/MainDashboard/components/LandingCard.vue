<template>
  <div class="col-lg-3 col-md-4 col-sm-6 col-6">
    <div class="product-card">
      <div class="card z-depth-4 shadow">
        <div class="card-content">
          <span class="card-title text-center text-truncate heading"><b>{{product.product_name}}</b></span>
        </div>
        <div class="card-img">
          <img class="lozad" :data-src="product.product_url" :alt="product.product_name">
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
              v-if="inCart"
              id="cart_btn"
              block
              color="accent"
              v-on:click="incQuantity(product)"
              :ripple="false"
            >
              <v-icon medium color="white">add_shopping_cart</v-icon>
            </v-btn>
            <v-btn
              v-if="!inCart"
              id="cart_btn"
              block
              color="accent"
              v-on:click="addItem"
              :ripple="false"
            >
              <v-icon medium>add_shopping_cart</v-icon>
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
import lozad from "lozad";

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
      isFavorite: this.product.is_favorite
    };
  },
  components: {},
  watch: {},
  mounted() {
    // lazy load the image
    const observer = lozad();
    observer.observe();
  },
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
            this.isFavorite = "true";
            this.product.is_favorite = "true";
            this.$toasted
              .success("Added to favorites!", {
                theme: "bubble",
                position: "top-center",
                icon: "favorite",
                action: [
                  {
                    class: "toast-action",
                    text: "SHOW",
                    onClick: (e, toastObject) => {
                      toastObject.goAway(0);
                      this.$store.commit(
                        "dashboard/setSelectedCategory",
                        "Favorites"
                      );
                    }
                  },
                  {
                    icon: "clear",
                    onClick: (e, toastObject) => {
                      toastObject.goAway(0);
                    }
                  }
                ]
              })
              .goAway(5000);
          }
        })
        .catch(error => {
          console.log(error);
          this.$toasted
            .error("Error favoriting", {
              theme: "bubble",
              position: "top-center",
              icon: "report_problem"
            })
            .goAway(1000);
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
            this.$toasted
              .success("Removed from favorites!", {
                theme: "bubble",
                position: "top-center",
                icon: "favorite_border"
              })
              .goAway(1000);
          }
        })
        .catch(error => {
          console.log(error);
          this.$toasted
            .error("Error unfavoriting", {
              theme: "bubble",
              position: "top-center",
              icon: "report_problem"
            })
            .goAway(1000);
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
      this.$toasted
        .success(`${this.product.product_name} added to cart`, {
          theme: "bubble",
          position: "top-center",
          icon: "shopping_cart",
        })
        .goAway(1500);
      this.$store.commit("cart/addItem", this.product);
    },
    incQuantity: function(product) {
      this.$toasted
        .success(`${this.product.product_name} added to cart`, {
          theme: "bubble",
          position: "top-center",
          icon: "shopping_cart",
        })
        .goAway(1500);
      this.$store.commit("cart/incQuantity", product);
    }
  }
};
</script>

<style scoped lang="css" src="../../../custom_css/landing_card.scss">
.btn-floating {
  background-color: #344955 !important;
}
</style>
