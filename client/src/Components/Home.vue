<template >
<div>
  <v-card elevation-10>
    <v-layout row id="top" class="header">
      <v-flex xs3 ml-5>
        <img src="./images/fetchr_header_logo_colored.png" class="logo" >
      </v-flex>
      <v-spacer></v-spacer>
      <v-flex xs1>
        <v-btn to="/login" outline color="#f9aa33">Login</v-btn>
      </v-flex>
      <v-flex xs1 mr-4>
        <v-btn to="/register" color="#f9aa33">Signup</v-btn>
      </v-flex>
    </v-layout>
  </v-card>
      <v-layout pt-5 class="huge-bottom-margin">
        <v-flex xs12>
          <v-layout pa-5 class="hero">
            <v-layout pa-5 align-center column fill-height class="hero-text">
              <v-icon x-large color="#f9aa33">people</v-icon>
              <span class="display-1">The student-run, store-to-door platform </span>
              <span class="display-1">was made by students for students.</span>
              <v-btn to="/register" large round class="hero-text hero-button" color="#f9aa33" >Get Started Now!</v-btn>
            </v-layout>
          </v-layout>
        </v-flex>
      </v-layout>
      <v-layout pb-5 align-end justify-center >
        <span class="display-3 font-weight-bold">{{gifs[gifSlide].title}}</span>
      </v-layout>
      <v-layout class="huge-bottom-margin">
        <v-carousel
          :cycle=false
          :dark=true
          v-model="gifSlide"
        >
          <v-carousel-item
            v-for="(gif, i) in gifs"
            :key="i"
            :src="gif.src"
            transition="fade"
            reverse-transition="fade">
          </v-carousel-item>
        </v-carousel>
      </v-layout>
    <v-card color="#f9aa33" class="huge-bottom-margin">
        <v-layout pa-5 align-center column fill-height class="hero-text">
            <v-icon x-large color="#414141">whatshot</v-icon>
            <span class="display-1">Need extra money?</span>
            <span class="display-1">Sign up to be a courier!</span>
            <span class="display-1">View open orders and make a quick buck on the way back from class.</span>
            <v-btn to="/register" large round class="hero-text hero-button" color="#414141" >I need money!</v-btn>
    </v-layout>
    </v-card>
      <v-layout id="team" align-end justify-center>
        <span class="display-3 font-weight-bold">Meet the Team</span>
      </v-layout>
      <v-layout row wrap >
          <v-flex pa-5 xs6 v-for="(boi, i) in team" :key="i">
            <v-card height="100%" width="100%" color="rgba(0, 0, 0, .05)" elevation="3">
              <v-container text-xs-center>
                <v-layout column >
                  <v-layout >
                    <v-flex xs4>
                      <v-img v-bind:src="boi.portrait" height="150px" contain></v-img>
                    </v-flex>
                    <v-flex xs8>
                      <v-layout column >
                          <v-card-title>{{boi.name}}</v-card-title>
                          <v-card-text class="v-card__subtitle">{{boi.role}}</v-card-text>
                      </v-layout>
                    </v-flex>
                  </v-layout>
                  <v-flex xs12 >
                    <v-card-text >{{boi.bio}}</v-card-text>
                  </v-flex>
                </v-layout>
              </v-container>
            </v-card>
          </v-flex>
      </v-layout>
  <v-footer height="auto" color="rgb(76, 94, 105)">
      <v-layout justify-center row wrap>
        <v-btn v-for="(link, i) in links" :key="i" v-bind:to="link.to" color="white" flat round>{{ link.name }}</v-btn>
        <v-flex primary lighten-2 py-3 text-xs-center white--text xs12>
          &copy;2018 —
          <strong>Fetchr</strong>
        </v-flex>
      </v-layout>
    </v-footer>
  </div>
</template>

<script>
import AddToCart from "./assets/AddToCart.gif";
import AddToFavorites from "./assets/AddToFavorites.gif";
import AddToWallet from "./assets/AddToWallet.gif";
import CheckOut from "./assets/CheckOut.gif";
import Josh from "./assets/Johnson.png";
import Ben from "./assets/Kintaudi.png";
import James from "./assets/Limantara.png";
import Caleb from "./assets/Murray.png";
import Dave from "./assets/Safanyuk.png";
import Kesney from "./assets/Saurel.png";
export default {
  data() {
    return {
      links: [
        {
          name: "Login",
          to: "/login"
        },
        {
          name: "Register",
          to: "/register"
        },
      ],
      gifs: [
        { src: AddToCart, title: "Add Items to Cart" },
        { src: AddToFavorites, title: "Add Your Favorite Items" },
        { src: AddToWallet, title: "Add More Cash" },
        { src: CheckOut, title: "Checkout!" },
      ],
      gifSlide: 0,
      team: [
        {
          portrait: Dave,
          name: "Dave Safanyuk",
          role: "Team Leader",
          bio: "Tall; Likes computers; Bad eyesight",
        },
        {
          portrait: Josh,
          name: "Josh Johnson",
          role: "Assistent Team Leader / Scheduler",
          bio: "Trades in the stock market; Guacamole",
        },
        {
          portrait: Kesney,
          name: "Kesney Saurel",
          role: "User Interface / User Experience",
          bio: "Futbol player; Forex trader; Yeezy",
        },
        {
          portrait: James,
          name: "James Limintara",
          role: "Quality Assurance",
          bio: "Professional problem solver; Dabber",
        },
        {
          portrait: Caleb,
          name: "Caleb Murray",
          role: "Database Administrator",
          bio: "Lives on rice and salmon; Olen henna",
        },
        {
          portrait: Ben,
          name: "Ben Kintaudi",
          role: "Communications Coordinator",
          bio: "Loves to play soccer; The weird one",
        },
      ],
    };
  },
};
</script>

<style scoped lang="css" src="./custom_css/home_page.css">
@import url("https://fonts.googleapis.com/css?family=Roboto:300,400,500,700%7CMaterial+Icons");
</style>
