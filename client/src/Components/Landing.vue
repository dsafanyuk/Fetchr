<template>
  <div id="landing">
    <LandingHeader> </LandingHeader>
    <div class="container-fluid">
      <div class="row">
        <!-- Filter zone -->
        <div class="col-md-3 filter_zone">
          <h6> Filter & Refine </h6></br>

          <div class="card">
            </br>
            <h6>Price</h6>
            <!-- Price Row -->
            <div class="row">
              <div class="col-md-5 col-sm-6">
                <input type="number" class="form-control" id="min_price" placeholder="Min">
              </div> -
              <div class="col-md-5 col-sm-6">
                <input type="number" class="form-control" id="max_price" placeholder="Max">
              </div>
            </div>
            <!-- Category Begin-->
            </br>
            <h6>Categories</h6>
            <div class="categoryZone">
              <div class="custom-control custom-checkbox">
                <input type="checkbox" class="custom-control-input" id="customCheck1">
                <label class="custom-control-label" for="customCheck1">Drinks	</label>
              </div>
              <div class="custom-control custom-checkbox">
                <input type="checkbox" class="custom-control-input" id="customCheck2">
                <label class="custom-control-label" for="customCheck2">Snacks</label>
              </div>
              <div class="custom-control custom-checkbox">
                <input type="checkbox" class="custom-control-input" id="customCheck3">
                <label class="custom-control-label" for="customCheck3">School Supplies</label>
              </div>
              <div class="custom-control custom-checkbox">
                <input type="checkbox" class="custom-control-input" id="customCheck4">
                <label class="custom-control-label" for="customCheck4">Misc</label>
              </div>
            </div>
          </div>






        </div>
        <div class="col-md-8">
        </div>
        <div class="col-md-2">
        </div>
      </div>
    </div>


    <LandingFooter> </LandingFooter>
  </div>
</template>

<script>
import LandingHeader from './LandingHeader.vue'
import LandingFooter from './LandingFooter.vue'


export default {

  data () {
    name: "landing"
    return {
      name: "Ok"
    }
  },
  components : {'LandingHeader': LandingHeader, 'LandingFooter' : LandingFooter}
}
</script>

<style lang="css">
@import 'custom_css/landing.scss'
</style>
