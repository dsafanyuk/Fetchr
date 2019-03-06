import Vue from 'vue';
import Vuex from 'vuex';
import Vuetify from 'vuetify';
import VeeValidate from 'vee-validate';
import VueToast from 'vue-toasted';
import VueRouter from 'vue-router';
import VueSocketio from 'vue-socket.io-extended';
import io from 'socket.io-client';
import App from './Components/App.vue';
import MainLayout from './Components/layouts/MainDashboard/MainLayout.vue';
import Home from './Components/Home.vue';
import Login from './Components/Login.vue';
import Register from './Components/Register.vue';
import Dashboard from './Components/layouts/MainDashboard/components/Landing.vue';
import Orders from './Components/layouts/MainDashboard/components/Orders.vue';
import Checkout from './Components/layouts/MainDashboard/components/Checkout.vue';
import Confirmation from './Components/layouts/MainDashboard/components/Confirmation.vue';
import View from './Components/layouts/MainDashboard/components/ViewOrder.vue';
import CourierLayout from './Components/layouts/CourierDashboard/CourierLayout.vue';
import Account from './Components/layouts/MainDashboard/components/Account.vue';
import store from './store';
import 'vuetify/dist/vuetify.min.css';

Vue.use(
  VueSocketio,
  io(process.env.NODE_ENV === 'production' ? 'http://fetchrapp.com:3000' : 'http://127.0.0.1:3000'),
  { store },
);

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
/* ----------------------- Routes Declaration -----------------*/
const routes = [
  {
    path: '/',
    component: MainLayout,
    children: [
      {
        path: '/account',
        component: Account,
      },
      {
        path: '/orders',
        component: Orders,
      },
      {
        path: '/dashboard',
        component: Dashboard,
      },
      {
        path: '/confirmation',
        component: Confirmation,
      },
      {
        path: '/checkout',
        component: Checkout,
      },
      {
        path: '/view',
        component: View,
      },
    ],
  },
  { path: '/home', component: Home },
  { path: '/login', component: Login },
  { path: '/register', component: Register },
  { path: '/courier', component: CourierLayout },
];

export const router = new VueRouter({
  routes,
  mode: 'history',
});

// Called before every route
router.beforeEach((to, from, next) => {
  if (store.getters['login/isLoggedIn']) {
    next();
  } else if (to.path == '/login' || to.path == '/register' || to.path == '/home') {
    next();
  } else {
    // Redirect to login page
    next({ path: '/login' });
  }
});

new Vue({
  el: '#app',
  template: '<App/>',
  store,
  router,
  render: h => h(App),
});
