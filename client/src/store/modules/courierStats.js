import axios from '../../axios';
import browserCookies from "browser-cookies";
import store from '../../store'


const user = browserCookies.get("user_id");


const state = {
  availableOrdersSum :0,
  deliveredOrdersSum:0,
  deliveredRevenueSum: 0
};
const mutations = {
  updateAvailableOrders: (state, value) => {
    state.availableOrdersSum = value

  },

  updateDeliveredOrders: (state, value) => {
    state.deliveredOrdersSum = value

  },
  updateDeliveredRevenue: (state, value) => {
    state.deliveredRevenueSum = value


  },

};

const actions = {
  updateAvailableOrders : ({ commit })=> {

    axios
      .get("/api/courier/" + user + "/countAvailableOrder")
      .then(response => {
        commit('updateAvailableOrders', response.data[0][0]["count_av"])
      });
  },
  updateDeliveredOrders:({ commit })=>{
    axios
      .get("/api/courier/" + user + "/getTotalDelivered")
      .then(response => {
        commit('updateDeliveredOrders', response.data[0][0]["count_d"])

      });
  },
  updateDeliveredRevenue : ({ commit })=> {
    axios.get("/api/courier/" + user + "/getRevenue").then(response => {
        console.log( response.data[0][0]["revenue"]);
        commit('updateDeliveredRevenue', response.data[0][0]["revenue"])
    });
  }
}
const getters = {
  getAvailableOrdersSum :  state => state.availableOrdersSum,
  getDeliveredOrdersSum :  state => state.deliveredOrdersSum,
  getDeliveredRevenueSum   : state  => state.deliveredRevenueSum,
}
export default {
  namespaced: true,
  state,
  actions,
  mutations,
  getters
};
