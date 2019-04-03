const state = {
  selectedCategory: 'Popular',
  searchTerm: '',
};
const mutations = {
  setSelectedCategory: (state, value) => {
    state.selectedCategory = value;
    window.scrollTo(0, 0);
  },
  setSearchTerm: (state, value) => {
    state.searchTerm = value;
    window.scrollTo(0, 0);
  },
};

const getters = {
  getSelectedCategory: state => state.selectedCategory,
  getSearchTerm: state => state.searchTerm,
};
export default {
  namespaced: true,
  state,
  getters,
  mutations,
};
