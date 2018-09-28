<template>
  <div id="app">
    <div class="alert alert-primary" role="alert">
      A simple primary alert with <a href="#" class="alert-link">an example link</a>. Give it a click if you like.
    </div>
  </div>
</template>

<script>
export default {
  name: 'app',
  data () {
    return {
      msg: 'Welcome to Your Vue.js App'
    }
  }
}
</script>

<style lang="scss">
@import 'css/home.scss'
</style>
