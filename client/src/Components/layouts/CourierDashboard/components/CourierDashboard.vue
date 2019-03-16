<template>
  <v-app>
    <CourierOrderSummary
      v-if="summaryOrder.order_id"
      :selectedOrder="summaryOrder"
      :summaryIsActive="summaryIsActive"
      v-model="summaryIsActive"
      @closeDialog="summaryIsActive"
    ></CourierOrderSummary>
    <CourierSummaryCard class="summarycard"></CourierSummaryCard>

    <!-- MOBILE AND TABLETS -->
    <div class="hidden-lg-and-up row">
      <div class="col-md-10 offset-md-1 col-sm-5">
        <v-tabs height="80px" centered light show-arrows grow v-model.lazy="active" mandatory>
          <v-tabs-slider color="accent"></v-tabs-slider>
          <v-tab href="#baby1">Available</v-tab>
          <v-tab href="#baby2">Accepted</v-tab>
          <v-tab href="#baby3">Delivered</v-tab>
          <v-tab-item v-for="i in 3" :key="i" :value="'baby' + i">
            <CourierAvailableOrders
              v-if="i == 1"
              :orders="availableOrders"
              @toggleSummary="toggleOrderSummary"
            ></CourierAvailableOrders>
            <CourierAcceptedOrders
              v-if="i == 2"
              :orders="acceptedOrders"
              @toggleSummary="toggleOrderSummary"
            ></CourierAcceptedOrders>
            <CourierDeliveredOrders
              v-if="i == 3"
              :orders="deliveredOrders"
              @toggleSummary="toggleOrderSummary"
            ></CourierDeliveredOrders>
          </v-tab-item>
        </v-tabs>
      </div>
    </div>

    <!-- Computers -->
    <div class="row hidden-md-and-down">
      <div class="col-lg-10 offset-lg-1">
        <v-tabs
          height="80px"
          centered
          light
          show-arrows
          grow
          v-model="active"
          class="shadow-lg"
          mandatory
        >
          <v-tabs-slider color="accent"></v-tabs-slider>
          <v-tab href="#baby1">Available</v-tab>
          <v-tab href="#baby2">Accepted</v-tab>
          <v-tab href="#baby3">Delivered</v-tab>
          <v-tab-item v-for="i in 3" :key="i" :value="'baby' + i">
            <CourierAvailableOrders
              v-if="i == 1"
              :orders="availableOrders"
              @toggleSummary="toggleOrderSummary"
            ></CourierAvailableOrders>
            <CourierAcceptedOrders
              v-if="i == 2"
              :orders="acceptedOrders"
              @toggleSummary="toggleOrderSummary"
            ></CourierAcceptedOrders>
            <CourierDeliveredOrders
              v-if="i == 3"
              :orders="deliveredOrders"
              @toggleSummary="toggleOrderSummary"
            ></CourierDeliveredOrders>
          </v-tab-item>
        </v-tabs>
      </div>
    </div>
  </v-app>
</template>

<script>
import CourierOrderSummary from "./CourierOrderSummary";
import CourierDeliveredOrders from "./CourierDeliveredOrders";
import CourierSummaryCard from "./CourierSummaryCard.vue";
import CourierAvailableOrders from "./CourierAvailableOrders";
import CourierAcceptedOrders from "./CourierAcceptedOrders";
import browserCookies from "browser-cookies";
import Toasted from "vue-toasted";
import axios from "../../../../axios";

export default {
  data() {
    return {
      active: "baby1",
      summaryOrder: {},
      summaryIsActive: false,
    };
  },
  components: {
    CourierSummaryCard: CourierSummaryCard,
    CourierAvailableOrders: CourierAvailableOrders,
    CourierAcceptedOrders: CourierAcceptedOrders,
    CourierDeliveredOrders: CourierDeliveredOrders,
    CourierOrderSummary: CourierOrderSummary
  },
  created: function clearOrders() {
    this.$store.dispatch("courier/clearAllOrders");
  },
  mounted: function loadOrder() {
    this.$store.commit('courier/startLoading');
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
    toggleOrderSummary(value) {
      if (value) this.summaryOrder = value;
      else this.summaryOrder = "";

      if (this.toggleSummary) this.summaryIsActive = false;
      else this.summaryIsActive = true;
    },
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
  margin-top: 1%;
}
</style>
