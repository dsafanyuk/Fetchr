<template>
  <nav class="navbar navbar-expand-lg navbar-dark">
    <ShoppingCart v-model="showCart"></ShoppingCart>
    <Wallet
      v-model="showWallet"
      v-on:updateWallet="getWalletBalance()"
      :walletBalance="walletBalance"
    ></Wallet>
    <div class="collapse navbar-collapse" id="navbarTogglerDemo03">
      <ul class="custom_url col-md-4 navbar-nav mt-2">
        <li class="nav-item active">
          <router-link to="/dashboard">
            <img
              src="../images/fetchr_header_logo.png"
              height="70"
              class="d-inline-block align-top"
              align="left"
              to="/dashboard"
            >
          </router-link>
        </li>
      </ul>
      <div class="col-md-4">
        <input
          class="form-control mr-sm-2"
          size="30"
          type="search"
          placeholder="Search for a product"
          aria-label="Search"
          :value="search"
          @input="$emit('input', $event.target.value)"
        >
      </div>

      <div class="text-xs-right col-xs-1 offset-md-2">
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
      <div class="text-xs-right col-xs-1" id="shopping_cart" @click="showShoppingCart()">
        <v-btn fab color="#f9aa33">
          <v-icon color="white">shopping_cart</v-icon>
        </v-btn>
      </div>
    </div>
  </nav>
</template>
<script>
import Landing from "../Landing.vue";
import ShoppingCart from "./ShoppingCart.vue";
import Wallet from "./Wallet";
import browserCookies from "browser-cookies";
import axios from "axios";

const api = axios.create();

export default {
  props: ["search"],
  data() {
    name: "LandingHeader";
    return {
      firstName: browserCookies.get("first_name"),
      showWallet: false,
      showCart: false,
      walletBalance: "",
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
    this.getWalletBalance();
  },
  methods: {
    getWalletBalance: function() {
      api
        .get("/api/users/" + browserCookies.get("user_id") + "/wallet")
        .then(response => {
          this.walletBalance = response.data[0].wallet.toFixed(2);
          browserCookies.set("wallet", this.walletBalance);
        })
        .catch(err => {
          console.log(err.data);
          this.walletBalance = "error";
        });
      console.log("Retrieved wallet balance");
    },
    showShoppingCart: function() {
      this.$emit("showcart", "show");
      this.showCart = true;
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
          this.showWallet = true;
          break;
        }
        case "Logout":
          {
            let allCookies = browserCookies.all();
            for (let cookieName in allCookies) {
              browserCookies.erase(cookieName);
            }
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
@import "../custom_css/landing.scss";
@import "https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css";
@import "https://use.fontawesome.com/releases/v5.4.1/css/all.css";
@import "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css";

.icons_div {
  float: right;
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
