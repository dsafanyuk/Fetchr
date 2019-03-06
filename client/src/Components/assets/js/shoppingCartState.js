// shopping cart state
export default {
  data: {
    cart: []

  },
  add (product) {
    var found = _.find(this.data.cart, ['id', product.id])
    if(typeof found != 'object') {
      this.data.cart.push(product)
    }
  //  console.log(this.data.cart);
  }
 }
