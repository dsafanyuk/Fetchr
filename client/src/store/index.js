import Vue from 'vue';
import Vuex from 'vuex';
import createPersistedState from 'vuex-persistedstate';
import cart from './modules/cart';
import dashboard from './modules/dashboard';
import wallet from './modules/wallet';
import courier from './modules/courier';
import login from './modules/login';
import chat from './modules/chat';
import notification from './modules/notification';
import admin from './modules/admin';
import orders from './modules/orders';
import account from './modules/account';


Vue.use(Vuex);

const debug = process.env.NODE_ENV !== 'production';

export default new Vuex.Store({
  plugins: [
    createPersistedState({
      reducer: (persistedState) => {
        const stateFilter = Object.assign({}, persistedState);
        const blackList = ['courier', 'admin'];

        blackList.forEach((item) => {
          delete stateFilter[item];
        });
        return stateFilter;
      },
    }),
  ],
  modules: {
    cart,
    courier,
    wallet,
    login,
    notification,
    admin,
    orders,
    chat,
    account,
    dashboard,
  },
  strict: debug,
});
