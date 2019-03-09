import Vue from 'vue';
import Vuex from 'vuex';
import Vuetify from 'vuetify';
import VeeValidate from 'vee-validate';
import VueToast from 'vue-toasted';
import VueRouter from 'vue-router';
import VueSocketio from 'vue-socket.io-extended'
import App from './App.vue'
import io from 'socket.io-client'
import store from './store'
import router from './router'
import 'vuetify/dist/vuetify.min.css';

Vue.use(VueSocketio, 
        io(process.env.NODE_ENV === 'production' ? 'http://fetchrapp.com:3000'  : 'http://127.0.0.1:3000'),
        {store});
Vue.use(VueRouter);
Vue.use(VeeValidate);
Vue.use(VueToast);
Vue.use(Vuetify, {
  theme: {
    primary: '#344955',
    secondary: '#232534',
    lightened: '#4a6572',
    accent: '#f9aa33',
  },
});
Vue.use(Vuex);
new Vue({
  el: '#app',
  template: '<App/>',
  store,
  router,
  render: h => h(App),
});