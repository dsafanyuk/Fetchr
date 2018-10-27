const knex = require('knex')(require('../db'));

// GET /user
function showAllUsers(req, res) {
  knex('users').select('*')
    .then((rows) => {
      res.send(rows).status(200);
    })
    .catch((err) => {
      res.status(500).send({
        message: `${err}`,
      }); // FOR DEBUGGING ONLY, dont send exact message in prod
    });
}

// GET /user/{id}
function showOneUser(req, res) {
  // Check user id with value at the parameter
  if (req.token.user.userId === req.params.userId) {
    knex('users').select('*').where('userId', req.params.userId)
      .then((rows) => {
        res.send(rows).status(200);
      })
      .catch((err) => {
        res.status(500).send({
          message: `${err}`,
        });
      });
  } else {
    res.status(403).send('Unauthorized');
  }
}
// GET /user/{id}/orders
function showUserOrders(req, res) {
  knex('orders').select('*').where('customer_id', req.params.userId)
    .then((rows) => {
      res.send(rows);
    })
    .catch((err) => {
      res.status(500).send({
        message: `${err}`,
      }); // FOR DEBUGGING ONLY, dont send exact message in prod
    });
}

// GET /user/login
function showLogin(req, res) {
  res.send(`Welcome to the login page user: ${req.query.email}`);
}

// POST /user
function createUser(req, res) {
  const request = req.body;

  knex('users').insert(request)
    // if user successfully inserted
    .then((userId) => {
      // Select the user that was just created
      knex('users').select('*').where('user_id', userId)
        .then((rows) => {
          res.status(201).send(`User created: ${rows[0].email_address}`);
        });
    })
    // else send err
    .catch((err) => {
      res.status(500).send({
        message: `${err}`,
      }); // FOR DEBUGGING ONLY, dont send exact message in prod
    });
}


// UPDATE /user/{id}
function updateUser(req, res) {
  res.send('update user');
}

// Returns OK status if user has a CC in our system
function creditCheck(req, res) {
  knex('users_cc').count('user_id as numberOfCards').where('user_id', req.params.user_id)
    .then((userCCRows) => {
      if (userCCRows[0].numberOfCards) {
        res.send(200).status(200);
      } else {
        res.send(204).status(204);
      }
    })
    .catch((err) => {
      res.status(500).send({
        message: `${err}`,
      }); // FOR DEBUGGING ONLY, dont send exact error message in prod
    });
}

module.exports = {
  showAllUsers,
  showOneUser,
  showUserOrders,
  createUser,
  updateUser,
  showLogin,
  creditCheck,
};
