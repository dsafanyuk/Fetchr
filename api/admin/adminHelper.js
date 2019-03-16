const knex = require('knex')(require('../db'));

function insertNewProduct(newProduct) {
  return knex('products').insert({
    product_name: newProduct.product_name,
    price: newProduct.price,
    category: newProduct.category,
    product_url: newProduct.product_url,
  });
}
function updateProduct(product) {
  return knex('products')
    .where('product_id', product.product_id)
    .update({
      product_name: product.product_name,
      price: product.price,
      category: product.category,
      is_active: product.is_active,
      product_url: product.product_url,
    })
    .then(success => success)
    .catch(err => err);
}

function updateUser(user) {
  return knex('users')
    .where('user_id', user.user_id)
    .update({
      email_address: user.email_address,
      first_name: user.first_name,
      last_name: user.last_name,
      phone_number: user.phone_number,
      wallet: user.wallet,
      room_num: user.room_num,
      is_active: user.is_active,
    })
    .then(success => console.log('success'))
    .catch(err => console.log('err'));
}

module.exports = {
  insertNewProduct,
  updateProduct,
  updateUser,
};
