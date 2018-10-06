<template >

<div>
        <div  class="container register">
          <div class="row">

          </div>
                        <div class="row">
                          <div class="col-md-8 mx-auto register-right">
                              <div class="switchBox">
                                <ul class="nav nav-tabs nav-justified text-centered" id="myTab" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link active " id="customer-tab" data-toggle="tab" href="#customertab" role="tab" aria-controls="customer-tab" aria-selected="true">Customer</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="courier-tab" data-toggle="tab" href="#courriertab" role="tab" aria-controls="courrier-tab" aria-selected="false">Courrier</a>
                                    </li>
                                </ul>
                              </div>
                                <div class="tab-content" id="myTabContent">
                                  <div class="tab-pane fade show active" id="customertab" role="tabpanel" aria-labelledby="customer-tab">
                                        <h3  class="register-heading">Register as a Customer</h3>
                                        <div class="row register-form">
                                            <div class="col-md-8 mx-auto">
                                              <form action="#" >
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
                                                    <input type="text" maxlength="10" minlength="10" class="form-control" v-model="cPhone" placeholder="Phone " value="" />
                                                </div>

                                                <div class="form-group">
                                                    <input type="password" class="form-control" v-model="cPassword" placeholder="Password *" value="" />
                                                </div>
                                                <div class="form-group">
                                                    <input type="password" class="form-control" v-model="cRepeatPassword" placeholder="Confirm Password *" value="" />
                                                </div>
                                                <div class="form-group text-center">
                                                <input type="submit" @click="register" class="btnRegister"  value="Register"/>
                                              </div>
                                            </form>
                                            </div>
                                            <div class="col-md-6">

                                            </div>
                                        </div>
                                    </div>
                                  <div class="tab-pane fade show " id="courriertab" role="tabpanel" aria-labelledby="courrier-tab">
                                      <h3 class="register-heading">Register as a Courrier</h3>
                                      <div class="row register-form">
                                          <div class="col-md-6">
                                              <div class="form-group">
                                                  <input type="text" class="form-control" placeholder="First Name" value="" />
                                              </div>
                                              <div class="form-group">
                                                  <input type="text" class="form-control" placeholder="Last Name " value="" />
                                              </div>
                                              <div class="form-group">
                                                    <input type="text" class="form-control" placeholder="Username" value="" />
                                              </div>
                                              <div class="form-group">
                                                  <input type="password" class="form-control" placeholder="Password " value="" />
                                              </div>
                                              <div class="form-group">
                                                  <input type="password" class="form-control"  placeholder="Confirm Password *" value="" />
                                              </div>

                                          </div>
                                          <div class="col-md-6">
                                              <div class="form-group">
                                                  <input type="email" class="form-control" placeholder="Your Email *" value="" />
                                              </div>
                                              <div class="form-group">
                                                  <input type="tel" class="form-control" placeholder="PCCID" value="" />
                                              </div>
                                              <div class="form-group">
                                                  <input type="text" minlength="10" maxlength="10" name="txtEmpPhone" class="form-control" placeholder="Your Phone *" value="" />
                                              </div>
                                              <div class="form-group">
                                                  <select class="form-control">
                                                      <option class="hidden"  selected disabled>Please select your Sequrity Question</option>
                                                      <option>What is your Birthdate?</option>
                                                      <option>What is Your old Phone Number</option>
                                                      <option>What is your Pet Name?</option>
                                                  </select>
                                              </div>
                                              <div class="form-group">
                                                  <input type="text" class="form-control" placeholder="Enter Your Answer *" value="" />
                                              </div>
                                              <input type="submit" class="btnRegister"  value="Register"/>
                                          </div>
                                      </div>
                                  </div>

                                </div>
                            </div>
                        </div>

        </div>
</div>

</template>

<script>
export default {
  name: "registration",
  data () {
    return {
      cFirstname : '',
      cLastname  : '',
      cEmail     : '',
      cPhone     : '',
      cPassword  : '',
      cRepeatPassword : '',

    }
    },
    methods : {
      register(e){

  

      }

    }
  }
</script>

<style>
@import 'custom_css/registration.scss'
</style>
