<template>
  <v-container fluid>
    <h2>Manage Users</h2>
    <v-dialog v-model="dialog" max-width="500px">
      <template v-slot:activator="{ on }">
        <v-btn color="primary" dark class="mb-2" v-on="on">New User</v-btn>
      </template>
      <v-card>
        <v-card-title>
          <span class="headline">{{formTitle}}</span>
        </v-card-title>

        <v-card-text>
          <v-form ref="form">
            <v-container grid-list-md>
              <v-layout wrap>
                <v-flex sm12 md6 lg6>
                  <v-text-field
                    v-model.lazy="editedItem.first_name"
                    label="First Name"
                    name="first-name"
                    autocomplete="new-password"
                    required
                  ></v-text-field>
                </v-flex>
                <v-flex sm12 md6 lg6>
                  <v-text-field
                    name="last-name"
                    v-model="editedItem.last_name"
                    label="Last Name"
                    required
                  ></v-text-field>
                </v-flex>
                <v-flex sm12 md12>
                  <v-text-field
                    v-model="editedItem.phone_number"
                    label="Phone Number"
                    name="phone-number"
                    required
                    autocomplete="new-password"
                  ></v-text-field>
                </v-flex>
                <v-flex sm12 md6 lg6>
                  <v-text-field v-model="editedItem.wallet" name="wallet" label="Wallet" required></v-text-field>
                </v-flex>
                <v-flex sm12 md6 lg6>
                  <v-text-field
                    v-model="editedItem.room_num"
                    name="room-number"
                    label="Room Number"
                    required
                  ></v-text-field>
                </v-flex>
                <v-flex sm12 md12>
                  <v-text-field
                    v-model="editedItem.email_address"
                    autocomplete="new-password"
                    label="Email Address"
                    required
                  ></v-text-field>
                </v-flex>
                <v-flex sm12 md12 v-if="formTitle == 'New User'">
                  <v-text-field
                    v-model="editedItem.password"
                    label="Password"
                    required
                    type="new-password"
                    autocomplete="new-password"
                  ></v-text-field>
                </v-flex>
                <v-flex xs12 sm6 md4>
                  <v-switch
                    true-value="true"
                    false-value="false"
                    v-model="editedItem.is_active"
                    label="Activate User"
                  ></v-switch>
                </v-flex>
              </v-layout>
            </v-container>
          </v-form>
        </v-card-text>

        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" flat @click="close">Cancel</v-btn>
          <v-btn color="blue darken-1" :loading="sending" flat @click="save">Save</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <v-card>
      <v-card-title>Products
        <v-spacer></v-spacer>
        <v-text-field v-model="search" append-icon="search" label="Search" single-line hide-details></v-text-field>
      </v-card-title>
      <v-data-table :headers="headers" :items="users" class="elevation-1" :search="search">
        <template slot="items" slot-scope="props">
          <tr>
            <td class="text-xs-center">{{ props.item.user_id }}</td>
            <td class="text-xs-right">{{ props.item.first_name }}</td>
            <td class="text-xs-right">{{ props.item.last_name }}</td>
            <td class="text-xs-right">{{ props.item.email_address }}</td>
            <td class="text-xs-right">{{ props.item.room_num }}</td>
            <td class="text-xs-right">{{ props.item.phone_number }}</td>
            <td class="text-xs-right">{{ props.item.wallet }}</td>
            <td class="text-xs-center">
              <v-icon v-if="props.item.is_active == 'true'">check</v-icon>
            </td>
            <td class="text-xs-center px-0">
              <v-icon small class="mr-2" @click="editItem(props.item)">edit</v-icon>
            </td>
          </tr>
        </template>
      </v-data-table>
    </v-card>
  </v-container>
</template>

<script>
import axios from "../../../../axios.js";
export default {
  data() {
    return {
      headers: [
        { text: "User #", align: "center", value: "user_id" },
        { text: "First Name", align: "right", value: "first_name" },
        { text: "Last Name", align: "right", value: "last_name" },
        { text: "Email", align: "center", value: "email_address" },
        { text: "Phone", align: "center", value: "phone_number" },
        { text: "Room #", align: "center", value: "room_num" },
        { text: "Wallet", align: "center", value: "wallet" },
        { text: "Active", align: "center", value: "is_active" },
        { text: "Actions", align: "center", value: "name", sortable: false }
      ],
      search: "",
      sending: false,
      dialog: false,
      editedIndex: -1,
      editedItem: {
        user_id: "",
        first_name: "",
        last_name: "",
        phone_number: "",
        wallet: "",
        room_num: "",
        email_address: "",
        is_active: "",
        password: ""
      },
      defaultItem: {
        user_id: "",
        first_name: "",
        last_name: "",
        phone_number: "",
        wallet: "",
        room_num: "",
        email_address: ""
      }
    };
  },
  created: function() {
    this.$store.dispatch("admin/retrieveUsers");
  },
  computed: {
    users() {
      return this.$store.getters["admin/showUsers"];
    },
    formTitle() {
      return this.editedIndex === -1 ? "New User" : "Edit User";
    }
  },
  watch: {
    dialog(val) {
      val || this.close();
    }
  },
  methods: {
    editItem(item) {
      this.editedIndex = this.users.indexOf(item);
      this.editedItem = Object.assign({}, item);
      this.dialog = true;
    },

    close() {
      this.dialog = false;
      setTimeout(() => {
        this.editedItem = Object.assign({}, this.defaultItem);
        this.editedIndex = -1;
      }, 300);
    },
    save() {
      this.sendForm();
    },
    sendForm() {
      this.sending = true;
      if (this.editedIndex == -1) {
        this.$store
          .dispatch("admin/createNewUser", this.editedItem)
          .then(result => {
            this.sending = false;
            this.close();
          });
      } else {
        this.$store
          .dispatch("admin/editExistingUser", this.editedItem)
          .then(result => {
            this.sending = false;
            this.close();
          });
      }
    }
  }
};
</script>

<style lang="scss" scoped>
</style>

