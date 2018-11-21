<template>
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
          <div class="form-group">
            <input type="email" class="form-control" v-model="cEmail" placeholder="Email" value="" />
          </div>
          <div class="form-group">
            <input type="password" class="form-control" v-model="cPassword" required placeholder="Password *" value="" />
          </div>
          <div class="form-group text-center">
            <input type="submit" @click="loginCustomer" class="btnRegister" value="Login" />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
  import axios from 'axios'
  import * as jwtDecode from 'jwt-decode'

  const api = axios.create({
    withCredentials: true,
  });

  export default {
    //******************************************* Component Name  ********************************/
    name: "login",
    data() {
      return {
        cEmail: '',
        cPassword: '',
      }
    },
    methods: {
      loginCustomer(e) {
        let api_url = "http://127.0.0.1:3000/api/users";

        if (this.cEmail && this.cPassword) {
          api({
            url: '/login', method: 'post', baseURL: api_url, data: {
              email_address: this.cEmail,
              password: this.cPassword
            },
          })
            .then((response) => {
              if (response.status == 200) {
                this.$router.push('/dashboard');
              }
            })
            .catch((error) => {
              console.log(error);
            });
        } else {
          console.log('at least 1 null field');
        }
      }
    }
  }
</script>

<style lang="css">
  @import 'custom_css/registration.scss'
</style>