<template>
  <v-container fluid>
    <v-dialog v-model="dialog" max-width="500px">
      <template v-slot:activator="{ on }">
        <v-btn color="primary" dark class="mb-2" v-on="on">New Item</v-btn>
      </template>
      <v-card>
        <v-card-title>
          <span class="headline">{{formTitle}}</span>
        </v-card-title>

        <v-card-text>
          <v-form ref="form">
            <v-container grid-list-md>
              <v-layout wrap>
                <v-flex xs12 sm12 md12>
                  <v-text-field v-model="editedItem.product_name" label="Product Name" required></v-text-field>
                </v-flex>
                <v-spacer></v-spacer>
                <v-flex xs12 sm12 md12>
                  <v-text-field
                    v-validate="'required|decimal:2'"
                    :error-messages="errors.collect('checkbox')"
                    data-vv-name="price"
                    required
                    name="Price"
                    type="text"
                    v-model="editedItem.price"
                    label="Price"
                  ></v-text-field>
                </v-flex>

                <v-flex xs12 sm12 md12>
                  <v-select
                    :items="categories"
                    v-model="editedItem.category"
                    label="Category"
                    required
                  ></v-select>
                </v-flex>
                <v-flex xs12 sm6 md4>
                  <v-switch
                    true-value="true"
                    false-value="false"
                    v-model="editedItem.is_active"
                    label="Activate Product"
                  ></v-switch>
                </v-flex>

                <v-flex xs12 class="text-xs-center text-sm-center text-md-center text-lg-center">
                  <img :src="imageUrl" height="150" v-if="imageUrl">
                  <v-text-field
                    label="Select Image"
                    @click="pickFile"
                    v-model="imageName"
                    prepend-icon="attach_file"
                  ></v-text-field>
                  <input
                    type="file"
                    style="display: none"
                    ref="image"
                    accept="image/*"
                    @change="onFilePicked"
                  >
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
      <v-card-title>
        Products
        <v-spacer></v-spacer>
        <v-text-field v-model="search" append-icon="search" label="Search" single-line hide-details></v-text-field>
      </v-card-title>
      <v-data-table :headers="headers" :items="products" class="elevation-1" :search="search">
        <template slot="items" slot-scope="props">
          <tr>
            <td class="text-xs-center">{{ props.item.product_id }}</td>
            <td class="text-xs-right">{{ props.item.product_name }}</td>
            <td class="text-xs-right">{{ props.item.price }}</td>
            <td class="text-xs-right">{{ props.item.category }}</td>
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
        { text: "Product #", align: "center", value: "product_id" },
        { text: "Product Name", align: "right", value: "product_name" },
        { text: "Price", align: "right", value: "product_price" },
        { text: "Category", align: "right", value: "category" },
        { text: "Active", align: "center", value: "is_active" },
        { text: "Actions", align: "center", value: "name", sortable: false }
      ],
      imageName: "",
      imageUrl: "",
      search: "",
      sending: false,
      dialog: false,
      editedIndex: -1,
      editedItem: {
        product_id: "",
        product_name: "",
        price: "",
        category: "",
        is_active: "false",
        imageFile: ""
      },
      defaultItem: {
        product_name: "",
        price: "",
        category: "",
        is_active: "false",
        imageFile: ""
      },
      categories: [
        "snacks",
        "drinks",
        "school_supplies",
        "misc",
        "personal",
        "electronics"
      ]
    };
  },
  created: function() {
    this.$store.dispatch("admin/retrieveProducts");
  },
  computed: {
    products() {
      return this.$store.getters["admin/showProducts"];
    },
    formTitle() {
      return this.editedIndex === -1 ? "New Item" : "Edit Item";
    }
  },
  watch: {
    dialog(val) {
      val || this.close();
    }
  },
  methods: {
    editItem(item) {
      this.editedIndex = this.products.indexOf(item);
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
      this.imageUrl = "";
    },

    save() {
      this.sendFile();
    },
    pickFile() {
      this.$refs.image.click();
    },
    sendFile() {
      this.sending = true;
      if (this.editedIndex == -1) {
        this.$store
          .dispatch("admin/createNewProduct", this.editedItem)
          .then(result => {
            this.sending = false;
            this.close();
          });
      } else {
        this.$store
          .dispatch("admin/editExistProduct", this.editedItem)
          .then(result => {
            this.sending = false;
            this.close();
          });
      }
    },
    onFilePicked(e) {
      const files = e.target.files;
      if (files[0] !== undefined) {
        this.imageName = files[0].name;
        if (this.imageName.lastIndexOf(".") <= 0) {
          return;
        }
        const fr = new FileReader();
        fr.readAsDataURL(files[0]);
        fr.addEventListener("load", () => {
          this.imageUrl = fr.result;
          this.editedItem.imageFile = files[0]; // this is an image file that can be sent to server...
        });
      } else {
        this.imageName = "";
        this.editedItem.imageFile = "";
        this.imageUrl = "";
      }
    }
  }
};
</script>

<style lang="scss" scoped>
</style>

