<template>
  <v-app>
    <MainHeader
      v-model="search"
    ></MainHeader>
    <router-view
      id="main"
      :search="search"
    ></router-view>
    <MainFooter></MainFooter>
  </v-app>
</template>

<script>
import MainHeader from "./MainHeader.vue";
import MainFooter from "./MainFooter.vue";

export default {
  data() {
    return {
      search: "",
    };
  },
  watch: {},
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

