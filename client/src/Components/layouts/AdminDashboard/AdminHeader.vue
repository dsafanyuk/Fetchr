<template>
  <div>
    <v-navigation-drawer v-model="drawer" absolute floating temporary>
      <v-list class="pa-1" style="cursor: pointer">
        <v-list-tile
          v-for="menuItem in menu"
          :key="menuItem.title"
          @click="menuActions(menuItem.title)"
        >
          <v-list-tile-action>
            <v-icon>{{ menuItem.icon }}</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>
              <strong>{{ menuItem.title }}</strong>
            </v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </v-list>
    </v-navigation-drawer>
    <div>
      <v-toolbar dark color="primary">
        <v-toolbar-side-icon class="hidden-lg-and-up" @click.stop="drawer = !drawer" large></v-toolbar-side-icon>
        <v-spacer></v-spacer>

        <router-link to="/admin/dashboard" class="text-md-center">
          <img
            src="../../images/fetchr_header_logo.png"
            height="75"
            width="250"
            class="d-inline-block align-top navbar-brand"
            align="left"
            to="/admin/dashboard"
          >
        </router-link>
        <v-spacer></v-spacer>
        <div class="hidden-md-and-down">
          <v-menu fixed bottom left>
            <v-btn flat slot="activator" color="white" light>
              Hi {{firstName}} &nbsp;&nbsp;&nbsp;
              <v-icon>fas fa-user-alt fa-s</v-icon>
            </v-btn>
            <v-list dense class="pt-0" style="cursor: pointer">
              <v-list-tile
                v-for="menuItem in menu"
                :key="menuItem.title"
                @click="menuActions(menuItem.title)"
              >
                <v-list-tile-action>
                  <v-icon>{{ menuItem.icon }}</v-icon>
                </v-list-tile-action>
                <v-list-tile-content>
                  <v-list-tile-title>
                    <strong>{{ menuItem.title }}</strong>
                  </v-list-tile-title>
                </v-list-tile-content>
              </v-list-tile>
            </v-list>
          </v-menu>
        </div>
      </v-toolbar>
    </div>
  </div>
</template>

<script>
import browserCookies from "browser-cookies";
export default {
  data() {
    return {
      drawer: false,
      firstName: browserCookies.get("first_name"),
      items: [
        { title: "Home", icon: "dashboard" },
        { title: "About", icon: "question_answer" }
      ],
      menu: [
        { title: "Switch to Shopping Mode", icon: "shopping_cart " },
        {
          title: "Logout",
          icon: "fas fa-sign-out-alt fa-s"
        }
      ]
    };
  },
  methods: {
    showWallet: function(value) {
      this.$store.commit("wallet/toggleWallet", value);
    },

    showShoppingCart: function(value) {
      this.$store.commit("cart/toggleCart", value);
    },
    menuActions: function(menuItem) {
      switch (menuItem) {
        case "Switch to Shopping Mode": {
          this.$router.push("/dashboard");
          break;
        }
        case "Logout":
          {
            let allCookies = browserCookies.all();
            for (let cookieName in allCookies) {
              browserCookies.erase(cookieName);
            }
            this.$store.dispatch("login/logout");
            this.$router.push("/login");
          }
          break;
      }
    }
  }
};
</script>

<style scoped="true">
</style>
