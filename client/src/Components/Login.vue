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
            </div>
            <br>
            <form>
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
                round color="cyan" dark
                type="submit"
                @click="login('dashboard')"
              >Login as Customer</v-btn>
              <v-btn 
                round color="cyan" dark
                type="submit"
                @click="login('courier')"
              >Login as Courier</v-btn>
            </div>
            <div class="form-group text-center">
                Don't have an account? <a v-on:click="goToRegister">Sign up here</a>
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

    methods: {
      login(value) {
        if (this.cEmail && this.cPassword) {
          axios.post('api/users/login', {
              email_address: this.cEmail,
              password: this.cPassword
          })
            .then((response) => {
              if (response.status == 200) {
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
                theme: "primary", 
                position: "top-center", 
                duration : 5000
              });
            });
        } else {
          this.$validator.validateAll();
        }
      },
      goToRegister: function () {
        this.$router.push('/register');
      }
    }
  };
</script>

<style lang="css">
  @import 'custom_css/registration.scss';

  a:hover {
    color:darkcyan!important;
    cursor: pointer;
  }
</style>
