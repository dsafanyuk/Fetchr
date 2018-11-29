<template>
  <li class="clearfix">
    <img v-bind:src="Item.product_url" width="70px" height="70px" alt="item1" />
    <span class="item-name">{{Item.product_name}}</span>
    <span class="item-price">{{Item.price}}</span>
    <span class="item-quantity">1</span>
  </li>
</template>
<script>


export default {
  props: {
    Item : {
      product_name   : String,
      price          : Number,
      product_url    : String,

    }
  },
  data() {
    return {};
  }
};
</script>

<style scoped lang="scss">
  @import '../custom_css/ShoppingCart.scss';
</style>
