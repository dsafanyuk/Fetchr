import VueRouter from 'vue-router';
import MainLayout from './Components/layouts/MainDashboard/MainLayout.vue'
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
import store from './store'

/*----------------------- Routes Declaration -----------------*/
const routes = [
    {
      path: '/', component: MainLayout,
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
      }
     ]
    },
    {path: '/home', component: Home},
    {path: '/login', component: Login},
    {path: '/register', component: Register},
    {path: '/courier', component : CourierLayout},
  ];
  
  const router = new VueRouter({
    routes,
    mode: 'history',
  });
  
  // Called before every route
  router.beforeEach((to, from, next) => {
    if(store.getters["login/isLoggedIn"]) {
      next();
    } else if((to.path == "/login") || (to.path == "/register") || (to.path == "/home")) {
      next();
    } else {
      // Redirect to login page
      next({path:'/login'});
    }
  })

  export default router;