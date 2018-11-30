import Vue from 'vue'
import Vuetify from 'vuetify'
import VeeValidate from 'vee-validate'
import VueToast from 'vue-toasted'

import App from './Components/App.vue'
import VueRouter from 'vue-router'
import Home      from './Components/Home.vue'
import Login     from './Components/Login.vue'
import Register  from './Components/Register.vue'
import Landing   from './Components/Landing.vue'
import Orders    from './Components/Orders.vue'
import Checkout from './Components/Checkout.vue'
import Confirmation from './Components/Confirmation.vue'

import VueMaterial from 'vue-material'
import 'vuetify/dist/vuetify.min.css'

Vue.use(VueRouter);
Vue.use(Vuetify);
Vue.use(VeeValidate);
Vue.use(VueToast)
Vue.use(VueMaterial)
/*----------------------- Routes Declaration -----------------*/
const routes = [
  {path : '/',         component : Home      },
  {path : '/login',    component : Login     },
  {path : '/register', component : Register  },
  {path : '/dashboard',  component : Landing },
  {path : '/orders',  component : Orders },
  {path : '/confirmation',  component : Confirmation },
  {path : '/checkout',  component : Checkout }
];

const router = new VueRouter({
  routes,
  mode: 'history',
});


new Vue({
  el: '#app',
  router,
  render: h => h(App)
})
