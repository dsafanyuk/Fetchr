import axios from '../../axios';
import router from '../../router';

const state = {
  availableOrders: [],
  acceptedOrders: [],
  deliveredOrders: [],
  isLoading: true,
  deliveredRevenueSum: 0,
};
const mutations = {
  addAvailableOrder: (state, data) => {
    state.availableOrders.push(data);
  },
  addAcceptedOrder: (state, data) => {
    state.acceptedOrders.push(data);
  },
  addDeliveredOrder: (state, data) => {
    state.deliveredOrders.push(data);
  },
  clearAvailableOrder: (state, data) => {
    state.availableOrders = [];
  },
  clearAcceptedOrder: (state, data) => {
    state.acceptedOrders = [];
  },
  clearDeliveredOrder: (state, data) => {
    state.deliveredOrders = [];
  },
  stopLoading: (state, data) => {
    state.isLoading = false;
  },
  startLoading: (state, data) => {
    state.isLoading = true;
  },
  updateDeliveredRevenue: (state, value) => {
    state.deliveredRevenueSum = value;
  },
};
const getters = {
  availableOrders: state => state.availableOrders,
  acceptedOrders: state => state.acceptedOrders,
  deliveredOrders: state => state.deliveredOrders,
  isLoading: state => state.isLoading,
  getDeliveredRevenueSum: state => state.deliveredRevenueSum,
};
const actions = {
  clearAllOrders: ({ state, getters, commit }) => new Promise(
    (resolve, reject) => {
      commit('clearAvailableOrder');
      commit('clearAcceptedOrder');
      commit('clearDeliveredOrder');
      resolve();
    },
    (error) => {
      reject();
    },
  ),
  refreshAllOrders: ({
    state, getters, commit, dispatch,
  }) => {
    dispatch('getAvailableOrders');
    dispatch('getAcceptedOrders');
    dispatch('getDeliveredOrders');
  },
  getAvailableOrders: ({
    state, getters, commit, rootGetters,
  }) => {
    const user = rootGetters['login/getUserId'];
    axios
      .get(`/api/courier/${user}/order/available`)
      .then((response) => {
        response.data.forEach((order) => {
          commit('addAvailableOrder', order);
        });

        commit('stopLoading');
      })
      .catch((error) => {
        console.log(error);
      });
  },
  getAcceptedOrders: ({
    state, getters, commit, rootGetters,
  }) => {
    const user = rootGetters['login/getUserId'];

    axios
      .get(`/api/courier/${user}/order/accepted`)
      .then((response) => {
        response.data.forEach((order) => {
          commit('addAcceptedOrder', order);
        });

        commit('stopLoading');
      })
      .catch(error => console.log(error));
  },
  getDeliveredOrders: ({
    state, getters, commit, rootGetters,
  }) => {
    const user = rootGetters['login/getUserId'];

    axios
      .get(`/api/courier/${user}/order/delivered`)
      .then((response) => {
        response.data.forEach((order) => {
          commit('addDeliveredOrder', order);
        });

        commit('stopLoading');
      })
      .catch((error) => {
        console.log(error);
      });
  },
  socket_updateOpenOrders: ({
    state, getters, commit, dispatch,
  }) => {
    if(router.history.current.fullPath == "/courier") {
      dispatch('clearAllOrders').then(() => {
        dispatch('refreshAllOrders');
      });
    }
  },
  socket_updateAcceptedOrders: ({
    state, getters, commit, dispatch,
  }, data) => {
    const notifyData = data;

    commit('notification/NOTIFY_ACCEPTED', notifyData, { root: true });
    console.log('EVENT RECEIVED: UPDATE_ACCEPTED_ORDERS');
    if(router.history.current.fullPath == "/courier") {
      dispatch('clearAllOrders').then(() => {
        dispatch('refreshAllOrders');
      });
    }
  },
  socket_updateDeliveredOrders: ({
    state, getters, commit, dispatch,
  }, data) => {
    const notifyData = data;
    commit('notification/NOTIFY_DELIVERED', notifyData, { root: true });
    console.log('EVENT RECEIVED: UPDATE_DELIVERED_ORDERS');
    if(router.history.current.fullPath == "/courier") {
      dispatch('clearAllOrders').then(() => {
        dispatch('refreshAllOrders');
      });
    }
  },
  updateDeliveredRevenue: ({ commit, rootGetters }) => {
    const user = rootGetters['login/getUserId'];

    axios.get(`/api/courier/${user}/getRevenue`).then((response) => {
      commit('updateDeliveredRevenue', response.data[0][0].revenue);
    });
  },
};
export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
};
