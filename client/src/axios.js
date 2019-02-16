import axios from 'axios';
import browserCookies from 'browser-cookies'
import store from './store'

// Create an instance of axios
let api = axios.create();

if (process.env.NODE_ENV == 'production') {
    api.defaults.baseURL = 'http://fetchrapp.com:3000';
  } else {
    api.defaults.baseURL = 'http://127.0.0.1:3000';
  }
  
  api.defaults.withCredentials = true; // force axios to have withCredentials with all requests.

// Called before every requests
api.interceptors.request.use((config) => {
    // Only set headers if user logged in
    if(store.getters["login/isLoggedIn"]) {
        config.headers['user_id'] = browserCookies.get('user_id');
        config.headers['token'] = browserCookies.get('token');
    }
    
    return config
  }, error => {
    return Promise.reject(error)
  })

  export default api;