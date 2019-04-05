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
        <v-spacer class="hidden-lg-and-up"></v-spacer>
        <img
          :src="require('../../images/fetchr_header_logo.png')"
          style="height:65px; width:215px;"
        >
        <v-spacer></v-spacer>
        <v-flex align-self-center style="margin-right:10px" class="hidden-sm-and-down">
            <transition name="fade" v-on:enter="enter" v-on:leave="leave">
                <h4 class="white--text" style="margin-top: 10px" v-if="show">{{showText}}</h4>
            </transition>
        </v-flex>
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
        { title: "Leave Feedback", icon: "feedback" },
        {
          title: "Logout",
          icon: "fas fa-sign-out-alt fa-s"
        }
      ],
      textLists: [
        "Remember, you cannot change your password",
        "You can go to shopping page by clicking Fetchr icon",
        "All items are non refundable",
        "Try favoriting an item",
        "Test inputs to handle too many char/numbers"
      ],
      showText: "",
      textTimeout: null,
      show: false,
      indexText: 0,
    };
  },
  created: function() {
    this.$store.dispatch("wallet/getWalletBalance");
    this.showText = this.textLists[this.randomIndex()];
    this.textTimeout = setTimeout(() => {
      this.show = true;
    },3000);
  },
  methods: {
    enter: function() {
      this.textTimeout = setTimeout(() => {
        this.show = false;
      }, 6000);
    },
    leave: function() {
      this.textTimeout = setTimeout(() => {
        do {
          this.indexText = this.randomIndex();
        } while (this.showText == this.textLists[this.indexText]);
        this.showText = this.textLists[this.indexText];
        this.show = true;
      }, 3000);
    },
    randomIndex: function () {
      return Math.floor(Math.random() * this.textLists.length)
    },
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
        case "Leave Feedback": {
          window.open("https://goo.gl/forms/Q1EzTiaBkPZwepb62");
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
