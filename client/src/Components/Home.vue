<template >

<div class="container-fluid" id= "home">

  <Navigation> </Navigation>
  <router-view> </router-view>

  <div class="row ">
    <div class="header_top col-md-12 ">
      <nav class="navbar navbar-light">
        <a class="navbar-brand" href="#">
          <img src="/docs/4.0/assets/brand/bootstrap-solid.svg" width="30" height="30" class="d-inline-block align-top" alt="">
              Fetchr
        </a>
      </nav>
   </div>


  </div>


</div>

</template>

<script>
import Navigation from './Navigation.vue'

export default {
  data () {
    return {}
  },
  components : {'Navigation': Navigation}
}
</script>

<style scoped>
@import 'custom_css/home.scss'
</style>
