import axios from '../../axios';

const browserCookies = require('browser-cookies');

const user = browserCookies.get('user_id');
const blankOrder = {
  order_id: '',
  first_name: '',
  building: '',
  order_total: '',
  time_created: '',
};
const blankDeliveredOrder = {
  order_id: '',
  first_name: '',
  building: '',
  order_total: '',
  time_delivered: '',
};
const state = {
  availableOrders: [],
  acceptedOrders: [],
  deliveredOrders: [],
  isLoading: true,
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
};
const getters = {
  availableOrders: state => state.availableOrders,
  acceptedOrders: state => state.acceptedOrders,
  deliveredOrders: state => state.deliveredOrders,
  isLoading: state => state.isLoading,
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
  getAvailableOrders: ({ state, getters, commit }) => {
    axios
      .get(`/api/courier/${user}/order/`)
      .then((response) => {
        response.data.forEach((order) => {
          commit('addAvailableOrder', order);
        });

        commit('stopLoading');

        // Add blank 'orders' to even set data table rows to 5
        for (let i = getters.availableOrders.length; i < 5; i++) {
          commit('addAvailableOrder', blankOrder);
        }
      })
      .catch((error) => {
        console.log(error);
      });
  },
  getAcceptedOrders: ({ state, getters, commit }) => {
    axios
      .get(`/api/courier/${user}/order/accepted`)
      .then((response) => {
        response.data.forEach((order) => {
          commit('addAcceptedOrder', order);
        });

        commit('stopLoading');

        // Add blank 'orders' to even set data table rows to 5
        for (let i = getters.acceptedOrders.length; i < 5; i++) {
          commit('addAcceptedOrder', blankOrder);
        }
      })
      .catch(error => console.log(error));
  },
  getDeliveredOrders: ({ state, getters, commit }) => {
    axios
      .get(`/api/courier/${user}/order/delivered`)
      .then((response) => {
        response.data.forEach((order) => {
          commit('addDeliveredOrder', order);
        });

        commit('stopLoading');

        // Add blank 'orders' to even set data table rows to 5
        for (let i = getters.deliveredOrders.length; i < 5; i++) {
          commit('addDeliveredOrder', blankDeliveredOrder);
        }
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
};
export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
};
