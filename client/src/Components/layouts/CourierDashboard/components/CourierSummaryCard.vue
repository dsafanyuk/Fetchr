<template>
  <div>
    <div class="row hidden-md-and-down">
      <div class="col-lg-4">
        <div class="card-box">
          <div class="bar-widget">
            <div class="table-box">
              <div class="table-detail">
                <v-btn fab icon color="primary" :ripple="false">
                  <v-icon large color="white">shopping_basket</v-icon>
                </v-btn>
              </div>

              <div class="table-detail">
                <v-progress-circular
                  class="m-t-0 m-b-5"
                  :size="23"
                  v-if="isLoading"
                  indeterminate
                  color="primary"
                ></v-progress-circular>
                <div v-if="!(isLoading)">
                  <h4 class="m-t-0 m-b-5">
                    <b>{{available_orders}}</b>
                  </h4>
                </div>
                <p class="text-muted m-b-0 m-t-0">Total Available Orders</p>
              </div>
              <div class="table-detail text-right">
                <span
                  data-plugin="peity-bar"
                  data-width="120"
                  data-height="45"
                  style="display: none;"
                >5,3,9,6,5,9,7,3,5,2,9,7,2,1</span>
                <svg class="peity" height="45" width="120">
                  <rect
                    fill="#f9aa33"
                    x="0.8571428571428571"
                    y="20"
                    width="6.857142857142858"
                    height="25"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="9.428571428571429"
                    y="30"
                    width="6.857142857142856"
                    height="15"
                  ></rect>
                  <rect fill="#f9aa33" x="18" y="0" width="6.857142857142858" height="45"></rect>
                  <rect
                    fill="#ebeff2"
                    x="26.571428571428573"
                    y="15"
                    width="6.857142857142858"
                    height="30"
                  ></rect>
                  <rect
                    fill="#f9aa33"
                    x="35.14285714285714"
                    y="20"
                    width="6.857142857142861"
                    height="25"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="43.714285714285715"
                    y="0"
                    width="6.857142857142854"
                    height="45"
                  ></rect>
                  <rect
                    fill="#f9aa33"
                    x="52.285714285714285"
                    y="10"
                    width="6.857142857142861"
                    height="35"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="60.857142857142854"
                    y="30"
                    width="6.857142857142854"
                    height="15"
                  ></rect>
                  <rect
                    fill="#f9aa33"
                    x="69.42857142857143"
                    y="20"
                    width="6.857142857142861"
                    height="25"
                  ></rect>
                  <rect fill="#ebeff2" x="78" y="35" width="6.857142857142861" height="10"></rect>
                  <rect
                    fill="#f9aa33"
                    x="86.57142857142857"
                    y="0"
                    width="6.857142857142861"
                    height="45"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="95.14285714285714"
                    y="10"
                    width="6.857142857142861"
                    height="35"
                  ></rect>
                  <rect
                    fill="#f9aa33"
                    x="103.71428571428571"
                    y="35"
                    width="6.857142857142861"
                    height="10"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="112.28571428571429"
                    y="40"
                    width="6.857142857142847"
                    height="5"
                  ></rect>
                </svg>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Ban 2 -->
      <div class="col-lg-4">
        <div class="card-box">
          <div class="bar-widget">
            <div class="table-box">
              <div class="table-detail">
                <v-btn fab icon color="primary" :ripple="false">
                  <v-icon large color="white">how_to_reg</v-icon>
                </v-btn>
              </div>

              <div class="table-detail">
                <v-progress-circular
                  class="m-t-0 m-b-5"
                  :size="23"
                  v-if="isLoading"
                  indeterminate
                  color="primary"
                ></v-progress-circular>
                <div v-if="!(isLoading)">
                  <h4 class="m-t-0 m-b-5">
                    <b>{{delivered_orders}}</b>
                  </h4>
                </div>
                <p class="text-muted m-b-0 m-t-0">Total Delivered Orders</p>
              </div>
              <div class="table-detail text-right">
                <span
                  data-plugin="peity-bar"
                  data-colors="#f9aa33,#ebeff2"
                  data-width="120"
                  data-height="s45"
                  style="display: none;"
                >5,3,9,6,5,9,7,3,5,2,9,7,2,1</span>
                <svg class="peity" height="45" width="120">
                  <rect
                    fill="#f9aa33"
                    x="0.8571428571428571"
                    y="20"
                    width="6.857142857142858"
                    height="25"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="9.428571428571429"
                    y="30"
                    width="6.857142857142856"
                    height="15"
                  ></rect>
                  <rect fill="#f9aa33" x="18" y="0" width="6.857142857142858" height="45"></rect>
                  <rect
                    fill="#ebeff2"
                    x="26.571428571428573"
                    y="15"
                    width="6.857142857142858"
                    height="30"
                  ></rect>
                  <rect
                    fill="#f9aa33"
                    x="35.14285714285714"
                    y="20"
                    width="6.857142857142861"
                    height="25"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="43.714285714285715"
                    y="0"
                    width="6.857142857142854"
                    height="45"
                  ></rect>
                  <rect
                    fill="#f9aa33"
                    x="52.285714285714285"
                    y="10"
                    width="6.857142857142861"
                    height="35"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="60.857142857142854"
                    y="30"
                    width="6.857142857142854"
                    height="15"
                  ></rect>
                  <rect
                    fill="#f9aa33"
                    x="69.42857142857143"
                    y="20"
                    width="6.857142857142861"
                    height="25"
                  ></rect>
                  <rect fill="#ebeff2" x="78" y="35" width="6.857142857142861" height="10"></rect>
                  <rect
                    fill="#f9aa33"
                    x="86.57142857142857"
                    y="0"
                    width="6.857142857142861"
                    height="45"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="95.14285714285714"
                    y="10"
                    width="6.857142857142861"
                    height="35"
                  ></rect>
                  <rect
                    fill="#f9aa33"
                    x="103.71428571428571"
                    y="35"
                    width="6.857142857142861"
                    height="10"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="112.28571428571429"
                    y="40"
                    width="6.857142857142847"
                    height="5"
                  ></rect>
                </svg>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Ban 3 -->
      <div class="col-lg-4">
        <div class="card-box">
          <div class="bar-widget">
            <div class="table-box">
              <div class="table-detail">
                <v-btn fab icon color="primary" :ripple="false">
                  <v-icon large color="white">attach_money</v-icon>
                </v-btn>
              </div>

              <div class="table-detail">
                <v-progress-circular
                  class="m-t-0 m-b-5"
                  :size="23"
                  v-if="isLoading"
                  indeterminate
                  color="primary"
                ></v-progress-circular>
                <div v-if="!(isLoading)">
                  <h4 class="m-t-0 m-b-5">
                    <b>{{delivered_revenue}}</b>
                  </h4>
                </div>
                <p class="text-muted m-b-0 m-t-0">Total Delivered Revenue</p>
              </div>
              <div class="table-detail text-right">
                <span
                  data-plugin="peity-bar"
                  data-colors="#f9aa33,#ebeff2"
                  data-width="120"
                  data-height="45"
                  style="display: none;"
                >5,3,9,6,5,9,7,3,5,2,9,7,2,1</span>
                <svg class="peity" height="45" width="120">
                  <rect
                    fill="#f9aa33"
                    x="0.8571428571428571"
                    y="20"
                    width="6.857142857142858"
                    height="25"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="9.428571428571429"
                    y="30"
                    width="6.857142857142856"
                    height="15"
                  ></rect>
                  <rect fill="#f9aa33" x="18" y="0" width="6.857142857142858" height="45"></rect>
                  <rect
                    fill="#ebeff2"
                    x="26.571428571428573"
                    y="15"
                    width="6.857142857142858"
                    height="30"
                  ></rect>
                  <rect
                    fill="#f9aa33"
                    x="35.14285714285714"
                    y="20"
                    width="6.857142857142861"
                    height="25"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="43.714285714285715"
                    y="0"
                    width="6.857142857142854"
                    height="45"
                  ></rect>
                  <rect
                    fill="#f9aa33"
                    x="52.285714285714285"
                    y="10"
                    width="6.857142857142861"
                    height="35"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="60.857142857142854"
                    y="30"
                    width="6.857142857142854"
                    height="15"
                  ></rect>
                  <rect
                    fill="#f9aa33"
                    x="69.42857142857143"
                    y="20"
                    width="6.857142857142861"
                    height="25"
                  ></rect>
                  <rect fill="#ebeff2" x="78" y="35" width="6.857142857142861" height="10"></rect>
                  <rect
                    fill="#f9aa33"
                    x="86.57142857142857"
                    y="0"
                    width="6.857142857142861"
                    height="45"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="95.14285714285714"
                    y="10"
                    width="6.857142857142861"
                    height="35"
                  ></rect>
                  <rect
                    fill="#f9aa33"
                    x="103.71428571428571"
                    y="35"
                    width="6.857142857142861"
                    height="10"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="112.28571428571429"
                    y="40"
                    width="6.857142857142847"
                    height="5"
                  ></rect>
                </svg>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Start of Recent Order -->
    </div>
    <div class="row hidden-lg-and-up">
      <div class="col-lg-4">
        <div class="card-box">
          <div class="bar-widget">
            <div class="table-box">
              <div class="table-detail">
                <v-btn fab icon color="primary" :ripple="false">
                  <v-icon large color="white">shopping_basket</v-icon>
                </v-btn>
              </div>

              <div class="table-detail">
                <h4 class="m-t-0 m-b-5">
                  <b>{{available_orders}}</b>
                </h4>
                <p class="text-muted m-b-0 m-t-0">Total Available Orders</p>
              </div>
              <div class="table-detail text-right">
                <span
                  data-plugin="peity-bar"
                  data-width="120"
                  data-height="45"
                  style="display: none;"
                >5,3,9,6,5,9,7,3,5,2,9,7,2,1</span>
                <svg class="peity" height="45" width="120">
                  <rect
                    fill="#f9aa33"
                    x="0.8571428571428571"
                    y="20"
                    width="6.857142857142858"
                    height="25"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="9.428571428571429"
                    y="30"
                    width="6.857142857142856"
                    height="15"
                  ></rect>
                  <rect fill="#f9aa33" x="18" y="0" width="6.857142857142858" height="45"></rect>
                  <rect
                    fill="#ebeff2"
                    x="26.571428571428573"
                    y="15"
                    width="6.857142857142858"
                    height="30"
                  ></rect>
                  <rect
                    fill="#f9aa33"
                    x="35.14285714285714"
                    y="20"
                    width="6.857142857142861"
                    height="25"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="43.714285714285715"
                    y="0"
                    width="6.857142857142854"
                    height="45"
                  ></rect>
                  <rect
                    fill="#f9aa33"
                    x="52.285714285714285"
                    y="10"
                    width="6.857142857142861"
                    height="35"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="60.857142857142854"
                    y="30"
                    width="6.857142857142854"
                    height="15"
                  ></rect>
                  <rect
                    fill="#f9aa33"
                    x="69.42857142857143"
                    y="20"
                    width="6.857142857142861"
                    height="25"
                  ></rect>
                  <rect fill="#ebeff2" x="78" y="35" width="6.857142857142861" height="10"></rect>
                  <rect
                    fill="#f9aa33"
                    x="86.57142857142857"
                    y="0"
                    width="6.857142857142861"
                    height="45"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="95.14285714285714"
                    y="10"
                    width="6.857142857142861"
                    height="35"
                  ></rect>
                  <rect
                    fill="#f9aa33"
                    x="103.71428571428571"
                    y="35"
                    width="6.857142857142861"
                    height="10"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="112.28571428571429"
                    y="40"
                    width="6.857142857142847"
                    height="5"
                  ></rect>
                </svg>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Ban 2 -->
      <div class="col-lg-4">
        <div class="card-box">
          <div class="bar-widget">
            <div class="table-box">
              <div class="table-detail">
                <v-btn fab icon color="primary" :ripple="false">
                  <v-icon large color="white">how_to_reg</v-icon>
                </v-btn>
              </div>

              <div class="table-detail">
                <h4 class="m-t-0 m-b-5">
                  <b>{{delivered_orders}}</b>
                </h4>
                <p class="text-muted m-b-0 m-t-0">Total Delivered Orders</p>
              </div>
              <div class="table-detail text-right">
                <span
                  data-plugin="peity-bar"
                  data-colors="#f9aa33,#ebeff2"
                  data-width="120"
                  data-height="45"
                  style="display: none;"
                >5,3,9,6,5,9,7,3,5,2,9,7,2,1</span>
                <svg class="peity" height="45" width="120">
                  <rect
                    fill="#f9aa33"
                    x="0.8571428571428571"
                    y="20"
                    width="6.857142857142858"
                    height="25"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="9.428571428571429"
                    y="30"
                    width="6.857142857142856"
                    height="15"
                  ></rect>
                  <rect fill="#f9aa33" x="18" y="0" width="6.857142857142858" height="45"></rect>
                  <rect
                    fill="#ebeff2"
                    x="26.571428571428573"
                    y="15"
                    width="6.857142857142858"
                    height="30"
                  ></rect>
                  <rect
                    fill="#f9aa33"
                    x="35.14285714285714"
                    y="20"
                    width="6.857142857142861"
                    height="25"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="43.714285714285715"
                    y="0"
                    width="6.857142857142854"
                    height="45"
                  ></rect>
                  <rect
                    fill="#f9aa33"
                    x="52.285714285714285"
                    y="10"
                    width="6.857142857142861"
                    height="35"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="60.857142857142854"
                    y="30"
                    width="6.857142857142854"
                    height="15"
                  ></rect>
                  <rect
                    fill="#f9aa33"
                    x="69.42857142857143"
                    y="20"
                    width="6.857142857142861"
                    height="25"
                  ></rect>
                  <rect fill="#ebeff2" x="78" y="35" width="6.857142857142861" height="10"></rect>
                  <rect
                    fill="#f9aa33"
                    x="86.57142857142857"
                    y="0"
                    width="6.857142857142861"
                    height="45"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="95.14285714285714"
                    y="10"
                    width="6.857142857142861"
                    height="35"
                  ></rect>
                  <rect
                    fill="#f9aa33"
                    x="103.71428571428571"
                    y="35"
                    width="6.857142857142861"
                    height="10"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="112.28571428571429"
                    y="40"
                    width="6.857142857142847"
                    height="5"
                  ></rect>
                </svg>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Ban 3 -->
      <div class="col-lg-4">
        <div class="card-box">
          <div class="bar-widget">
            <div class="table-box">
              <div class="table-detail">
                <v-btn fab icon color="primary" :ripple="false">
                  <v-icon large color="white">attach_money</v-icon>
                </v-btn>
              </div>

              <div class="table-detail">
                <h4 class="m-t-0 m-b-5">
                  <b>{{delivered_revenue}}</b>
                </h4>
                <p class="text-muted m-b-0 m-t-0">Total Delivered Revenue</p>
              </div>
              <div class="table-detail text-right">
                <span
                  data-plugin="peity-bar"
                  data-colors="#f9aa33,#ebeff2"
                  data-width="120"
                  data-height="45"
                  style="display: none;"
                >5,3,9,6,5,9,7,3,5,2,9,7,2,1</span>
                <svg class="peity" height="45" width="120">
                  <rect
                    fill="#f9aa33"
                    x="0.8571428571428571"
                    y="20"
                    width="6.857142857142858"
                    height="25"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="9.428571428571429"
                    y="30"
                    width="6.857142857142856"
                    height="15"
                  ></rect>
                  <rect fill="#f9aa33" x="18" y="0" width="6.857142857142858" height="45"></rect>
                  <rect
                    fill="#ebeff2"
                    x="26.571428571428573"
                    y="15"
                    width="6.857142857142858"
                    height="30"
                  ></rect>
                  <rect
                    fill="#f9aa33"
                    x="35.14285714285714"
                    y="20"
                    width="6.857142857142861"
                    height="25"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="43.714285714285715"
                    y="0"
                    width="6.857142857142854"
                    height="45"
                  ></rect>
                  <rect
                    fill="#f9aa33"
                    x="52.285714285714285"
                    y="10"
                    width="6.857142857142861"
                    height="35"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="60.857142857142854"
                    y="30"
                    width="6.857142857142854"
                    height="15"
                  ></rect>
                  <rect
                    fill="#f9aa33"
                    x="69.42857142857143"
                    y="20"
                    width="6.857142857142861"
                    height="25"
                  ></rect>
                  <rect fill="#ebeff2" x="78" y="35" width="6.857142857142861" height="10"></rect>
                  <rect
                    fill="#f9aa33"
                    x="86.57142857142857"
                    y="0"
                    width="6.857142857142861"
                    height="45"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="95.14285714285714"
                    y="10"
                    width="6.857142857142861"
                    height="35"
                  ></rect>
                  <rect
                    fill="#f9aa33"
                    x="103.71428571428571"
                    y="35"
                    width="6.857142857142861"
                    height="10"
                  ></rect>
                  <rect
                    fill="#ebeff2"
                    x="112.28571428571429"
                    y="40"
                    width="6.857142857142847"
                    height="5"
                  ></rect>
                </svg>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Start of Recent Order -->
    </div>
  </div>
