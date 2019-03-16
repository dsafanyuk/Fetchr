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
      <v-list-tile
        :to="'/admin/dashboard'"
        avatar
        class="v-list-item"
        :active-class="'action-tile'"
      >
        <v-list-tile-title color="white" :active-class="'action-tile'" v-text="'Dashboard'"/>
      </v-list-tile>
      <v-list-group
        value="true"
        v-for="(link, i) in links"
        :key="i"
        no-action
        :active-class="color"
      >
        <template slot="activator">
          <v-list-tile :to="link.to" avatar class="v-list-item" :active-class="'action-tile'">
            <v-list-tile-title color="white" :active-class="'action-tile'" v-text="link.text"/>
          </v-list-tile>
        </template>

        <v-list-tile
          :to="actions.to"
          avatar
          class="v-list-item"
          v-for="(actions, i) in link.actions"
          :key="i"
          dark
          :active-class="color"
        >
          <v-list-tile-title :to="actions.to" append v-text="actions.text"/>
        </v-list-tile>
      </v-list-group>
    </v-layout>
  </v-navigation-drawer>
</template>

<script>
export default {
  data: () => ({
    links: [
      {
        to: "/admin/products",
        icon: "mdi-account",
        text: "Products",
        actions: [
          {
            to: "/admin/products/manage",
            text: "Manage"
          }
        ]
      },
      {
        to: "/admin/users",
        icon: "mdi-clipboard-outline",
        text: "Users",
        actions: [
          {
            to: "/admin/users/manage",
            text: "Manage"
          }
        ]
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
}
</style>
