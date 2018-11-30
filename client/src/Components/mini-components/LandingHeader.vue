<template>
      <!-- Image and text -->
      <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="collapse navbar-collapse" id="navbarTogglerDemo03">
          <ul class="custom_url col-md-4 navbar-nav  mt-2 ">
            <li class="nav-item active">
              <img src="../images/fetchr_header_logo.png"  height="70" class="d-inline-block align-top" align="left">
            </li>
          </ul>
          <form class="col-md-4 form-inline my-2 my-lg-0">
            <input class="form-control mr-sm-2 " size="40" type="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-dark my-2 my-sm-0" type="submit">Search</button>
          </form>
          <div class="col-md-4 ">
            <div class=" icons_div btn-group " style=" float: right;">
             <button type="button" class="btn btn-secondary">Hi Josh!</button>
             <button type="button" class="btn btn-secondary btn_space dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
             <span class="sr-only">Toggle Dropdown</span>
            </button>
               <div class="dropdown-menu">
               <a class="dropdown-item" href="#">My Account</a>
               <a class="dropdown-item" href="#">My Orders</a>
               <div class="dropdown-divider"></div>
               <a v-on:click='logout()' class="dropdown-item" href="#">Log Out</a>
               </div>
          <a id="cart" href="#" v-on:click="showShoppingCart"> <i id="cart" class="fas fa-shopping-cart fa-xs"></i></a>
          </div>
        </div>
      </div>
    </nav>

</template>
<script>
import Landing from '../Landing.vue';
import ShoppingCart from './ShoppingCart.vue'
import browsercookies from 'browser-cookies';

export default {
  data() {
    name: 'LandingHeader';
    return {};
  },
  components: {
    ShoppingCart: ShoppingCart
  },
  methods: {
    showShoppingCart: function  ()
    {

      this.$emit('showcart', 'show');
    },

    logout: function() {
        browsercookies.erase('userId');
        browsercookies.erase('authCookie');
        this.$router.push('/login');
    }
  }
};
</script>

<style lang="css">
@import '../custom_css/landing.scss'
@import 'https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css'
@import 'https://use.fontawesome.com/releases/v5.4.1/css/all.css'
@import 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css'
@import 'https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js'
@import 'https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js'

.icons_div {
float : right ;
}

.btn_space {
  margin-right: 10px;
}
</style>