</template>

<script>
import axios from "../../../../axios";
import browserCookies from "browser-cookies";
import Toasted from "vue-toasted";
const user = browserCookies.get("user_id");
import { mapGetters } from 'vuex'

export default {
  name: "CourierSummaryCard",
  data() {
    return {
     available_orders :  this.$store.getters['courier/getAvailableOrdersSum'],
     delivered_orders :  this.$store.getters['courier/getDeliveredOrdersSum'],
     delivered_revenue : this.$store.getters['courier/getDeliveredRevenueSum']
    };
  },
  computed: {
    isLoading() {
      return this.$store.getters["courier/isLoading"];
    }
  },
  methods: {
  },

  mounted() {
this.$store.dispatch("courier/updateAvailableOrders")
this.$store.dispatch("courier/updateDeliveredOrders")
this.$store.dispatch("courier/updateDeliveredRevenue")
this.$store.subscribe((mutation, state) => {
  switch(mutation.type)
  {
    case "courier/updateAvailableOrders" :
    {
      this.available_orders = this.$store.getters['courier/getAvailableOrdersSum']

      break;
    }
    case "courier/updateDeliveredOrders":
    {
      this.delivered_orders = this.$store.getters['courier/getDeliveredOrdersSum']
      break;
    }
    case "courier/updateDeliveredRevenue" :
    {
      this.delivered_revenue = this.$store.getters['courier/getDeliveredRevenueSum']

      break;
    }

  }

})

}


};
</script>
<style scoped src="../../../assets/courier/css/core.scss"> </style>
