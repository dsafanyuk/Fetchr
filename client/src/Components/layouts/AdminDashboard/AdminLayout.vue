<template>
  <v-app>
    <AdminHeader></AdminHeader>
    <AdminSideBar></AdminSideBar>
    <v-content>
      <div id="core-view">
        <v-fade-transition mode="out-in">
          <router-view/>
        </v-fade-transition>
      </div>
    </v-content>
    <AdminFooter></AdminFooter>
  </v-app>
</template>

<script>
import AdminFooter from "./AdminFooter.vue";
import AdminHeader from "./AdminHeader.vue";
import AdminSideBar from "./AdminSideBar.vue";
import AdminDashboard from "./components/AdminDashboard.vue";

export default {
  components: {
    AdminFooter,
    AdminDashboard,
    AdminSideBar,
    AdminHeader
  }
};
</script>

<style lang="scss" scoped>
a:hover {
  color: #fff !important;
  text-decoration: none !important;
}
</style>
