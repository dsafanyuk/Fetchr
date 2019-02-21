import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'
import cart from './modules/cart'
import wallet from './modules/wallet'
import courier from './modules/courier'
import login from './modules/login'

Vue.use(Vuex)

const debug = process.env.NODE_ENV !== 'production'

export default new Vuex.Store({
    plugins: [createPersistedState({
        reducer: (persistedState) => {
            const stateFilter = Object.assign({}, persistedState)
            const blackList = ['courier']

            blackList.forEach((item) => {
                delete stateFilter[item]
            })
            return stateFilter
        }
    })],
    modules: {
        cart,
        courier,
        wallet,
        login,
    },
    strict: debug,
});
