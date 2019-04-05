<template>
  <div class="main-toolbar shadow">
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
      <v-spacer></v-spacer>
      <v-flex
        v-on:click="scrollToTop"
        align-self-center
        style="margin-left: 100px"
        class="hidden-sm-and-down"
      >
        <transition name="fade" v-on:enter="enter" v-on:leave="leave">
          <h4 class="white--text" style="margin-top: 20px" v-if="show">{{showText}}</h4>
        </transition>
      </v-flex>
      <div class="hidden-sm-and-down">
        <v-btn v-on:click="goToDashboard" depressed icon>
          <v-icon color="white">home</v-icon>
        </v-btn>
        <v-menu id="customer_menu" fixed bottom offset-y class="active_menu">
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
      <v-layout slot="extension" v-if="isLanding" height="25px">
        <v-flex xs6 offset-xs3>
          <v-spacer></v-spacer>
          <v-text-field
            name="search"
            v-model="searchTerm"
            label="Search for a product"
            color="white"
            dark
            clearable
            outline
          ></v-text-field>
        </v-flex>
      </v-layout>
    </v-toolbar>

    <v-tabs
      centered
      light
      icons-and-text
      v-model="selectedCategory"
      show-arrows
      v-if="isLanding "
      slider-color="accent"
    >
      <v-tab v-for="(category) in categories" :key="category.name" :href="'#' + category.name">
        {{category.name}}
        <v-icon>{{category.icon}}</v-icon>
      </v-tab>
    </v-tabs>
  </div>
</template>
<script>
import ShoppingCart from "./ShoppingCart.vue";
import Wallet from "./Wallet.vue";
import browserCookies from "browser-cookies";
import Vue from "vue";

export default {
  data() {
    name: "MainHeader";
    return {
      firstName: browserCookies.get("first_name"),
      showCart: false,
      categories: [
        {
          name: "Popular",
          icon: "fas fa-fire-alt"
        },
        {
          name: "Snacks",
          icon: "fas fa-hamburger"
        },
        {
          name: "Drinks",
          icon: "fas fa-mug-hot"
        },
        {
          name: "Personal",
          icon: "fas fa-toilet-paper"
        },
        {
          name: "Electronics",
          icon: "fas fa-headphones-alt"
        },
        {
          name: "Misc",
          icon: "fas fa-random"
        },
        {
          name: "Favorites",
          icon: "fas fas fa-heart"
        }
      ],
      menu: [
        { title: "Switch To Courier", icon: "fa fa-truck" },
        { title: "Account", icon: "fas fa-user-alt fa-s" },
        { title: "Orders", icon: "far fa-list-alt fa-s" },
        {
          title: "Wallet",
          icon: "fas fa-wallet fa-s"
        },
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
      indexText: 0
    };
  },
  components: {
    ShoppingCart: ShoppingCart,
    Wallet: Wallet
  },
  created: function() {
    this.$store.dispatch("wallet/getWalletBalance");
    this.showText = this.textLists[this.randomIndex()];
    this.textTimeout = setTimeout(() => {
      this.show = true;
    }, 3000);
  },
  computed: {
    searchTerm: {
      get() {
        return this.$store.getters["dashboard/getSearchTerm"];
      },
      set(value) {
        console.log("value");
        this.$store.commit("dashboard/setSearchTerm", value);
      }
    },
    selectedCategory: {
      get() {
        return this.$store.getters["dashboard/getSelectedCategory"];
      },
      set(value) {
        this.$store.commit("dashboard/setSelectedCategory", value);
        this.scrollToTop();
      }
    },
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
    randomIndex: function() {
      return Math.floor(Math.random() * this.textLists.length);
    },
    showWallet: function(value) {
      this.$store.commit("wallet/toggleWallet", value);
    },
    showShoppingCart: function(value) {
      this.$store.commit("cart/toggleCart", value);
    },
    menuActions: function(menuItem) {
      switch (menuItem) {
        case "Switch To Courier": {
          this.$router.push("/courier");
          break;
        }
        case "Leave Feedback": {
          window.open("https://goo.gl/forms/Q1EzTiaBkPZwepb62");
          break;
        }
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
            this.$store.dispatch("login/logout").then(
              response => {
                this.$router.push("/login");
              },
              error => {
                this.$store.commit("login/logoutFailed");
              }
            );
          }
          break;
      }
    },
    goToDashboard: function() {
      this.$router.push("/dashboard");
    },
    scrollToTop: function() {
      window.scrollTo(0, 0);
    }
  }
};
</script>

<style lang='css'>
@import "../../custom_css/landing.scss";

.btn-txt {
  color: #fff !important;
}

.btn_space {
  margin-right: 10px;
}

#shopping_cart {
  padding-left: 10px;
}
.main-toolbar {
  position: -webkit-sticky; /* Safari */
  position: sticky;
  top: 0;
  z-index: 1;
}
.fade-enter-active,
.fade-leave-active {
  transition: opacity 2s;
}
.fade-enter, .fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
  opacity: 0;
}

.active_menu .menuable__content__active {
  position: fixed;
}
</style>
