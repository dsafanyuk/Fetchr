<template>
  <div class="main-toolbar">
    <ShoppingCart v-model="showCart"></ShoppingCart>
    <Wallet v-model="showWallet" :walletBalance="walletBalance"></Wallet>
    <v-toolbar color="primary">
      <v-menu>
        <v-icon slot="activator" class="hidden-md-and-up" medium color="white">fas fa-bars</v-icon>
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
              <v-list-tile-title
                v-if="menuItem.title == 'Wallet'"
                style="font-family:'Lucida Console', Monaco, monospace"
                @click="menuActions(menuItem.title)"
              >${{ walletBalance }}</v-list-tile-title>
              <v-list-tile-title v-else>
                <strong>{{ menuItem.title }}</strong>
              </v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>
        </v-list>
      </v-menu>
      <v-spacer class="hidden-md-and-up"></v-spacer>
      <router-link to="/dashboard" class="text-md-center">
        <img
          src="../../images/fetchr_header_logo.png"
          height="75"
          class="d-inline-block align-top navbar-brand"
          align="left"
          to="/dashboard"
        >
      </router-link>
      <v-spacer class="hidden-sm-and-down"></v-spacer>
      <v-spacer></v-spacer>
      <div class="hidden-sm-and-down">
        <v-menu fixed>
          <v-btn
            v-if="!firstName"
            flat
            slot="activator"
            color="white"
            light
          >Hi, error face &nbsp;&nbsp;▼</v-btn>
          <v-btn v-else flat slot="activator" color="white" light>Hi, {{ firstName }} &nbsp;&nbsp;▼</v-btn>
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
                <v-list-tile-title
                  v-if="menuItem.title == 'Wallet'"
                  style="font-family:'Lucida Console', Monaco, monospace"
                  @click="menuActions(menuItem.title)"
                >${{ walletBalance }}</v-list-tile-title>
                <v-list-tile-title v-else>
                  <strong>{{ menuItem.title }}</strong>
                </v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile>
          </v-list>
        </v-menu>
      </div>
      <div class="text-xs-right col-xs-4" @click="showShoppingCart(true)">
        <v-badge color="red" right overlap>
          <span slot="badge" v-if="numOfItemsInCart>0">{{numOfItemsInCart}}</span>
          <v-btn fab small color="#f9aa33" icon class="ma-0">
            <v-icon color="white">shopping_cart</v-icon>
          </v-btn>
        </v-badge>
      </div>
      <v-layout slot="extension" v-if="isLanding">
        <v-flex xs8 offset-xs2>
          <v-spacer></v-spacer>
          <input
            class="form-control"
            size="30"
            type="search"
            placeholder="Search for a product"
            aria-label="Search"
            :value="search"
            @input="$emit('input', $event.target.value)"
          >
        </v-flex>
      </v-layout>
    </v-toolbar>

    <v-tabs centered light icons-and-text v-model.lazy="active" show-arrows v-if="isLanding ">
      <v-tabs-slider color="orange"></v-tabs-slider>
      <v-tab href="#Popular">Popular
        <v-icon>fas fa-fire-alt</v-icon>
      </v-tab>

      <v-tab href="#Snacks">Snacks
        <v-icon>fas fa-hamburger</v-icon>
      </v-tab>

      <v-tab href="#Drinks">Drinks
        <v-icon>fas fa-mug-hot</v-icon>
      </v-tab>

      <v-tab href="#Personal">Personal
        <v-icon>fas fa-toilet-paper</v-icon>
      </v-tab>
      <v-tab href="#Electronics">Electronics
        <v-icon>fas fa-headphones-alt</v-icon>
      </v-tab>
      <v-tab href="#School Supplies">School Supplies
        <v-icon>fas fa-paperclip</v-icon>
      </v-tab>
      <v-tab href="#Misc">Misc
        <v-icon>fas fa-random</v-icon>
      </v-tab>

      <v-tab href="#Favorites">Favorites
        <v-icon>fas fa-heart</v-icon>
      </v-tab>
    </v-tabs>
  </div>
</template>
<script>
import ShoppingCart from "./ShoppingCart.vue";
import Wallet from "./Wallet.vue";
import browserCookies from "browser-cookies";

export default {
  props: ["search"],
  data() {
    name: "MainHeader";
    return {
      firstName: browserCookies.get("first_name"),
      showCart: false,
      extended: true,
      menu: [
        { title: "Account", icon: "fas fa-user-alt fa-s" },
        { title: "Orders", icon: "far fa-list-alt fa-s" },
        {
          title: "Wallet",
          icon: "fas fa-wallet fa-s"
        },
        {
          title: "Logout",
          icon: "fas fa-sign-out-alt fa-s"
        }
      ]
    };
  },
  components: {
    ShoppingCart: ShoppingCart,
    Wallet: Wallet
  },
  created: function() {
    this.$store.dispatch("wallet/getWalletBalance");
  },
  computed: {
    numOfItemsInCart: function() {
      return this.$store.getters["cart/totalCartItems"];
    },
    walletBalance: function() {
      return this.$store.getters["wallet/walletBalance"];
    },
    isLanding: function() {
      return this.$route.path == "/dashboard";
    }
  },
  methods: {
    toggleExtension: function() {
      this.extended = !this.extended;
    },
    showWallet: function(value) {
      this.$store.commit("wallet/toggleWallet", value);
    },

    showShoppingCart: function(value) {
      this.$store.commit("cart/toggleCart", value);
    },
    menuActions: function(menuItem) {
      switch (menuItem) {
        case "Account": {
          this.$router.push("/account");
          break;
        }
        case "Orders": {
          this.$router.push("/orders");
          break;
        }
        case "Wallet": {
          this.$store.commit("wallet/toggleWallet", true);
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
    },
    goToDashboard: function() {
      this.$router.push("/dashboard");
    }
  }
};
</script>

<style lang='css'>
@import "https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css";
@import "https://use.fontawesome.com/releases/v5.4.1/css/all.css";

.btn-txt {
  color: #fff !important;
}

.btn_space {
  margin-right: 10px;
}
nav {
  background-color: #232f34;
}

#shopping_cart {
  padding-left: 10px;
}
.main-toolbar {
  position: -webkit-sticky; /* Safari */
  position: sticky;
  top: 0;
  z-index: 100;
}
</style>
