<template>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <div class="collapse navbar-collapse" id="navbarTogglerDemo03">
        <ul class="custom_url col-md-4 navbar-nav  mt-2 ">
          <li class="nav-item active">
            <img src="https://s3.us-east-2.amazonaws.com/fetchrapp/Logo.png" width="80" height="80" class="d-inline-block align-top"align="left">
          </li>
        </ul>
        <form class="col-md-4 form-inline my-2 my-lg-0">
          <input class="form-control mr-sm-2 " size="40" type="search" placeholder="Search" aria-label="Search">
        </form>
        <div class="col-md-4 icons_div">
          <div class="col-md-3">
          </div>
          <div class="col-md-4" style="display: -webkit-inline-box;">
          <i class="far fa-user fa-xs"></i>
       <li class="dropdown">
         <a href="#" class="" data-toggle="dropdown" role="button" aria-expanded="false"> <i class="fas fa-shopping-cart fa-xs"></i> </a>
         <ul class="dropdown-menu dropdown-cart" role="menu">
             <li>
                 <span class="item">
                   <span class="item-left">
                       <img src="http://lorempixel.com/50/50/" alt="" />
                       <span class="item-info">
                           <span>Item name</span>
                           <span>23$</span>
                       </span>
                   </span>
                   <span class="item-right">
                       <button class="btn btn-xs btn-danger pull-right">x</button>
                   </span>
               </span>
             </li>
             <li>
                 <span class="item">
                   <span class="item-left">
                       <img src="http://lorempixel.com/50/50/" alt="" />
                       <span class="item-info">
                           <span>Item name</span>
                           <span>23$</span>
                       </span>
                   </span>
                   <span class="item-right">
                       <button class="btn btn-xs btn-danger pull-right">x</button>
                   </span>
               </span>
             </li>
             <li>
                 <span class="item">
                   <span class="item-left">
                       <img src="http://lorempixel.com/50/50/" alt="" />
                       <span class="item-info">
                           <span>Item name</span>
                           <span>23$</span>
                       </span>
                   </span>
                   <span class="item-right">
                       <button class="btn btn-xs btn-danger pull-right">x</button>
                   </span>
               </span>
             </li>
             <li>
                 <span class="item">
                   <span class="item-left">
                       <img src="http://lorempixel.com/50/50/" alt="" />
                       <span class="item-info">
                           <span>Item name</span>
                           <span>23$</span>
                       </span>
                   </span>
                   <span class="item-right">
                       <button class="btn btn-xs btn-danger pull-right">x</button>
                   </span>
               </span>
             </li>
             <li class="divider"></li>
             	<button type="button" class="btn btn-success">Success</button>
         </ul>
       </li>
          </div>
        </div>
      </div>

    </nav>

</template>
<script>

export default {
  data() {
    name: 'LandingHeader';
    return {};
  },
};

</script>

<style scoped lang="scss">
@import '../custom_css/landing.scss';
</style>
