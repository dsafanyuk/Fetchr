<template >
  <v-app>
    <br>
    <div class="container">
      <div class="v-primary display-1">
        <br>Account Overview
      </div>
      <hr>
      <div class="row">
        <!-- personal info for -->
        <div class="col-sm-12">
          <v-form ref="form">
            <v-container>
              <v-flex sm12 md12 lg12 row>
                <div class="font-weight-bold orange--text subheading">First name</div>
                : {{ user.first_name }}
              </v-flex>
              <br>
              <v-flex sm12 md12 lg12 row>
                <div class="font-weight-bold orange--text subheading">Last name</div>
                : {{ user.last_name }}
              </v-flex>
              <br>
              <v-flex sm12 md12 lg12 row>
                <div class="font-weight-bold orange--text subheading">Email address</div>
                : {{ user.email_address}}
              </v-flex>
              <br>
              <v-flex sm12 md12 lg12 row>
                <div class="font-weight-bold orange--text subheading">Room number</div>
                : {{ user.room_num }}
              </v-flex>
              <br>
              <v-flex sm12 md12 lg12 row>
                <div class="font-weight-bold orange--text subheading">Phone Number</div>
                : {{ user.phone_number }}
              </v-flex>
              <br>
            </v-container>
            <div class="form-group text-center">
              <v-btn rectangle color="lightened" dark v-on:click="editItem(user)">Update Profile</v-btn>
            </div>
            <v-dialog v-model="dialog" max-width="500px">
              <v-card>
                <div class="text-xs-right">
                  <v-btn icon small color="gray " top @click="dialog = !dialog">
                    <v-icon>clear</v-icon>
                  </v-btn>
                </div>
                <v-card-title>
                  <span class="headline">{{ formTitle }}</span>
                </v-card-title>
                <v-card-text>
                  <v-form ref="form" v-model="valid" lazy-validation>
                    <v-container grid-list-md>
                      <v-layout wrap>
                        <v-flex sm12 md6 lg6 column>
                          <div class="caption">First Name</div>
                          <v-text-field
                            v-model="editedItem.first_name"
                            :counter="15"
                            :rules="firstNameRules"
                            required
                          ></v-text-field>
                        </v-flex>
                        <v-flex sm12 md6 lg6>
                          <div class="caption">Last Name:</div>
                          <v-text-field
                            v-model="editedItem.last_name"
                            :counter="15"
                            :rules="lastNameRules"
                            required
                          ></v-text-field>
                        </v-flex>
                        <v-flex sm12 md12 lg9>
                          <div class="caption">E-mail:</div>
                          <v-text-field
                            v-model="editedItem.email_address"
                            disabled
                            type="email"
                            :rules="emailRules"
                            required
                          ></v-text-field>
                        </v-flex>
                        <v-flex sm12 md6 lg6>
                          <div class="caption">Room Number:</div>
                          <v-text-field
                            v-model="editedItem.room_num"
                            type="number"
                            :counter="4"
                            :rules="roomNumberRules"
                            required
                          ></v-text-field>
                        </v-flex>
                        <v-flex sm12 md6 lg6>
                          <div class="caption">Phone Number:</div>
                          <v-text-field
                            v-model="editedItem.phone_number"
                            type="number"
                            :counter="10"
                            :rules="phoneNumberRules"
                            required
                          ></v-text-field>
                        </v-flex>
                      </v-layout>
                    </v-container>
                  </v-form>
                </v-card-text>
                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn
                    round
                    color="blue darken-1"
                    :disabled="!valid"
                    :loading="sending"
                    flat
                    v-on:click="save"
                  >Save</v-btn>
                </v-card-actions>
              </v-card>
            </v-dialog>
            <hr>
          </v-form>
        </div>
      </div>
    </div>
  </v-app>
</template>

<script>
import browserCookies from "browser-cookies";
import axios from "../../../../axios.js";

export default {
  data() {
    return {
      sending: false,
      dialog: false,
      editedIndex: -1,
      valid: true,
      user: {
        user_id: browserCookies.get("user_id"),
        first_name: browserCookies.get("first_name"),
        last_name: browserCookies.get("last_name"),
        room_num: browserCookies.get("room_num"),
        phone_number: browserCookies.get("phone_number"),
        email_address: browserCookies.get("email_address")
      },
      editedItem: {
        user_id: "",
        first_name: "",
        last_name: "",
        phone_number: "",
        room_num: "",
        email_address: ""
      },
      defaultItem: {
        user_id: "",
        first_name: "",
        last_name: "",
        phone_number: "",
        room_num: "",
        email_address: ""
      },
      firstNameRules: [
        v => !!v || "First Name cannot be empty.",
        v =>
          (v && v.length <= 15) ||
          "The First Name field may not be greater than 15 characters.",
        v => /^[A-Za-z]+$/.test(v) ||
          "The First Name cannot have numbers or special characters"
      ],
      lastNameRules: [
        v => !!v || "Last Name cannot be empty.",
        v =>
          (v && v.length <= 15) ||
          "The Last Name field may not be greater than 15 characters.",
        v => /^[A-Za-z]+$/.test(v) ||
          "The Last Name cannot have numbers or special characters"
      ],
      roomNumberRules: [
        v => !!v || "The Room Number field is required",
        v =>
          (v && v.length <= 4 && v.length >= 4) ||
          "The Room Number field must be numeric and exactly contain 4 digits."
      ],
      phoneNumberRules: [
        v => !!v || "The Phone Number field is required.",
        v => 
          (v && v.length <= 10 && v.length >= 10) ||
          "The Phone Number field must be numeric and exactly contain 10 digits."
          
      ],
      emailRules: [
        v => !!v || "E-mail is required",
        v =>
          /^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/.test(v) ||
          "E-mail must be valid"
      ]
    };
  },

  computed: {
    formTitle() {
      return (this.editedIndex = "Edit User");
    }
  },

  watch: {
    dialog(val) {
      val || this.close();
    }
  },

  methods: {
    validate() {
      if (this.$refs.form.validate()) {
        this.snackbar = true;
      }
    },

    editItem(item) {
      this.editedIndex = this.user;
      this.editedItem = Object.assign({}, item);
      this.dialog = true;
    },

    close() {
      this.dialog = false;
      setTimeout(() => {
        this.editedItem = Object.assign({}, this.defaultItem);
        this.editedIndex = -1;
      }, 300);
      this.$refs.form.reset();
    },

    save() {
      this.sendForm();
    },

    sendForm() {
      this.sending = true;
      this.$store
        .dispatch("account/editExistingUser", this.editedItem)
        .then(result => {
          if (result.status == "200") {
            this.sending = false;
            this.dialog = false;
            this.user.first_name = this.editedItem.first_name;
            this.user.last_name = this.editedItem.last_name;
            this.user.room_num = this.editedItem.room_num;
            this.user.phone_number = this.editedItem.phone_number;
            browserCookies.set("first_name", this.editedItem.first_name);
            browserCookies.set("last_name", this.editedItem.last_name);
            browserCookies.set("room_num", this.editedItem.room_num);
            browserCookies.set("phone_number", this.editedItem.phone_number);
          }
        });
    }
  }
};
</script>

<style  lang="css">
.v-primary {
  color: #344955;
}
</style>
