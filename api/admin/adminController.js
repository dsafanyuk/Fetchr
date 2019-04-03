/* eslint-disable consistent-return */
const Sentry = require('@sentry/node');
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
        Sentry.captureException(err);

        res.status(500).json({
          message: `${err}`,
        }); // FOR DEBUGGING ONLY, dont json exact message in prod
      });
  } else {
    Sentry.captureException(new Error('User_id cookie not set'));
    res.status(400).send('User_id cookie not set');
  }
}

function addProduct(req, res) {
  singleUpload(req, res, (err, some) => {
    if (err) {
      Sentry.captureException(err);
      return res
        .status(422)
        .send({ errors: [{ title: 'Image Upload Error', detail: err.message }] });
    }
    // Insert into database
    const newProduct = req.body;
    newProduct.product_url = req.file.location;
    insertNewProduct(newProduct)
      .then(result => res.json({ message: result }))
      .catch((error) => {
        Sentry.captureException(err);
        res.status(422).send({ message: error });
      });
  });
}

function editProduct(req, res) {
  singleUpload(req, res, (err, some) => {
    if (err) {
      Sentry.captureException(err);
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
      .catch((error) => {
        Sentry.captureException(err);
        res.status(422).send({ message: error });
      });
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
        Sentry.captureException(err);
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

function ordersPerDay(req, res) {
  knex
    .raw(
      `select count(if(dayofweek(time_delivered) = 1, order_id, null)) as Sunday,
                   count(if(dayofweek(time_delivered) = 2, order_id, null)) as Monday,
                   count(if(dayofweek(time_delivered) = 3, order_id, null)) as Tuesday,
                   count(if(dayofweek(time_delivered) = 4, order_id, null)) as Wednesday,
                   count(if(dayofweek(time_delivered) = 5, order_id, null)) as Thursday,
                   count(if(dayofweek(time_delivered) = 6, order_id, null)) as Friday,
                   count(if(dayofweek(time_delivered) = 7, order_id, null)) as Saturday
              from orders
             where time_delivered > current_date - interval 7 day`,
    )
    .then((response) => {
      res.json(response);
    })
    .catch((error) => {
      res.status(422).send({ message: error });
    });
}

function productsPerDay(req, res) {
  knex
    .raw(
      `select sum(if(dayofweek(time_delivered) = 1, quantity, 0)) as Sunday,
                   sum(if(dayofweek(time_delivered) = 2, quantity, 0)) as Monday,
                   sum(if(dayofweek(time_delivered) = 3, quantity, 0)) as Tuesday,
                   sum(if(dayofweek(time_delivered) = 4, quantity, 0)) as Wednesday,
                   sum(if(dayofweek(time_delivered) = 5, quantity, 0)) as Thursday,
                   sum(if(dayofweek(time_delivered) = 6, quantity, 0)) as Friday,
                   sum(if(dayofweek(time_delivered) = 7, quantity, 0)) as Saturday
              from orders
              join order_summary on orders.order_id = order_summary.order_id
             where time_delivered > current_date - interval 7 day`,
    )
    .then((response) => {
      res.json(response);
    })
    .catch((error) => {
      res.status(422).send({ message: error });
    });
}

function prodsSoldByCat(req, res) {
  knex
    .raw('call prodsSoldByCat();')
    .then((response) => {
      res.json(response);
    })
    .catch((error) => {
      res.status(422).send({ message: error });
    });
}

function totalOrders(req, res) {
  knex
    .raw('select count(*)as total from orders;')
    .then((response) => {
      res.json(response);
    })
    .catch((error) => {
      res.status(422).send({ message: error });
    });
}

function totalDelivered(req, res) {
  knex
    .raw('select count(*) as total from orders where delivery_status = \'delivered\'')
    .then((response) => {
      res.json(response);
    })
    .catch((error) => {
      res.status(422).send({ message: error });
    });
}

function totalUsers(req, res) {
  knex
    .raw('select count(*) as total from users')
    .then((response) => {
      res.json(response);
    })
    .catch((error) => {
      res.status(422).send({ message: error });
    });
}

function totalAmountOrdered(req, res) {
  knex
    .raw('select sum(order_total) as total from orders')
    .then((response) => {
      res.json(response);
    })
    .catch((error) => {
      res.status(422).send({ message: error });
    });
}

function recentOrders(req, res) {
  knex
    .raw(
      `select order_id, first_name, last_name, order_total
              from orders
              join users on users.user_id = orders.customer_id
             order by order_id desc
             limit 3`,
    )
    .then((response) => {
      res.json(response);
    })
    .catch((error) => {
      res.status(422).send({ message: error });
    });
}

function topThreeCouriers(req, res) {
  knex
    .raw(
      `with info as (select user_id, first_name, last_name, delivery_status, order_id
                            from orders
                            join users on users.user_id = orders.courier_id)
            select first_name, last_name,
                   count(if(delivery_status = 'delivered', order_id, null)) as 'delivered',
                   count(if(delivery_status = 'in-progress', order_id, null)) as 'in_progress'
              from info
             group by user_id, first_name, last_name
             order by count(*) desc
             limit 3;`,
    )
    .then((response) => {
      res.json(response);
    })
    .catch((error) => {
      res.status(422).send({ message: error });
    });
}

// Make these functions available to the router
module.exports = {
  showAllProducts,
  addProduct,
  editProduct,
  showAllUsers,
  addUser,
  editUser,
  ordersPerDay,
  productsPerDay,
  prodsSoldByCat,
  totalOrders,
  totalDelivered,
  totalUsers,
  totalAmountOrdered,
  recentOrders,
  topThreeCouriers,
};
