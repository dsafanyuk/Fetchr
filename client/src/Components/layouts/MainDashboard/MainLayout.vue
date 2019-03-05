<template>
  <v-app>
    <MainHeader v-model="search" @selectedCategory="selectedCategory = $event"></MainHeader>
    <router-view :search="search" :selectedCategory="selectedCategory"></router-view>
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
      selectedCategory: "Popular"
    };
  },
  components: {
    MainHeader: MainHeader,
    MainFooter: MainFooter
  },
  methods: {
    console: function(value) {
      console.log(value);
    }
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

