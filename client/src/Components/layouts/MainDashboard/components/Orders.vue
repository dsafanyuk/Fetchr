<template>
  <v-app>
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
              <button
                @click="viewOrder(order.order_id)"
                class="btn btn-outline-dark my-2 my-sm-0"
                type="button"
              >View</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </v-app>
</template>

<script>
import browserCookies from "browser-cookies";
import axios from "../../../../axios";

export default {
  data() {
    name: return {
      orders: {}
    };
  },
  mounted: function() {
    let loadingOrdersToast = this.$toasted.show("Loading orders...");
    axios
      .get("/api/users/" + browserCookies.get("user_id") + "/orders")
      .then(response => {
        this.orders = response.data;
        loadingOrdersToast.text("Orders loaded!").goAway(500);
      })
      .catch(error => {
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
    }
  }
};
</script>

<style scoped lang="css" src='../../../custom_css/orders.css'>
</style>
