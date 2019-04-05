import axios from 'axios';
import store from '..';

const state = {
  // LOGIN STATUS
  // 0 -> No loading has begun
  // 1 -> Loading has started
  // 2 -> Loading completed succesfully
  // 3 -> Loading completed unsuccesfully
  loadStatus: 0,
  isLoggedIn: false,
  userId: '',
};

const actions = {
  login: (state) => {
    state.commit('pending');
    return new Promise((resolve) => {
      setTimeout(() => {
        state.commit('loginSuccess');
        resolve();
      }, 1000);
    });
  },
  logout: (state) => {
    state.commit('pending');
    return new Promise((resolve) => {
      setTimeout(() => {
        state.commit('logoutSuccess');
        store.commit('cart/clearCart');
        resolve();
      }, 1000);
    });
  },
};
const mutations = {
  pending(state) {
    state.loadStatus = 1;
  },
  loginSuccess(state) {
    state.isLoggedIn = true;
    state.loadStatus = 2;
  },
  loginFailed(state) {
    state.isLoggedIn = false;
    state.loadStatus = 3;
  },
  logoutSuccess(state) {
    state.isLoggedIn = false;
    state.loadStatus = 2;
  },
  logoutFailed(state) {
    state.isLoggedIn = false;
    state.loadStatus = 3;
  },
  setUserId(state, value) {
    state.userId = value;
  },
};
const getters = {
  getUserLoadStatus(state) {
    return state.loadStatus;
  },
  isLoggedIn(state) {
    return state.isLoggedIn;
  },
  getUserId(state) {
    return state.userId;
  },
};
export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations,
};
