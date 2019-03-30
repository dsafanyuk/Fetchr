import VueRouter from 'vue-router';
import browserCookies from 'browser-cookies';
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
import Chat from "./Components/layouts/MainDashboard/components/Chat.vue"
/*                 ADMIN                */
import AdminLayout from './Components/layouts/AdminDashboard/AdminLayout.vue';
import AdminDashboard from './Components/layouts/AdminDashboard/components/AdminDashboard.vue';
import AdminManageUsers from './Components/layouts/AdminDashboard/components/AdminManageUsers.vue';
import AdminManageProducts from './Components/layouts/AdminDashboard/components/AdminManageProducts.vue';



import NotFoundComponent from './Components/NotFoundComponent.vue';

import store from './store';

// Check if the user is authenticated or not
function requireAuth(to, from, next) {
  if (store.getters['login/getUserLoadStatus'] != 2) {
    // User not loaded
    store.commit('login/pending');

    // Watch user to be loaded
    store.watch(
      () => store.getters['login/getUserLoadStatus'],
      () => {
        if (store.getters['login/getUserLoadStatus'] == 2) {
          proceed(next);
        }
      },
    );
  } else {
    proceed(next);
  }
}

// Determines where we should redirect the user
function proceed(next) {
  // Check load status
  if (store.getters['login/getUserLoadStatus'] === 2) {
    // Check if the user is logged in & cookies have not expired
    if (
      store.getters['login/isLoggedIn']
      && browserCookies.get('token')
      && browserCookies.get('user_id')
    ) {
      next();
    } else {
      next({ path: '/login' });
    }
  }
}

/* ----------------------- Routes Declaration -----------------*/
const routes = [
  {
    path: '/admin',
    component: AdminLayout,
    beforeEnter: (to, from, next) => {
        if(browserCookies.get('is_admin') == true) {
            if (to.path == '/admin') {
                next({ path: '/admin/dashboard' });
            } else {
                next();
            }
        } else {
            next({ path: '/login'});
        }
    },
    children: [
      {
        path: 'dashboard',
        component: AdminDashboard,
        beforeEnter: requireAuth,
      },
      {
        path: 'users/manage',
        component: AdminManageUsers,
        beforeEnter: requireAuth,
      },
      {
        path: 'products/manage',
        component: AdminManageProducts,
        beforeEnter: requireAuth,
      },
    ],
  },
  {
    path: '/',
    component: MainLayout,
    beforeEnter: (to, from, next) => {
      if (to.path == '/') {
        if (window.localStorage.vuex) {
          next({ path: '/dashboard' });
        } else {
          next({ path: '/home' });
        }
      } else {
        next();
      }
    },
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
      },
      {
        path: '/chat/:order_id',
        component: Chat,
        beforeEnter: requireAuth,
      },

    ],
  },

  { path: '/home', component: Home },
  { path: '/login', component: Login },
  { path: '/register', component: Register },
  { path: '/courier', component: CourierLayout, beforeEnter: requireAuth },
  { path: '*', component: NotFoundComponent },
];

const router = new VueRouter({
  mode: 'history',
  routes,
  // On new route load, scroll to top
  scrollBehavior(to, from, savedPosition) {
    return { x: 0, y: 0 };
  },
});

export default router;
