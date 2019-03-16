import axios from '../../axios';

const browserCookies = require('browser-cookies');

const user = browserCookies.get('user_id');

const state = {
  products: [],
  users: [],
};

const mutations = {
  setProducts: (state, data) => {
    state.products.push(data);
  },
  resetProducts: (state) => {
    state.products = [];
  },
  setUsers: (state, data) => {
    state.users.push(data);
  },
  resetUsers: (state) => {
    state.users = [];
  },
};

const getters = {
  showProducts(state) {
    return state.products;
  },
  showUsers(state) {
    return state.users;
  },
};

const actions = {
  retrieveProducts: ({ state, getters, commit }) => {
    axios.get('api/admin/products').then((response) => {
      response.data.forEach((product) => {
        commit('setProducts', product);
      });
    });
  },
  createNewProduct: ({ state, commit, dispatch }, data) => {
    const formData = new FormData();
    Object.keys(data).forEach((formPart) => {
      formData.append(formPart, data[formPart]);
    });
    axios
      .post('api/admin/products', formData)
      .then((response) => {
        console.log(response);
        commit('resetProducts');
        dispatch('retrieveProducts');
      })
      .catch((err) => {
        console.log(err);
      });
  },
  editExistProduct: ({ state, commit, dispatch }, data) => {
    const formData = new FormData();
    Object.keys(data).forEach((formPart) => {
      formData.append(formPart, data[formPart]);
    });
    axios
      .put(`api/admin/product/${data.product_id}`, formData)
      .then((response) => {
        console.log(response);
        commit('resetProducts');
        dispatch('retrieveProducts');
      })
      .catch((err) => {
        console.log(err);
      });
  },
  retrieveUsers: ({ state, getters, commit }) => {
    axios.get('api/admin/users').then((response) => {
      response.data.forEach((product) => {
        commit('setUsers', product);
      });
    });
  },
  createNewUser: ({ state, commit, dispatch }, data) => {
    axios
      .post('api/admin/users', data)
      .then((response) => {
        console.log(response);
        commit('resetUsers');
        dispatch('retrieveUsers');
      })
      .catch((err) => {
        console.log(err);
      });
  },
  editExistingUser: ({ state, commit, dispatch }, data) => {
    axios
      .put(`api/admin/user/${data.user_id}`, data)
      .then((response) => {
        console.log(response);
        commit('resetUsers');
        dispatch('retrieveUsers');
      })
      .catch((err) => {
        console.log(err);
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
