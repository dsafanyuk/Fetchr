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

// Check if the user is authenticated or not
function requireAuth(to, from, next) {
    if(store.getters["login/getUserLoadStatus"] != 2) {
        // User not loaded
        store.commit('login/pending');

        // Watch user to be loaded
        store.watch( store.getters["login/getUserLoadStatus"], () => {
            if( store.getters["login/getUserLoadStatus"] == 2) {
                proceed(next);
            }
        });
    } else {
        proceed(next);
    }
}

// Determines where we should redirect the user
function proceed(next) {
    // Check load status
    if(store.getters["login/getUserLoadStatus"] == 2) {
        // Check if the user is logged in
        if(store.getters["login/isLoggedIn"]) {
            next();
        } else {
            next({path:'/login'});
        }
    }
}

/*----------------------- Routes Declaration -----------------*/
const routes = [
    {
      path: '/', component: MainLayout,
      children: [
      {
        path: '/account',
        component: Account,
        beforeEnter: requireAuth,
      },
      {
        path: '/orders',
        component: Orders,
        beforeEnter: requireAuth,
      },
      {
        path: '/dashboard',
        component: Dashboard,
        beforeEnter: requireAuth,
      },
      {
        path: '/confirmation',
        component: Confirmation,
        beforeEnter: requireAuth,
      },
      {
        path: '/checkout',
        component: Checkout,
        beforeEnter: requireAuth,
      },
      {
        path: '/view',
        component: View,
        beforeEnter: requireAuth,
      }
     ]
    },
    {path: '/home', component: Home},
    {path: '/login', component: Login},
    {path: '/register', component: Register},
    {path: '/courier', component : CourierLayout, beforeEnter: requireAuth},
  ];
  
const router = new VueRouter({
routes,
mode: 'history',
});

export default router;
