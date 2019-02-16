<template>
<body>
  <CourierHeader></CourierHeader>
  <CourierSummaryCard class="summarycard"></CourierSummaryCard>
  <v-app>
    <div class="row">
      <div class="col-lg-6">
        <button type="button" v-on:click="getAvailableOrders">Refresh Available Orders</button>
        <CourierAvailableOrders
          :orders="orders"
          v-on:accepted="getAvailableOrders(); getAcceptedOrders();"
        ></CourierAvailableOrders>
      </div>
      <div class="col-lg-6">
        <button type="button" v-on:click="getAcceptedOrders">Refresh Accepted Orders</button>
        <v-tabs height="80px" centered light icons-and-text show-arrows>
          <v-tabs-slider color="accent"></v-tabs-slider>
          <v-tab href="#baby1">Accepted</v-tab>
          <v-tab href="#baby2">Delivered</v-tab>
          <v-tab-item v-for="i in 2" :key="i" :value="'baby' + i">
            <CourierAcceptedOrders
              v-if="i == 1"
              :orders="acceptedOrders"
              v-on:delivered="getAcceptedOrders"
            ></CourierAcceptedOrders>
            <CourierDeliveredOrders v-if="i == 2" :orders="deliveredOrders"></CourierDeliveredOrders>
          </v-tab-item>
        </v-tabs>
      </div>
    </div>
  </v-app>
</body>
</template>

<script>
import CourierHeader from "../mini-components/Courier/CourierHeader.vue";
import CourierDeliveredOrders from "./CourierDeliveredOrders";
import CourierSummaryCard from "../mini-components/Courier/CourierSummaryCard.vue";
import CourierAvailableOrders from "./CourierAvailableOrders";
import CourierAcceptedOrders from "./CourierAcceptedOrders";
import browserCookies from "browser-cookies";
import Toasted from "vue-toasted";
import axios from "axios";
const api = axios.create();
const user = browserCookies.get("user_id");

export default {
  data() {
    return {
      orders: [],
      acceptedOrders: [],
      deliveredOrders: [],
      buildings: [
        "Ballard",
        "Coberly",
        "Griffith",
        "Dixon",
        "Bradley",
        "Young"
      ],
      months: [
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
      ],
      blankOrder: {
        order_id: "",
        first_name: "",
        building: "",
        order_total: "",
        time_created: ""
      }
    };
  },
  components: {
    CourierHeader: CourierHeader,
    CourierSummaryCard: CourierSummaryCard,
    CourierAvailableOrders: CourierAvailableOrders,
    CourierAcceptedOrders: CourierAcceptedOrders,
    CourierDeliveredOrders: CourierDeliveredOrders
  },
  created: function loadOrders() {
    this.getAcceptedOrders();
    this.getAvailableOrders();
  },
  methods: {
    getAcceptedOrders() {
      let aCounter = 0;
      let dCounter = 0;
      let loadingOrdersToast = this.$toasted.show("Loading accepted orders...");
      api
        .get(`/api/courier/${user}/order/accepted`)
        .then(response => {
          response.data.map(order => {
            console.log(order);
            let newOrder = {
              order_id: order.order_id,
              first_name: order.first_name,
              room_num:
                this.buildings[order.room_num.slice(0, 1) - 1] +
                " " +
                order.room_num,
              time_created: this.fixDateTime(order.time_created)
            };
            if (order.delivery_status == "in progress") {
              this.acceptedOrders.push(newOrder);
              aCounter++;
            } else {
              this.deliveredOrders.push(newOrder);
              dCounter++;
            }
          });
          for (let i = 5; i > aCounter % 5; i--) {
            this.acceptedOrders.push(this.blankOrder);
          }
          for (let i = 5; i > dCounter % 5; i--) {
            this.deliveredOrders.push(this.blankOrder);
          }
          loadingOrdersToast.text("accepted orders loaded!").goAway(5000);
        })
        .catch(error => {
          if (error.response) {
            console.log(error.response.data);
            console.log(error.response.status);
            console.log(error.response.headers);
          } else if (error.request) {
            console.log(error.request);
          } else {
            // Something happened in setting up the request that triggered an Error
            console.log(error);
            console.log("Error", error.message);
          }
          loadingOrdersToast.goAway();
          this.$toasted.error("Something went wrong");
        });
    },
    getAvailableOrders() {
      let counter = 0;
      let loadingOrdersToast = this.$toasted.show("Loading orders...");
      api
        .get(`/api/courier/` + user + `/order`)
        .then(response => {
          this.orders = response.data.map(order => {
            let newOrder = {
              order_id: order.order_id,
              first_name: order.first_name,
              room_num:
                this.buildings[order.room_num.slice(0, 1) - 1] +
                " " +
                order.room_num,
              time_created: this.fixDateTime(order.time_created)
            };
            counter++;
            return newOrder;
          });
          for (let i = 5; i > counter % 5; i--) {
            this.orders.push(this.blankOrder);
          }
          loadingOrdersToast.text("orders loaded!").goAway(5000);
        })
        .catch(error => {
          if (error.response) {
            console.log(error.response.data);
            console.log(error.response.status);
            console.log(error.response.headers);
          } else if (error.request) {
            console.log(error.request);
          } else {
            // Something happened in setting up the request that triggered an Error
            console.log("Error", error.message);
          }
          loadingOrdersToast.goAway();
          this.$toasted.error("Something went wrong");
        });
    },
    fixDateTime(date) {
      if (date != "") {
        date = new Date(date);
        let minutes = date.getMinutes();
        minutes = minutes < 10 ? "0" + minutes : minutes;
        let goodDate =
          this.months[date.getMonth()] +
          " " +
          date.getDate() +
          " " +
          date.getHours() +
          ":" +
          minutes;
        return goodDate;
      }
    }
  }
};
</script>

<style scoped="true">
.v-tabs__container--icons-and-text {
  height: 79px !important;
}
.summarycard {
  margin-top: 100px;
}
</style>
