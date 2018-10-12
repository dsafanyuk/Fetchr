<template >

        <div  class="container register">

                          <div class="col-md-12 mx-auto register-right">



                                        <div class="row register-form">

                                            <div class="col-md-6 mx-auto">

                                              <img class="center_img" width="300px" height="300px "src="./images/logo.png"/>

                                              <h4 class="text-center form_h"> Text Hereeeeeee </h4>
                                            </div>

                                            <div class="col-md-6 mx-auto">

                                                <div class="form-group">
                                                  <h4 class="text-center form_h"> Sign Up on our Platform </h4>
                                                </div>
                                                <div class="form-group">
                                                    <input type="text" class="form-control" v-model="cFirstname" placeholder="First Name" value="" />
                                                </div>
                                                <div class="form-group">
                                                    <input type="text" class="form-control" v-model="cLastname" placeholder="Last Name" value="" />
                                                </div>
                                                <div class="form-group">
                                                    <input type="email" class="form-control" v-model="cEmail" placeholder="Email" value="" />
                                                </div>
                                                <div class="form-group">
                                                    <input type="number" class="form-control" v-model="cRoom" placeholder="Room Number" value="" />
                                                </div>
                                                <div class="form-group">
                                                    <input type="text" maxlength="10" minlength="10" class="form-control" v-model="cPhone" placeholder="Phone " value="" />
                                                </div>

                                                <div class="form-group">
                                                    <input type="password" class="form-control" v-model="cPassword" required placeholder="Password *" value="" />
                                                </div>
                                                <div class="form-group">
                                                    <input type="password" class="form-control" v-model="cRepeatPassword" required placeholder="Confirm Password *" value="" />
                                                </div>
                                                <div class="form-group text-center">
                                                <input type="submit" @click="registerCustomer" class="btnRegister"  value="Register"/>
                                              </div>

                                            </div>
                                        </div>

                          </div>

        </div>

</template>

<script>
import axios from 'axios'

export default {
//******************************************* Component Name  ********************************/
  name: "registration",
  data () {
    return {
      cFirstname : '',
      cLastname  : '',
      cEmail     : '',
      cRoom      : '',
      cPhone     : '',
      cPassword  : '',
      cRepeatPassword : '',

          }
    },
//******************************************* Methods Begin Here  ********************************/
    methods : {

      registerCustomer(e){

      let api_url =   "http://fetchr.io/apit/users";


      if (this.cFirstname && this.cLastname && this.cEmail && this.cPassword && this.cRepeatPassword ) // Replace with a Validator Lib
      {
        if (this.cPassword === this.cRepeatPassword)
        {
          axios.post("http:fetchr.io/apit/users", {
              cFirstname: 'Fred',
              cFirstname: this.cFirstname,
              cLastname: this.cLastname,
              cEmail: this.cEmail,
              cPhone:this.cPhone,
              cPassword: this.cPassword
                    })
                    .then(function (response) {
                          console.log(response);
                        })
                        .catch(function (error) {
                              console.log(error);
                                });

            console.log("Send HTTP Request to the API ");
        }
        else
        {
              console.log(" Password not equal");
        }
      }
      else{
        alert("Null");
      }

    }

    }
  }
</script>

<style>
@import 'custom_css/registration.scss'
</style>
