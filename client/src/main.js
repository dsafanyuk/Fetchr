import Vue from 'vue'
import App from './Components/App.vue'
import VueRouter from 'vue-router'
import Home from './Components/Home.vue'
import Login from './Components/Login.vue'
import Register from './Components/Register.vue'

Vue.use(VueRouter);

/*----------------------- Routes Declaration -----------------*/
const routes = [
  {path : '/',         component : Home },
  {path : '/login',    component : Login  },
  {path : '/register', component : Register}
];

const router = new VueRouter({
  routes,
  mode : 'history'
});

new Vue({
  el: '#app',
  router,
  render: h => h(App)
})
