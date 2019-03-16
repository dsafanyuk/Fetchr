/* eslint-disable consistent-return */
const knex = require('knex')(require('../db'));
const upload = require('../s3');
const { insertNewProduct, updateProduct, updateUser } = require('./adminHelper');
const { registerUser } = require('../users/registerController');

const singleUpload = upload.single('imageFile');

// GET /products
function showAllProducts(req, res) {
  const userId = req.header('user_id');
  if (userId) {
    knex('products')
      .select('*')
      .then((products) => {
        res.json(products).status(200);
      })
      .catch((err) => {
        res.status(500).json({
          message: `${err}`,
        }); // FOR DEBUGGING ONLY, dont json exact message in prod
      });
  } else {
    res.status(400).send('User_id cookie not set');
  }
}

function addProduct(req, res) {
  singleUpload(req, res, (err, some) => {
    console.log(req.body);
    if (err) {
      return res
        .status(422)
        .send({ errors: [{ title: 'Image Upload Error', detail: err.message }] });
    }
    // Insert into database
    const newProduct = req.body;
    newProduct.product_url = req.file.location;
    insertNewProduct(newProduct)
      .then(result => res.json({ message: result }))
      .catch(error => res.status(422).send({ message: error }));
  });
}

function editProduct(req, res) {
  singleUpload(req, res, (err, some) => {
    if (err) {
      return res
        .status(422)
        .send({ errors: [{ title: 'Image Upload Error', detail: err.message }] });
    }
    // Insert into database
    const newProduct = req.body;
    if (req.file) {
      newProduct.product_url = req.file.location;
    }
    updateProduct(newProduct)
      .then(result => res.json({ message: result }))
      .catch(error => res.status(422).send({ message: error }));
  });
}

function showAllUsers(req, res) {
  const userId = req.header('user_id');
  if (userId) {
    knex('users')
      .select(
        'user_id',
        'email_address',
        'first_name',
        'last_name',
        'phone_number',
        'wallet',
        'room_num',
        'is_active',
      )
      .then((users) => {
        res.json(users).status(200);
      })
      .catch((err) => {
        res.status(500).json({
          message: `${err}`,
        }); // FOR DEBUGGING ONLY, dont json exact message in prod
      });
  } else {
    res.status(400).send('User_id cookie not set');
  }
}

function addUser(req, res) {
  registerUser(req, res);
}

function editUser(req, res) {
  const user = req.body;
  updateUser(user)
    .then(result => res.json({ message: result }))
    .catch(error => res.status(422).send({ message: error }));
}

// Make these functions available to the router
module.exports = {
  showAllProducts,
  addProduct,
  editProduct,
  showAllUsers,
  addUser,
  editUser,
};
