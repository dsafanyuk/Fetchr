<template>
  <v-app>
    <LandingHeader></LandingHeader>
    <div class="orders">
      <h3>Recent Orders</h3>
      <table class="order table-responsive-md">
        <thead>
          <tr>
            <th>Order #</th>
            <th>Date</th>
            <th>Status</th>
            <th>Total</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="order in orders" :key="order.order_id">
            <td>{{order.order_id}}</td>
            <td>{{fixDate(order.time_created)}}</td>
            <td>{{order.delivery_status}}</td>
            <td>${{order.order_total.toFixed(2)}}</td>
            <td>
                <button @click="viewOrder(order.order_id)" class="btn btn-outline-dark my-2 my-sm-0" type="button">View</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <LandingFooter></LandingFooter>
  </v-app>
</template>

<script>
import LandingHeader from "./mini-components/LandingHeader.vue";
import LandingFooter from "./mini-components/LandingFooter.vue";
import OrderSummary from "./mini-components/OrderSummary.vue";
import browserCookies from "browser-cookies";
import axios from "../axios";

export default {
  data() {
    name: return {
      orders: {}
    };
  },
  mounted: function() {
    axios
      .get("/api/users/" + browserCookies.get("user_id") + "/orders")
      .then(response => {
        this.orders = response.data;
      });
  },
  components: {
    LandingHeader: LandingHeader,
    LandingFooter: LandingFooter,
    OrderSummary: OrderSummary
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
    }
  }
};
</script>

<style scoped lang="css" src='./custom_css/orders.css'>
</style>
