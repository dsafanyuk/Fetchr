import axios from '../../axios';

const browserCookies = require('browser-cookies');

const user = browserCookies.get('user_id');

const state = {
  user: {},
};

const actions = {
  editExistingUser: ({ state, commit, dispatch }, data) => axios.put(`/api/users/${browserCookies.get('user_id')}`, data),
};

export default {
  namespaced: true,
  state,
  actions,
};
