<template>
  <nav class="navbar navbar-expand-lg navbar-dark">
    <div class="visible-xs text-xs-center" @click="showShoppingCart()">
      <v-btn fixed light round bottom raised color="lightened" class="floating-cart navbar-toggler">
        <span class="text--lighten-1 btn-text">Shopping Cart&nbsp;&nbsp;</span>
        <v-icon color="white">shopping_cart</v-icon>
      </v-btn>
    </div>
    <router-link to="/dashboard">
      <img
        src="../../images/fetchr_header_logo.png"
        height="70"
        class="d-inline-block align-top navbar-brand"
        align="left"
        to="/dashboard"
      >
    </router-link>

    <v-menu fixed left class="navbar-toggler ml-auto hidden-sm-up float-xs-right">
      <v-btn
        slot="activator"
        class="navbar-toggler ml-auto hidden-sm-up float-xs-right"
        color="primary"
        icon
      >
        <v-icon>fas fa-bars</v-icon>
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

    <ShoppingCart v-model="showCart"></ShoppingCart>
    <Wallet v-model="showWallet" :walletBalance="walletBalance"></Wallet>
    <div class="collapse navbar-collapse col-md-6 offset-md-3" id="navbarTogglerDemo03">
      <div class="col-md-6">
        <input
          v-if="isLanding"
          class="form-control mr-sm-2"
          size="30"
          type="search"
          placeholder="Search for a product"
          aria-label="Search"
          :value="search"
          @input="$emit('input', $event.target.value)"
        >
      </div>
      <div class="text-xs-right col-xs-1 offset-md-5">
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
      <div class="text-xs-right col-xs-1" id="shopping_cart" @click="showShoppingCart(true)">
        <v-btn fab color="#f9aa33">
          <v-icon color="white">shopping_cart</v-icon>
        </v-btn>
      </div>
    </div>
  </nav>
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
    walletBalance: function() {
      return this.$store.getters["wallet/walletBalance"];
    },
    isLanding: function() {
      return this.$route.path == "/dashboard";
    }
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
            window.location.href = "http://127.0.0.1:8080/login";
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
@import "../../custom_css/landing.scss";

.icons_div {
  float: right;
}
.floating-cart {
  display: block;
  text-align: center;
  left: 25%;
  margin-right: auto;
  z-index: 100;
}
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
</style>
