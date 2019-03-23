<template>
    <v-app>
        <div class="container register">
            <div class="col-md-12 mx-auto register-right">
                <div class="row register-form">
                    <div class="col-md-6 mx-auto">
                        <img @click="goToLogin" class="center_img" width="300px" height="300px" src="./images/logo.png">
                    </div>
                    <div class="col-md-6 mx-auto">
                        <div class="form-group">
                            <h4 class="text-center form_h">Sign Up on our Platform</h4>
                        </div>
                        <br>
                        <form>
                            <v-text-field
                                v-validate="'required|max:15'"
                                v-model="cFirstname"
                                :counter="15"
                                :error-messages="errors.collect('cFirstname')"
                                data-vv-name="cFirstname"
                                placeholder="First Name"
                                value=""
                                solo
                                required
                            ></v-text-field>
                            <v-text-field
                                v-validate="'required|max:15'"
                                v-model="cLastname"
                                :counter="15"
                                :error-messages="errors.collect('cLastname')"
                                data-vv-name="cLastname"
                                placeholder="Last Name"
                                value=""
                                solo
                                required
                            ></v-text-field>
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
                                v-validate="'required|digits:4'"
                                type="number"
                                v-model="cRoom"
                                :error-messages="errors.collect('cRoom')"
                                data-vv-name="cRoom"
                                placeholder="Room Number"
                                value=""
                                solo
                                required
                            ></v-text-field>
                            <v-text-field
                                v-validate="'required|digits:10'"
                                type="number"
                                v-model="cPhone"
                                :error-messages="errors.collect('cPhone')"
                                data-vv-name="cPhone"
                                placeholder="Phone Number"
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
                                ref="cPassword"
                                solo
                                required
                            ></v-text-field>
                            <v-text-field
                                v-validate="'required|confirmed:cPassword'"
                                type="password"
                                v-model="cRepeatPassword"
                                :error-messages="errors.collect('cRepeatPassword')"
                                data-vv-name="cRepeatPassword"
                                placeholder="Confirm Password *"
                                value=""
                                solo
                                required
                            ></v-text-field>
                            <div class="alert alert-info alert-dismissable">
                              <a class="panel-close close" data-dismiss="alert">×</a>
                              Password <strong>must have at least</strong>.<br>- 8 characters
                            </div>
                        </form>
                        <div class="form-group text-center">
                            <v-btn
                                round color="cyan" dark
                                type="submit"
                                @click="registerCustomer"
                            >Register</v-btn>
                            <v-btn
                                round color="cyan" dark
                                type="button"
                                @click="clear"
                            >Clear</v-btn>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </v-app>
</template>

<script>
import axios from "../axios";
import Toasted from 'vue-toasted';
import Vue from 'vue'

    export default {
        $_veeValidate: {
            validator: 'new'
        },

        //******************************************* Component Name  ********************************/
        name: 'registration',
        data() {
            return {
                cFirstname: '',
                cLastname: '',
                cEmail: '',
                cRoom: '',
                cPhone: '',
                cPassword: '',
                cRepeatPassword: '',
                dictionary: {
                    attributes: {
                        cEmail: 'E-mail Address',
                        cRoom: 'Room Number',
                        cPhone: 'Phone Number',
                        cPassword: 'Password',
                        cRepeatPassword: 'Confirm Password'
                    },
                    custom: {
                        cFirstname: {
                            required: ()=> 'First Name cannot be empty',
                            max: 'The First Name field may not be greater than 15 characters'
                        },
                        cLastname: {
                            required: ()=> 'Last Name cannot be empty',
                            max: 'The Last Name field may not be greater than 15 characters'
                        }
                    }
                }
            };
        },

        mounted () {
            this.$validator.localize('en', this.dictionary)
        },

        //******************************************* Methods Begin Here  ********************************/
        methods: {
            clear () {
                this.cFirstname = ''
                this.cLastname = ''
                this.cEmail = ''
                this.cRoom = ''
                this.cPhone = ''
                this.cPassword = ''
                this.cRepeatPassword = ''
                this.$validator.reset()
            },
            registerCustomer(e) {
                let toasted = this.$toasted;

                if (
                    this.cFirstname &&
                    this.cLastname &&
                    this.cEmail &&
                    this.cRoom &&
                    this.cPhone &&
                    this.cPassword &&
                    this.cRepeatPassword
                ) {
                    // Replace with a Validator Lib
                    if (this.cPassword === this.cRepeatPassword) {
                        axios
                            .post('api/users/register', {
                                first_name: this.cFirstname,
                                last_name: this.cLastname,
                                email_address: this.cEmail,
                                room_num: this.cRoom,
                                phone_number: this.cPhone,
                                password: this.cPassword,
                            })
                            .then((response) => {
                                if (response.status == 200) {
                                    this.$router.push('/login');
                                }
                            })
                            .catch(function (error) {
                                if (error.response) {
                                    error.response.data.errors.map( (error) => {
                                        Vue.toasted.show(error.param + " " + error.msg, {
                                            theme: 'bubble',
                                            duration: 4000,
                                            position: 'top-center',
                                            icon: 'report_problem'
                                        });
                                    })
                                }
                                if (error.response) {
                                    // The request was made and the server responded with a status code
                                    // that falls out of the range of 2xx
                                    console.log(error.response.data);
                                    console.log(error.response.status);
                                    console.log(error.response.headers);
                                }
                            });

                    }
                } else {
                    this.$validator.validateAll();
                }
            },
            goToLogin () {
                this.$router.push('\login');
            }
        },
    };
</script>

<style>
@import "custom_css/registration.scss";
@import "/src/Components/assets/css/bootstrap.min.css";
</style>
