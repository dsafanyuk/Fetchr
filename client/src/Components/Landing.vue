<template>
  <div id="landing">
    <LandingHeader> </LandingHeader>
      <p>  Landing Body {{name}}  </p>


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
