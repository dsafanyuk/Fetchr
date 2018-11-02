const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const knex = require('knex')(require('../db'));

// POST /users/login
function loginUser(req, res) {
  let user = {}; // Object, contains id, email, and password of the user
  let passwordIsCorrect = false; // Boolean, true if password correct

  // Search user with the email address
  knex('users')
    .select('*')
    .where({email_address: req.body.email_address})
    .then(async (users) => {
      // If there is any row, compare password
      if (users.length) {
        // Compares hashed password with password
        passwordIsCorrect = await bcrypt.compare(
          req.body.password,
          `${users[0].password}`,
        );
      }

      // Creates token and send it as a response
      if (passwordIsCorrect) {
        user = {
          user_id: `${users[0].user_id}`,
          email_address: `${users[0].email_address}`,
        };
        jwt.sign({user}, 'secretkey', (err, token) => {
          if (err) {
            res.status(500).send(err);
          } else {
            res.json({
              token,
            });
          }
        });
      } else {
        res.status(401).send('Wrong password or email address');
      }
    })
    // else send err
    .catch((err) => {
      res.status(500).send({
        message: `${err}`,
      });
    });
}

module.exports = {
  loginUser,
};
