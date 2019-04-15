import Toasted from 'vue-toasted';
import Vue from 'vue';
import router from '../../router';

const browserCookies = require('browser-cookies');

Vue.use(Toasted);
const state = {};
const actions = {
  NOTIFY_ACCEPTED: ({ rootGetters }, message) => {
    const user = rootGetters['login/getUserId'];
    console.log('order accepted', message);
    if (message.user == user && router.path != '/home') {
      console.log('my order accepted', message);

      Vue.toasted.show(`Order #${message.order} has been accepted.`, {
        theme: 'bubble',
        position: 'top-center',
        action: [
          {
            class: 'toast-action',
            text: 'SHOW',
            onClick: (e, toastObject) => {
              toastObject.goAway(0);
              router.push(`/view?order=${message.order}`);
            },
          },
          {
            icon: 'clear',
            onClick: (e, toastObject) => {
              toastObject.goAway(0);
            },
          },
        ],
      });
    }
  },
  NOTIFY_DELIVERED: ({ rootGetters }, message) => {
    const user = rootGetters['login/getUserId'];
    if (message.user == user && router.path != '/home') {
      console.log('my order delivered', message);

      Vue.toasted.show(`Order #${message.order} has been delivered.`, {
        theme: 'bubble',
        position: 'top-center',
        action: [
          {
            text: 'SHOW',
            onClick: (e, toastObject) => {
              toastObject.goAway(0);
              router.push(`/view?order=${message.order}`);
            },
          },
          {
            icon: 'clear',
            onClick: (e, toastObject) => {
              toastObject.goAway(0);
            },
          },
        ],
      });
    }
  },
};
export default {
  namespaced: true,
  actions,
};
