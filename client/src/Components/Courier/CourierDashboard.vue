<template>
<body>
  <v-app>
    <CourierHeader></CourierHeader>
    <CourierSummaryCard class="summarycard"></CourierSummaryCard>
    <div class="row">
      <div class="col-lg-6">
        <button type="button" v-on:click="getAvailableOrders">Refresh Available Orders</button>
        <CourierAvailableOrders
          :orders="availableOrders"
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
            <CourierAcceptedOrders v-if="i == 1" :orders="acceptedOrders"></CourierAcceptedOrders>
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
import axios from "../../axios";
const user = browserCookies.get("user_id");

export default {
  data() {
    return {
      buildings: [
        "Ballard",
        "Coberly",
        "Griffith",
        "Dixon",
        "Bradley",
        "Young"
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
  created: function clearOrders() {
    this.$store.dispatch("courier/clearAllOrders");
  },
  mounted: function loadOrder() {
    this.getAvailableOrders();
    this.getAcceptedOrders();
    this.getDeliveredOrders();
  },
  computed: {
    availableOrders() {
      return this.$store.getters["courier/availableOrders"];
    },
    deliveredOrders() {
      return this.$store.getters["courier/deliveredOrders"];
    },
    acceptedOrders() {
      return this.$store.getters["courier/acceptedOrders"];
    }
  },
  methods: {
    getDeliveredOrders() {
      this.$store.dispatch("courier/getDeliveredOrders");
    },
    getAcceptedOrders() {
      this.$store.dispatch("courier/getAcceptedOrders");
    },
    getAvailableOrders() {
      this.$store.dispatch("courier/getAvailableOrders");
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
