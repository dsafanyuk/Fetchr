<template>
  <v-app>
    <div class="container register">
      <div class="col-md-12 mx-auto register-right">
        <div class="row register-form">
          <div class="col-md-6 mx-auto">
            <img class="center_img" width="300px" height="300px " src="./images/logo.png" />
          </div>
          <div class="col-md-6 mx-auto">
            <div class="form-group">
              <h4 class="text-center form_h"> Login in on our Platform </h4>
              <br>
            </div>
            <br>
            <form @keyup.enter="login('dashboard')">
              <v-text-field
                v-validate="'required|email'"
                type="email"
                v-model="cEmail"
                :error-messages="errors.collect('cEmail')"
                data-vv-name="cEmail"
                placeholder="Email"
                value=""
                solo
                required
              ></v-text-field>
              <v-text-field
                v-validate="'required'"
                type="password"
                v-model="cPassword"
                :error-messages="errors.collect('cPassword')"
                data-vv-name="cPassword"
                placeholder="Password *"
                value=""
                solo
                required
              ></v-text-field>
            </form>
            <div class="form-group text-center">
              <v-btn 
                :loading="loading && this.loginTo == 'dashboard'"
                :disabled="loading && this.loginTo == 'dashboard'"
                round color="#647a87"
                class="white--text"
                type="submit"
                @click="login('dashboard')"
              >Login as Customer</v-btn>
              <v-btn
                :loading="loading && this.loginTo == 'courier'"
                :disabled="loading && this.loginTo == 'courier'"
                round color="#647a87"
                class="white--text"
                type="submit"
                @click="login('courier')"
              >Login as Courier</v-btn>
            </div>
            <div class="form-group text-center">
                            <span class="caption red--text text-xs-center text-center">You cannot use your PCC login info, please make a new account</span>
                            <br>
                Don't have an account? <router-link to="/register" class='underline'>Sign up here</router-link>
                <br>Or<br>
                <router-link to="/home" class='underline'>Go Home here</router-link>
            </div>
          </div>
        </div>
      </div>
    </div>
  </v-app>
</template>
<script>
  import axios from '../axios'
  import Toasted from 'vue-toasted';

  export default {
    $_veeValidate: {
      validator: 'new'
    },

    //******************************************* Component Name  ********************************/
    name: "login",
    data() {
      return {
        cEmail: '',
        cPassword: '',
        loginTo: '',
        dictionary: {
          attributes: {
            cEmail: 'E-mail Address',
            cPassword: 'Password'
          }
        }
      }
    },

    mounted () {
      this.$validator.localize('en', this.dictionary)
    },
    computed: {
      loading() {
        return this.$store.getters["login/getUserLoadStatus"] == 1
      }
    },
    methods: {
      login(value) {
        this.loginTo = value;
        if (this.cEmail && this.cPassword) {
          axios.post('api/users/login', {
              email_address: this.cEmail,
              password: this.cPassword
          })
            .then((response) => {
              if (response.status == 200) {
                this.$store.commit('login/setUserId', response.data.user_id)
                // Change login status, returns a promise
                this.$store.dispatch('login/login').then(response => {
                  this.$router.push('/' + value);
                },
                  error => {
                    console.error("Login action failed");
                    this.$store.commit('login/loginFailed');
                  });
              }
            })
            .catch((error) => {
              console.log(error);
              this.$toasted.error('WRONG EMAIL OR PASSWORD', {
                theme: "bubble", 
                position: "top-center", 
                duration : 5000,
                icon: "report_problem"
              });
            });
        } else {
          this.$validator.validateAll();
        }
      },
    }
  };
</script>

<style lang="css" scoped>
  @import 'custom_css/registration.scss';
  .underline{
  text-decoration: underline;
}
</style>
