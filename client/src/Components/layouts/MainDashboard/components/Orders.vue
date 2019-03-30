<template>
  <v-container>
    <v-card>
      <v-card-title class="headline lighten-2 text-align-center" primary-title>Orders</v-card-title>
      <div v-if="isLoading">
        <v-progress-linear :indeterminate="true" height="10"></v-progress-linear>
      </div>
      <v-data-table
        :headers="headers"
        :items="orders"
        v-bind:pagination.sync="pagination"
        :rows-per-page-items="rowsPerPage"
      >
        <template slot="items" slot-scope="props">
          <td class="text-xs-center">{{ props.item.order_id }}</td>
          <td class="text-xs-center">{{ fixDate(props.item.time_created) }}</td>
          <td class="text-xs-center">{{ props.item.delivery_status }}</td>
          <td class="text-xs-center">{{ props.item.order_total.toFixed(2) }}</td>
          <td>
            <CreateChat :order_id="props.item.order_id"></CreateChat>
          </td>
          <td>
            <v-btn
              @click="viewOrder(props.item.order_id)"
              round
              dark
              color="#616161"
              type="button"
            >View</v-btn>
          </td>
        </template>
      </v-data-table>
    </v-card>
  </v-container>
</template>
<script>
import CreateChat from "../../MainDashboard/components/ChatCreateConversation.vue";
import browserCookies from "browser-cookies";
import axios from "../../../../axios";
import { mapActions } from "vuex";
import * as firebase from "firebase";

export default {
  data() {
    return {
      dialog: false,
      msg_content: "",
      user_id: browserCookies.get("user_id"),
      orders: [],
      isLoading: false,
      pagination: { sortBy: "order_id", descending: true, rowsPerPage: 15 },
      rowsPerPage: [
        5,
        15,
        50,
        { text: "$vuetify.dataIterator.rowsPerPageAll", value: -1 }
      ],
      headers: [
        { text: "Order #", align: "center", value: "order_id" },
        { text: "Date", align: "center", value: "time_created" },
        { text: "Status", align: "center", value: "status" },
        { text: "Order Total", align: "center", value: "order_total" },
        { text: "", align: "center", value: "" }
      ]
    };
  },
  components: {
    CreateChat: CreateChat
  },
  mounted: function() {
    this.isLoading = true;
    axios
      .get("/api/users/" + browserCookies.get("user_id") + "/orders")
      .then(response => {
        this.orders = response.data;
        loadingOrdersToast.text("Orders loaded!").goAway(500);
        this.isLoading = false;
      })
      .catch(error => {
        this.isLoading = false;
        if (error.response) {
          console.log(error);
          loadingProductsToast.goAway();
          this.$toasted.error("Something went wrong");
        }
      });
  },
  methods: {
    viewOrder: function(order_id) {
      this.$router.push("/view?order=" + order_id);
    },
    fixDate: function(date) {
      date = new Date(date);
      let months = [
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug",
        "Sep",
        "Oct",
        "Nov",
        "Dec"
      ];

      let goodDate =
        months[date.getMonth()] +
        " " +
        date.getDate() +
        ", " +
        date.getFullYear();
      return goodDate;
    },
    createChat: function(order_id) {
      axios.get("/api/orders/" + order_id).then(response => {
        var receiver_id = response.data[0]["courier_id"];
        this.$store.dispatch("createChat", {
          message: this.msg_content,
          sender_id: this.user_id,
          receiver: receiver_id,
          or_id: order_id
        });
        this.$router.push("/chat/" + order_id);
      });
    },
    getCourierId: function(courier_id) {
      return axios.get("/api/orders/" + courier_id).then(response => {
        return response.data;
      });
    },

  }
};
</script>

<style scoped lang="css">
</style>
