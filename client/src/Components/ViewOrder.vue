<template>
    <v-app>
      <LandingHeader></LandingHeader>
      <div class="checkout">
          <v-layout row>
              <v-flex md7>
                <div class="orderHeader">
                    <h3>Order: #{{this.$route.query.order}}</h3>
                    <div>
                        <h4>Status: </h4><h5 class="status">{{status}}</h5>
                    </div>
                </div>
                <v-data-table
                :items="items"
                hide-headers
                :total-items="items.length"
                hide-actions
                class="elevation-1"
                >
                <template slot="items" slot-scope="props">
                    <td align="center">
                    <img :src="props.item.product_url" class="checkout-img">
                    </td>
                    <td class="body-2">{{ props.item.product_name }}</td>
                    <td class="text-xs-left">${{ (props.item.item_total).toFixed(2) }}</td>
                    <td class="text-xs-left"> {{ props.item.quantity }}</td>
                </template>
                <template slot="footer">
                    <td class="text-xs-right" :colspan="2">
                    <strong>Total</strong>
                    </td>
                    <td class="text-xs-left" :colspan="4">${{total.toFixed(2)}}</td>
                </template>
            </v-data-table>
          </v-flex>
          <v-spacer></v-spacer>
          <v-flex md4 v-if="courierInfo">
                <h3 class="courierInfoHeader">Courier Information</h3>
                <v-card class="text-xs-center courierInfo">
                    <div>
                        <span>{{courierInfo.first_name}} {{courierInfo.last_name}}</span>
                    </div>
                    <div>
                        <span>{{courierInfo.phone_number}}</span>
                    </div>
                    <div>
                        <span>Delivered Orders: {{courierInfo.delivered}}</span>
                    </div>
                    <v-divider></v-divider>
                    <v-btn
                        type="submit"
                        color="success"
                        class="chatButton"
                    >Chat with me!</v-btn>
                </v-card>
            </v-flex>
            <div v-else></div>
        </v-layout>
      </div>
      <LandingFooter></LandingFooter>
    </v-app>
  </template>
      
      <script>
  import LandingHeader from "./mini-components/LandingHeader.vue";
  import LandingFooter from "./mini-components/LandingFooter.vue";
  import browserCookies from "browser-cookies";
  import axios from "../axios";
  
  export default {
    data() {
      return {
          status: null,
          items: [],
          courierInfo: {},
          total: 0.0,
      };
    },
    mounted: function() {
            axios
                .get(`/api/orders/${this.$route.query.order}/summary`)
                .then((response) => {
                    let orderInfo = response.data.orderInfo[0];
                    if (orderInfo.customer_id != browserCookies.get('user_id')) {
                        this.$router.push("/orders");
                    }
                    this.items = response.data.productList;
                    this.status = orderInfo.delivery_status;
                    document.querySelector('.status').classList.add(this.status)
                    this.items.forEach(item => {
                        item.item_total = item.price * item.quantity;
                        this.total += item.item_total;
                    });
                });
            axios
                .get(`/api/courier/${this.$route.query.order}/courierInfo`)
                .then((response) => {
                    if (response.data[0].length == 0) {
                        this.courierInfo = false;
                    } else {
                        this.courierInfo = response.data[0][0];
                        this.courierInfo.phone_number = this.fixNumber(this.courierInfo.phone_number);
                    }
                });
    },
    methods: {
        fixNumber: function(number) {
            return '(' + number.substring(0,3) + ') ' + number.substring(3,6) + '-' + number.substring(6);
        }
    },
    components: {
      LandingHeader: LandingHeader,
      LandingFooter: LandingFooter
    }
  };
  </script>
<style scoped lang="css" src='./custom_css/vieworder.css' >
</style> 
  