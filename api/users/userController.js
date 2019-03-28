const Sentry = require('@sentry/node');
const knex = require('knex')(require('../db'));

// GET /users/{user_id}
function showOneUser(req, res) {
  // Check user id with value at the parameter
  if (req.token.user.user_id === req.params.user_id) {
    knex('users')
      .select('*')
      .where('user_id', req.params.user_id)
      .then((rows) => {
        res.send(rows).status(200);
      })
      .catch((err) => {
        Sentry.captureException(err);

        res.status(500).send({
          message: `${err}`,
        });
      });
  } else {
    res.status(403).send({ message: 'Unauthorized' });
  }
}
// GET /users/{user_id}/orders
function showUserOrders(req, res) {
  knex('orders')
    .select('*')
    .where('customer_id', req.params.user_id)
    .orderBy('order_id', 'desc')
    .then((rows) => {
      res.send(rows);
    })
    .catch((err) => {
      Sentry.captureException(err);
      res.status(500).send({
        message: `${err}`,
      }); // FOR DEBUGGING ONLY, dont send exact message in prod
    });
}

// POST /user
function createUser(req, res) {
  const request = req.body;

  knex('users')
    .insert(request)
    // if user successfully inserted
    .then((user_id) => {
      // Select the user that was just created
      knex('users')
        .select('*')
        .where('user_id', user_id)
        .then((rows) => {
          res.status(201).send(`User created: ${rows[0].email_address}`);
        });
    })
    // else send err
    .catch((err) => {
      Sentry.captureException(err);

      res.status(500).send({
        message: `${err}`,
      }); // FOR DEBUGGING ONLY, dont send exact message in prod
    });
}

// UPDATE /users/{id}
function updateUser(req, res) {
  res.send('update user');
}

// Returns OK status if user has a CC in our system
function creditCheck(req, res) {
  knex('users_cc')
    .count('user_id as numberOfCards')
    .where('user_id', req.params.user_id)
    .then((userCCRows) => {
      if (userCCRows[0].numberOfCards) {
        res.send(200).status(200);
      } else {
        res.send(204).status(204);
      }
    })
    .catch((err) => {
      Sentry.captureException(err);

      res.status(500).send({
        message: `${err}`,
      }); // FOR DEBUGGING ONLY, dont send exact error message in prod
    });
}

// POST /users/favorite
// send in request body { "user_id": {their user id}, "product_id": {the product id} }
function favorite(req, res) {
  knex('favorites')
    .insert({
      user_id: req.body.user_id,
      product_id: req.body.product_id,
    })
    .then(() => {
      res.send(200).status(200);
    })
    .catch((err) => {
      Sentry.captureException(err);

      res.status(500).send({
        message: `${err}`,
      }); // FOR DEBUGGING ONLY, dont send exact error message in prod
    });
}

// DELETE /users/unfavorite
// send in request body { "user_id": {their user id}, "product_id": {the product id} }
function unfavorite(req, res) {
  if (!req.body.user_id || !req.body.product_id) {
    res.status(400).send('missing info');
  } else {
    knex('favorites')
      .where({
        user_id: req.body.user_id,
        product_id: req.body.product_id,
      })
      .del()
      .then(() => {
        res.send(200).status(200);
      })
      .catch((err) => {
        Sentry.captureException(err);

        res.status(500).send({
          message: `${err}`,
        }); // FOR DEBUGGING ONLY, dont send exact error message in prod
      });
  }
}

// GET /users/{user_id}/favorites
function favorites(req, res) {
  knex('favorites')
    .select('*')
    .where('user_id', req.params.user_id)
    .innerJoin('products', 'products.product_id', 'favorites.product_id')
    .then((favorites) => {
      res.send(favorites).status(200);
    })
    .catch((err) => {
      Sentry.captureException(err);

      res.status(500).send({
        message: `${err}`,
      }); // FOR DEBUGGING ONLY, dont send exact message in prod
    });
}
// POST /users/:user_id/wallet
function addBalance(req, res) {
  knex('users')
    .where('user_id', req.params.user_id)
    .increment('wallet', req.body.amount)
    .then(() => {
      res.send('success').status(200);
    })
    .catch((err) => {
      Sentry.captureException(err);

      res.status(500).send({
        message: `${err}`,
      });
    });
}

// GET /users/{user_id}/wallet
function checkBalance(req, res) {
  knex('users')
    .select('wallet')
    .where('user_id', req.params.user_id)
    .then((balance) => {
      res.send(balance).status(200);
    })
    .catch((err) => {
      Sentry.captureException(err);

      res.status(500).send({
        message: `${err}`,
      });
    });
}

// PUT /users/:user_id
function editUser(req, res) {
  const user = req.body;
  const { user_id } = req.params;
  knex('users')
    .where('user_id', user_id)
    .update({
      first_name: user.first_name,
      last_name: user.last_name,
      room_num: user.room_num,
      phone_number: user.phone_number,
    })
    .then(() => {
      res.status(200).send('success');
    })
    .catch((err) => {
      console.log(err);
      res.send(err);
    });
}
module.exports = {
  showOneUser,
  showUserOrders,
  createUser,
  updateUser,
  creditCheck,
  favorite,
  favorites,
  unfavorite,
  addBalance,
  checkBalance,
  editUser,
};
