import axios from '../../axios'

const state = {
    orderStatus : '',
    courierInfo : false,
    order : '',
}
const mutations = {
    changeStatus: (state, status) => {
        state.orderStatus = status;
    },
    changeInfo: (state, info) => {
        state.courierInfo = info;
    },
    changeOrder: (state, order) => {
        state.order = order;
    },
}

const getters = {
    status: (state) => {
        return state.orderStatus;
    },
    info: (state) => {
        return state.courierInfo;
    },
    order: (state) => {
        return state.order;
    },
}

const actions = {
    getStatus: function({commit}, message) {
        axios
            .get(`/api/orders/${message.order}/summary`)
            .then(response => {
                commit('changeStatus', response.data.orderInfo[0].delivery_status);
            });
    },
    getInfo: function({commit}, order) {
        axios
        .get(`/api/courier/${order}/courierInfo`)
        .then(info => {
          if (info.data[0].length == 0) {
            commit('changeInfo', false);
          } else {
            let courierInfo = info.data[0][0];
            axios
            .get(`/api/courier/${courierInfo.courier_id}/getTotalDelivered`)
            .then(delivered => {
              let phone_number = courierInfo.phone_number;
              courierInfo.delivered = delivered.data[0][0].count_d;
              courierInfo.phone_number = 
                "(" +
                phone_number.substring(0, 3) +
                ") " +
                phone_number.substring(3, 6) +
                "-" +
                phone_number.substring(6);
              commit('changeInfo', courierInfo);
            })
          }
        });
      },
      socket_updateAcceptedOrders: ({ state, getters, commit, dispatch }, data) => {
          let notifyData = data
          let order = getters.order;
          if (order == notifyData.order) {
              dispatch('orders/getStatus', notifyData, {root:true})
              dispatch('orders/getInfo', notifyData.order, {root:true})
          } 
      },
      socket_updateDeliveredOrders: ({ state, getters, commit, dispatch }, data) => {
          let notifyData = data
          let order = getters.order;
          if (order == notifyData.order) {
              dispatch('orders/getStatus', notifyData, {root:true})
              dispatch('orders/getInfo', notifyData.order, {root:true})
          } 
      },
}

export default {
    namespaced: true,
    mutations,
    getters,
    state,
    actions,
}