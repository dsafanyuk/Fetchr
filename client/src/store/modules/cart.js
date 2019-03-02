import axios from 'axios'
import Vue from 'vue'
const api = axios.create();

const state = {
    count: 0,
    showCart: false,
    cart: {},

}
const mutations = {
    toggleCart: (state, value) => {
        state.showCart = value
    },
    addItem: (state, product) => {
        Vue.set(state.cart, product.product_id, product);
        Vue.set(state.cart[product.product_id], 'quantity', 1);
    },
    removeItem: (state, product) => {
        Vue.delete(state.cart, product.product_id);
    },
    incQuantity: (state, product) => {
        console.log(state.cart[product.product_id]);
        state.cart[product.product_id].quantity++;
    },
    decQuantity: (state, product) => {
        state.cart[product.product_id].quantity--;
    }
}
const getters = {
    cartIsActive(state) {
        return state.showCart
    },
    cartItems(state) {
        return Object.values(state.cart);
    },
    totalCartItems(state) {
        return Object.keys(state.cart).length;
    },
    totalCartPrice(state) {
        var total = 0;

        Object.values(state.cart).forEach(cartItem => {
            total += cartItem.price * cartItem.quantity
        })
        return total.toFixed(2);
    }
}
export default {
    namespaced: true,
    state,
    getters,
    mutations
}
