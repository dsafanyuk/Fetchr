<template >
  <v-app>
    <v-container>
      <v-layout prominent color="white">
        <v-flex xs3 offset-xs1>
          <img src="./images/fetchr_header_logo_colored.png" class="logo">
        </v-flex>
        <v-spacer></v-spacer>
        <v-flex xs1>
          <v-btn to="/login" outline color="#f9aa33">Login</v-btn>
        </v-flex>
        <v-flex xs1>
          <v-btn to="/register" color="#f9aa33">Signup</v-btn>
        </v-flex>
      </v-layout>
    </v-container>
    <v-layout class="mt-1">
      <v-flex xs12>
        <v-layout pt-5 pb-5 class="hero">
          <v-layout align-center column fill-height class="hero-text justify-center">
            <v-icon x-large color="#f9aa33">people</v-icon>
            <span class="display-1 text-xs-center">What you need - straight to your door.</span>
            <br>
            <span class="body-2 text-xs-center">We're students. We get you.</span>
            <v-btn
              to="/register"
              large
              round
              class="hero-text hero-button"
              color="#f9aa33"
            >Get Started Now!</v-btn>
          </v-layout>
        </v-layout>
      </v-flex>
    </v-layout>
    <v-container>
      <v-layout pb-5 align-end justify-center>
        <span class="display-3 font-weight-bold text-xs-center">{{gifs[gifSlide].title}}</span>
      </v-layout>
      <v-layout class>
        <v-carousel :cycle="false" :dark="true" v-model="gifSlide">
          <v-carousel-item
            v-for="(gif, i) in gifs"
            :key="i"
            :src="gif.src"
            transition="fade"
            reverse-transition="fade"
          >
          <v-layout class="firstCarousel" v-if="i == 0" justify-center align-center v-bind:data-logo="faintLogo">
              <div class="display-1" >Click the right arrow to see how it works!</div>
          </v-layout>
        </v-carousel-item>
        </v-carousel>
      </v-layout>
    </v-container>

    <v-card color="#f9aa33" class="mt-5 mb-5">
      <v-layout pa-5 align-center column fill-height class="hero-text">
        <v-icon x-large color="#414141">whatshot</v-icon>
        <span class="display-1" style="  text-align: center;">
          Need extra money?
          <br>Make a quick buck on the way back from class and
          <br>help your fellow students at the same time.
        </span>
        <v-btn
          to="/register"
          large
          round
          class="hero-text hero-button"
          color="#414141"
        >Sign up to be a courier!</v-btn>
      </v-layout>
    </v-card>
    <v-container mb-5>
      <v-card color="transparent" flat>
        <v-card-title
          class="display-3 justify-center text-xs-center font-weight-bold"
          primary-title
        >Meet the Fetchr Team</v-card-title>
        <v-layout row wrap>
          <v-flex pa-5 lg6 xs12 v-for="(boi, i) in team" :key="i">
            <v-card height="100%" width="100%" color="white" elevation="3">
              <v-container text-xs-center grid-list-lg>
                <v-layout row wrap>
                  <v-flex lg4 sm12>
                    <img v-bind:src="boi.portrait" height="150px">
                  </v-flex>
                  <v-flex lg8 sm12>
                    <v-card-text class="display-1 pt-5">{{boi.name}}</v-card-text>
                    <span class="body-2 grey--text">{{boi.role}}</span>
                  </v-flex>
                  <v-flex lg12 offset-lg-2 sm12>
                    <v-card-text>{{boi.bio}}</v-card-text>
                  </v-flex>
                </v-layout>
              </v-container>
            </v-card>
          </v-flex>
        </v-layout>
      </v-card>
    </v-container>
    <br>
    <v-footer height="auto" color="rgb(76, 94, 105)" absolute>
      <v-layout justify-center row wrap xs12>
        <v-btn
          v-for="(link, i) in links"
          :key="i"
          v-bind:to="link.to"
          color="white"
          flat
          round
        >{{ link.name }}</v-btn>
        <v-flex primary lighten-2 text-xs-center white--text xs12>
          &copy;2018 —
          <strong>Fetchr</strong>
        </v-flex>
      </v-layout>
    </v-footer>
  </v-app>
</template>

<script>
import Logo from "./images/fetchr_header_logo_colored.png"
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
      faintLogo: Logo,
      links: [
        {
          name: "Login",
          to: "/login"
        },
        {
          name: "Register",
          to: "/register"
        }
      ],
      gifs: [
        { src: '', title: "Welcome to Fetchr" },
        { src: AddToCart, title: "Add Items to Cart" },
        { src: AddToFavorites, title: "Add Your Favorite Items" },
        { src: AddToWallet, title: "Add More Cash" },
        { src: CheckOut, title: "Checkout!" }
      ],
      gifSlide: 0,
      team: [
        {
          portrait: Dave,
          name: "Dave Safanyuk",
          role: "Team Leader",
          bio: "Tall; Likes computers; Bad eyesight"
        },
        {
          portrait: Josh,
          name: "Josh Johnson",
          role: "Assistent Team Leader / Scheduler",
          bio: "Trades in the stock market; Guacamole"
        },
        {
          portrait: Kesney,
          name: "Kesney Saurel",
          role: "User Interface / User Experience",
          bio: "Futbol player; Forex trader; Yeezy"
        },
        {
          portrait: James,
          name: "James Limintara",
          role: "Quality Assurance",
          bio: "Professional problem solver; Dabber"
        },
        {
          portrait: Caleb,
          name: "Caleb Murray",
          role: "Database Administrator",
          bio: "Lives on rice and salmon; Olen Yhdysvalloista"
        },
        {
          portrait: Ben,
          name: "Ben Kintaudi",
          role: "Communications Coordinator",
          bio: "Loves to play soccer; The weird one;",
        },
      ],
    };
  }
};
</script>

<style scoped lang="css" src="./custom_css/home_page.css">
@import url("https://fonts.googleapis.com/css?family=Roboto:300,400,500,700%7CMaterial+Icons");
</style>
