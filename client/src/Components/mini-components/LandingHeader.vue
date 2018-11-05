<template>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <div class="collapse navbar-collapse" id="navbarTogglerDemo03">
        <ul class="custom_url col-md-4 navbar-nav  mt-2 ">
          <li class="nav-item active">
            <img src="fetchr_logo.png" width="80" height="80" class="d-inline-block align-top"align="left">
          </li>
        </ul>
        <form class="col-md-4 form-inline my-2 my-lg-0">
          <input class="form-control mr-sm-2 " size="40" type="search" placeholder="Search" aria-label="Search">
          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
        </form>
        <div class="col-md-4 icons_div">
          <i class="far fa-user"></i>
          <i class="fas fa-shopping-cart"></i>
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
</style>
