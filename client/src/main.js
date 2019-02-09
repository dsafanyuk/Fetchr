import Vue from 'vue';
import Vuetify from 'vuetify';
import VeeValidate from 'vee-validate';
import VueToast from 'vue-toasted';
import VueMaterial from 'vue-material';
import App from './Components/App.vue';
import VueRouter from 'vue-router';
import Home from './Components/Home.vue';
import Login from './Components/Login.vue';
import Register from './Components/Register.vue';
import Landing from './Components/Landing.vue';
import Orders from './Components/Orders.vue';
import Checkout from './Components/Checkout.vue';
import Confirmation from './Components/Confirmation.vue';
import Account from './Components/Account.vue'
import axios from 'axios';
import babel_polyfill from 'babel-polyfill';

import 'vuetify/dist/vuetify.min.css';

Vue.use(VueRouter);
Vue.use(babel_polyfill)
Vue.use(VeeValidate);
Vue.use(VueToast);
Vue.use(VueMaterial);
Vue.use(Vuetify, {
  theme: {
    primary: '#344955',
    secondary: '#232534',
    lightened: "#4a6572",
    accent: '#f9aa33'
  }
})
/*----------------------- Routes Declaration -----------------*/
const routes = [
  {path: '/', component: Home},
  {path: '/login', component: Login},
  {path: '/register', component: Register},
  {path: '/dashboard', component: Landing},
  {path: '/orders', component: Orders},
  {path: '/confirmation', component: Confirmation},
  {path: '/checkout', component: Checkout},
  {path: '/account', component: Account},
];

const router = new VueRouter({
  routes,
  mode: 'history',
});

if (process.env.NODE_ENV == 'production') {
  axios.defaults.baseURL = 'http://fetchrapp.com:3000';
} else {
  axios.defaults.baseURL = 'http://127.0.0.1:3000';
}

axios.defaults.withCredentials = true; // force axios to have withCredentials with all requests.
new Vue({
  el: '#app',
  template: '<App/>',
  router,
  render: (h) => h(App),
});
