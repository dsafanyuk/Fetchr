<template>
  <v-app>
    <MainHeader v-model="search"></MainHeader>
    <router-view :search="search"></router-view>
    <MainFooter></MainFooter>
  </v-app>
</template>

<script>
import MainHeader from "./MainHeader.vue";
import MainFooter from "./MainFooter.vue";

export default {
  data() {
    return {
      search: ""
    };
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
</style>

