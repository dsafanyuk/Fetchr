import Vue from 'vue'
import App from './Components/Home.vue'
import VueRouter from 'vue-router'
import Login from './Components/Login.vue'
import Register from './Components/Register.vue'

Vue.use(VueRouter);

/*----------------------- Routes Declaration -----------------*/
const routes = [
  {path : '/login', component : Login},
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
