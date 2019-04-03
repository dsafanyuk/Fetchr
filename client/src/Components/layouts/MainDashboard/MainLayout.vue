<template>
  <v-app>
    <MainHeader></MainHeader>
    <router-view id="main"></router-view>
    <MainFooter></MainFooter>
  </v-app>
</template>

<script>
import MainHeader from "./MainHeader.vue";
import MainFooter from "./MainFooter.vue";

export default {
  data() {
    return {};
  },
  components: {
    MainHeader: MainHeader,
    MainFooter: MainFooter
  }
};
</script>
<style>
.toasted.bubble .action {
  color: white;
}
.toasted.bubble {
  background-color: #4a6572;
}

#main {
  flex: 1;
}
</style>

