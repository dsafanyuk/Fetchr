var express = require("express");
var router = express.Router();
var dbOptions = require("../db");
var bcrypt = require('bcryptjs');
const knex = require("knex")(dbOptions);
const { validationResult } = require('express-validator/check');

// GET /user
function showAllUsers(req, res) {
    knex('users').select('*')
        .then((rows) => {
            res.send(rows).status(200)
        })
        .catch(function (err) {
            res.status(500).send({
                message: `${err}`
            }) // FOR DEBUGGING ONLY, dont send exact message in prod
        })
}

// GET /user/{id}
function showOneUser(req, res) {
    knex('users').where('user_id', req.params.user_id)
        .then((rows) => {
            res.send(rows).status(200)
        })
        .catch(function (err) {
            res.status(500).send({
                message: `${err}`
            }) // FOR DEBUGGING ONLY, dont send exact message in prod
        })
}
// GET /user/{id}/orders
function showUserOrders(req, res) {
    knex("orders").select('*').where('customer_id', req.params.user_id)
        .then((rows) => {
            res.send(rows)
        })
        .catch(function (err) {
            res.status(500).send({
                message: `${err}`
            }) // FOR DEBUGGING ONLY, dont send exact message in prod
        })
}

// POST /user/register
function registerUser(req, res) {
    const errors = validationResult(req); // Validation errors, if there is any

    // If errors is not empty, return error messages
    if (!errors.isEmpty()) {
        return res.status(422).json({ errors: errors.array() });
    }

    // new user with information from the request
    var newUser = {
        email_address: req.body.email_address,
        password: req.body.password,
        room_num: req.body.room_num,
        first_name: req.body.first_name,
        last_name: req.body.last_name
    }

    bcrypt.genSalt(10, function(err, salt) {
        // Hash the password
        bcrypt.hash(req.body.password, salt, function(err, hash) {
            console.log(`hash is ${hash}`);
            newUser.password = hash;

            // Compare hashed password with plaintext password
            bcrypt.compare(req.body.password, newUser.password, function(err, res) {
                console.log(res);
            });
        });
    });

    knex("users").insert(newUser)
        // if user successfully inserted
        .then((user_id) => {
            // Select the user that was just created
            knex("users").select('*').where('user_id', user_id)
                .then((rows) => {
                    res.status(201).send(`User created: ${rows[0].email_address}`)
                })
        })
        // else send err
        .catch(function (err) {
            res.status(500).send({
                message: `${err}`
            }) // FOR DEBUGGING ONLY, dont send exact message in prod
        })
}

// POST /user/login
function loginUser(req, res) {
    console.log('login succesful');
    res.redirect('/');
}

// POST /user
function createUser(req, res) {
    let request = req.body;
    console.log(request);
    knex("users").insert(request)
        // if user successfully inserted
        .then((user_id) => {
            // Select the user that was just created
            knex("users").select('*').where('user_id', user_id)
                .then((rows) => {
                    res.status(201).send(`User created: ${rows[0].email_address}`)
                })
        })
        // else send err
        .catch(function (err) {
            res.status(500).send({
                message: `${err}`
            }) // FOR DEBUGGING ONLY, dont send exact message in prod
        })
}


// UPDATE /user/{id}
function updateUser(req, res) {
    res.send("update user");
}

// DELETE /user/{id}
//TODO primary key error
//********************* */
/* Unhandled rejection Error: ER_ROW_IS_REFERENCED_2:
 Cannot delete or update a parent row: a foreign key constraint fails 
 (`fetchr_db`.`orders`, CONSTRAINT `courier_fk` 
 FOREIGN KEY (`courier_id`) 
 REFERENCES `users` (`user_id`))
*/

// Should we just have a 'deactivate account' option instead of a straight up delete?
function deleteUser(req, res) {
    knex("users").where('user_id', req.params.user_id).del()
        .then((rows) => {
            res.send('success').status(202)
        })
        .catch(function (err) {
            res.status(500).send({
                message: `${err}`
            }) // FOR DEBUGGING ONLY, dont send exact message in prod
        })
}
/*
function userAuthentication() {
    User.findOne({ username: req.body.email_address }, function(err, user) {
      if (err) { return done(err); }
      if (!user) {
        return done(null, false, { message: 'Incorrect username.' });
      }
      if (!user.validPassword(password)) {
        return done(null, false, { message: 'Incorrect password.' });
      }
      return done(null, user);
    });
  }*/

module.exports = {
    showAllUsers: showAllUsers,
    showOneUser: showOneUser,
    showUserOrders: showUserOrders,
    createUser: createUser,
    updateUser: updateUser,
    deleteUser: deleteUser,
    registerUser: registerUser,
    loginUser: loginUser
};
