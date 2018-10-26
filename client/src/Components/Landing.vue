<template>

  <body id="landing">
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
      <div class="card_container col-md-9 ">
        <LandingCard> </LandingCard>
        <LandingCard> </LandingCard>
        <LandingCard> </LandingCard>
        <LandingCard> </LandingCard>
      </div>
      <div class="col-md-3">
          <ProductInfo></ProductInfo>
      </div>
    </div>


    <LandingFooter> </LandingFooter>
  </body>
</template>

<script>
  import LandingHeader from './LandingHeader.vue'
  import LandingFooter from './LandingFooter.vue'
  import LandingCard   from './LandingCard.vue'
  import ProductInfo   from './ProductInfo.vue'


  export default {

    data() {
      name: "landing"
      return {
        name: "Ok"
      }
    },
    components: {
      'LandingHeader': LandingHeader,
      'LandingFooter': LandingFooter,
      'LandingCard'  : LandingCard,
      'ProductInfo'  : ProductInfo
    }
  }
</script>

<style lang="css">
  @import 'custom_css/landing.scss'
</style>
