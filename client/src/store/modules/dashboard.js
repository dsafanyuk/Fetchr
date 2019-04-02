const state = {
  selectedCategory: 'Popular',
};
const mutations = {
  setSelectedCategory: (state, value) => {
    state.selectedCategory = value;
  },
};

const getters = {
  getSelectedCategory: state => state.selectedCategory,
};
export default {
  namespaced: true,
  state,
  getters,
  mutations,
};
