<template>
      <!-- Image and text -->
      <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="collapse navbar-collapse" id="navbarTogglerDemo03">
          <ul class="custom_url col-md-4 navbar-nav  mt-2 ">
            <li class="nav-item active">
              <img src="/lil_logo.png" width="80" height="80" class="d-inline-block align-top"align="left">
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
               <a class="dropdown-item" href="#">Log Out</a>
               </div>
            <i class="fas fa-shopping-cart fa-2x"></i>
          </div>
        </div>
        </div>
      </nav>

</template>
<script>
export default {

  data () {
    name: "LandingHeader"
    return {

    }
  }
}
</script>

<style lang="css">
@import '../custom_css/landing.scss'
@import '..https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css'
@import '..https://use.fontawesome.com/releases/v5.4.1/css/all.css'
@import '..https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css'
@import '..https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js'
@import '..https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js'

.icons_div {
float : right ;
}

.btn_space {
  margin-right: 10px;
}


</style>
