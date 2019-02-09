<template >
  <v-app>
    <LandingHeader v-on:showcart="displayCart"></LandingHeader>
    <br>
    <div class="container">
      <h3 class="v-primary">
        <br>Account Overview
      </h3>
      <hr>
      <div class="row">
        <!-- personal info for -->
        <div class="col-sm-12">
          <form class="form-horizontal" role="form">
            <div class="form-group">
              <p>
                <strong class="text-warning">First name</strong>
                : {{ firstName }}
              </p>
              <p>
                <strong class="text-warning">Last name</strong>
                : {{ lastName }}
              </p>
              <p>
                <strong class="text-warning">Email address</strong>
                : {{ emailAddress}}
              </p>
              <p>
                <strong class="text-warning">Room number</strong>
                : {{ roomNumber }}
              </p>
              <p>
                <strong class="text-warning">Phone Number</strong>
                : {{ phoneNumber }}
              </p>
            </div>
            <div class="form-group text-center">
              <v-btn rectangle color="lightened" dark type="submit" href="#">Update Profile</v-btn>
            </div>
            <hr>
          </form>
        </div>
      </div>
    </div>
    <LandingFooter></LandingFooter>
  </v-app>
</template>

<script>
import LandingHeader from "./mini-components/LandingHeader.vue";
import LandingFooter from "./mini-components/LandingFooter.vue";
import browsercookies from "browser-cookies";

export default {
  data() {
    return {
      firstName: browsercookies.get("first_name"),
      lastName: browsercookies.get("last_name"),
      roomNumber: browsercookies.get("room_num"),
      phoneNumber: browsercookies.get("phone_number"),
      emailAddress: browsercookies.get("email_address")
    };
  },

  components: {
    LandingHeader: LandingHeader,
    LandingFooter: LandingFooter
  }
};
</script>

<style  lang="css">
.v-primary {
  color: #344955;
}
</style>
