<template>
  <div id="landing_card" class="col-md-3">
     <div class="thumb">
           <img src="https://cdn.vuetifyjs.com/images/cards/desert.jpg" alt="Barcelona" width="250px" height="150px">
     </div>
     <div class="details">
        <div class="row">
  	     <div class=" col-md-8 col-xs-9">
              <span> Product Name</span>
  		 </div>
  		 <div class=" col-md-4 col-xs-3 links">
              <a href="#"><i class="far fa-heart fa_la"></i></a>
           </div>
  		 <br></br>
  	  </div>
        <div class="bottom-details">
  	     <div class="price">$19.99</div>
  	     <div class="links">
  	        <a href=""><i class="fa fa-shopping-cart fa-md"></i></a>
  	     </div>
        </div>
     </div>
  </div>
</template>

<script>
  export default {
    data() {
      return {

      }
    }
  }
</script>

<style lang="css">
  @import 'custom_css/landing_card.scss'
</style>
