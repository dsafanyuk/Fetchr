<template>
  <div id="landing_card" class=" card_prop col-md-3 col-xs-2">
     <div class="thumb">
          <ProductInfo>

           </ProductInfo>
     </div>
     <div class="details">
        <div class="row">
  	     <div class=" col-md-8 col-xs-9">
              <span>{{product.product_name}}</span>
  		 </div>
  		 <div class=" col-md-4 col-xs-3 links">
              <a href="#"><i class="far fa-heart fa_la"></i></a>
           </div>
  		 <br><br>
  	  </div>
        <div class="bottom-details">
  	     <div class="price">{{product.price}}</div>
  	     <div class="links">
  	        <a href=""><i class="fa fa-shopping-cart fa-md"></i></a>
  	     </div>
        </div>
     </div>

  </div>
</template>

<script>
import ProductInfo from './ProductInfo.vue';

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
    };
  },
  components: {
    ProductInfo: ProductInfo,
  },
};
</script>

<style lang="css">
@import '../custom_css/landing_card.scss';
</style>
