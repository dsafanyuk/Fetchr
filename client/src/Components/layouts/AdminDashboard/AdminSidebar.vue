<template>
  <v-navigation-drawer
    id="app-drawer"
    app
    dark
    class="primary"
    floating
    persistent
    mobile-break-point="991"
    width="260"
  >
    <v-layout class="fill-height" tag="v-list" column>
      <v-list-tile avatar>
        <v-list-tile-avatar>
          <v-icon medium>fas fa-user-cog</v-icon>
        </v-list-tile-avatar>
        <v-list-tile-title class="title">Admin Panel</v-list-tile-title>
      </v-list-tile>
      <v-divider/>
      <v-list-tile :to="'/admin'" avatar class="v-list-item" active-class="white--text">
        <v-list-tile-title v-text="'Dashboard'"/>
        <i
          class="material-icons"
          color="white"
          @click="$store.dispatch('admin/getDashboard')"
        >refresh</i>
      </v-list-tile>
      <v-list-group v-for="(link, i) in links" :key="i" append-icon>
        <template slot="activator">
          <v-list-tile :to="link.to" active-class="accent--text">
            <v-list-tile-title color="white" v-text="link.text"/>
          </v-list-tile>
        </template>
      </v-list-group>
    </v-layout>
  </v-navigation-drawer>
</template>

<script>
export default {
  data: () => ({
    links: [
      {
        to: "/admin/products/manage",
        icon: "mdi-account",
        text: "Products"
      },
      {
        to: "/admin/users/manage",
        icon: "mdi-clipboard-outline",
        text: "Users"
      }
    ],
    responsive: false,
    color: "accent"
  })
};
</script>

<style lang="scss" scoped>
#app-drawer {
  .v-list__tile {
    border-radius: 4px;
    &--buy {
      margin-top: auto;
      margin-bottom: 17px;
    }
  }
  .v-image__image--contain {
    top: 9px;
    height: 60%;
  }
  .search-input {
    margin-bottom: 30px !important;
    padding-left: 15px;
    padding-right: 15px;
  }
  :hover {
    color: white;
    text-decoration: none;
  }
}
.active-boi {
  text-decoration: underline;
}
</style>
