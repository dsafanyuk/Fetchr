import axios from '../../axios';

const state = {
  availableOrders: [],
  acceptedOrders: [],
  deliveredOrders: [],
  isLoading: true,
  availableOrdersSum: 0,
  deliveredOrdersSum: 0,
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
  updateAvailableOrders: (state, value) => {
    state.availableOrdersSum = value;
  },

  updateDeliveredOrders: (state, value) => {
    state.deliveredOrdersSum = value;
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
  getAvailableOrdersSum: state => state.availableOrdersSum,
  getDeliveredOrdersSum: state => state.deliveredOrdersSum,
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
      .get(`/api/courier/${user}/order/`)
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
        loadingOrdersToast.goAway();
        this.$toasted.error('Something went wrong');
      });
  },
  socket_updateOpenOrders: ({
    state, getters, commit, dispatch,
  }) => {
    dispatch('clearAllOrders').then(() => {
      dispatch('refreshAllOrders');
      dispatch('updateAvailableOrders');
    });
  },
  socket_updateAcceptedOrders: ({
    state, getters, commit, dispatch,
  }, data) => {
    const notifyData = data;
    commit('notification/NOTIFY_ACCEPTED', notifyData, { root: true });
    console.log('EVENT RECEIVED: UPDATE_ACCEPTED_ORDERS');
    dispatch('clearAllOrders').then(() => {
      dispatch('refreshAllOrders');
    });
  },
  socket_updateDeliveredOrders: ({
    state, getters, commit, dispatch,
  }, data) => {
    const notifyData = data;
    commit('notification/NOTIFY_DELIVERED', notifyData, { root: true });
    console.log('EVENT RECEIVED: UPDATE_DELIVERED_ORDERS');
    dispatch('clearAllOrders').then(() => {
      dispatch('refreshAllOrders');
    });
  },
  updateAvailableOrders: ({ commit, rootGetters }) => {
    const user = rootGetters['login/getUserId'];

    axios.get(`/api/courier/${user}/countAvailableOrder`).then((response) => {
      commit('updateAvailableOrders', response.data[0][0].count_av);
    });
  },
  updateDeliveredOrders: ({ commit, rootGetters }) => {
    const user = rootGetters['login/getUserId'];

    axios.get(`/api/courier/${user}/getTotalDelivered`).then((response) => {
      commit('updateDeliveredOrders', response.data[0][0].count_d);
    });
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
