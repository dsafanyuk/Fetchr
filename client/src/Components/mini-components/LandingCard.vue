<template>
<div class="col-lg-3 m8 s12 offset-m2">
    <div class="product-card">
        <div class="card  z-depth-4">
            <div class="card-img">
                <span href="#" class="btn-floating btn-large price waves-effect waves-light brown darken-3">{{product.price}}</span>
                <img :src=product.product_url :alt=product.product_name>
            </div>
                <ul class="card-action-buttons">
                    <li><a v-on:click="favorite()" id="favorite" class="btn-floating waves-effect waves-light red accent-2">
                            <i v-if="isFavorite" class="material-icons like">favorite</i>
                            <i v-if="!isFavorite" class="material-icons like">favorite_border</i>
                        </a>
                    </li>
                    <li><a v-on:click="addToCart()" id="buy" class="btn-floating waves-effect waves-light blue">
                            <i v-if="inCart" class="material-icons buy">check</i>
                            <i v-if="!inCart" class="material-icons buy">add_shopping_cart</i>
                        </a>
                    </li>
                </ul>
                <div class="card-content">
                    <div class="row">
                        <div class="col s12">
                            <p>
                                <span class="card-title text-center">
                <span>{{product.product_name}}</span></span> <br />
                        </p>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import Toasted from 'vue-toasted';

export default {
  props: {
    product: {
      product_id: String,
      product_name: String,
      price: Number,
      category: String,
      product_url: String,
    },
  },
  data() {
    return {
      isFavorite: false,
      inCart: false,
    };
  },
  components: {},
  methods: {
    favorite: function() {
      if (this.isFavorite) {
        this.isFavorite = false;
        this.$toasted.success('Unfavorited').goAway(1000);
      } else {
        this.isFavorite = true;
        this.$toasted.success('Favorited').goAway(1000);
      }
    },
    addToCart: function() {
      if (this.inCart) {
        this.inCart = false;
        this.$toasted.success('Removed from cart').goAway(1000);
      } else {
        this.inCart = true;
        this.$toasted.success('Added to cart').goAway(1000);
      }
    },
  },
};
</script>

<style scoped lang="css">
@import '../custom_css/landing_card.scss';
@import url('https://fonts.googleapis.com/icon?family=Material+Icons');
@import '../custom_css/materialize.css';
</style>
