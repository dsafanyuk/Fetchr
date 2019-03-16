<template>
  <v-app>
    <CourierHeader></CourierHeader>
    <CourierDashboard></CourierDashboard>
  </v-app>
</template>

<script>
import CourierHeader from "./CourierHeader.vue";
import CourierDashboard from "./components/CourierDashboard.vue";

export default {
  components: {
    CourierHeader: CourierHeader,
    CourierDashboard: CourierDashboard
  }
};
</script>

<style lang="css">
@import "/src/Components/assets/css/bootstrap.min.css";
</style>
