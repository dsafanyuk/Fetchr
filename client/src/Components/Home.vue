<template >

<div id= "home">
  <Navigation> </Navigation>
  <router-view> </router-view>

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
</style>
