var express = require("express");
var router = express.Router();
var dbOptions = require("../db");
const knex = require("knex")(dbOptions);
const jwt = require('jsonwebtoken');

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
    jwt.verify(req.token, 'secretkey', (err, authData) => {
        // Display login user information if user id found
        if (authData.user.user_id === req.params.user_id) {
            res.json({
                message: "Post created",
                authData
            });
        }
        else {
            res.status(403).send({
                message: `error:${err} or user not found`
            });
        }
    });
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

// GET /user/login
function showLogin(req, res) {
    res.send(`Welcome to the login page user: ${req.query.email}`);
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

// Returns OK status if user has a CC in our system
function creditCheck(req, res) {
    knex('users_cc').count('user_id as numberOfCards').where('user_id', req.params.user_id)
        .then((userCCRows) => {
            if (userCCRows[0].numberOfCards) {
                res.send(200).status(200)
            } else {
                res.send(204).status(204)
            }
        })
        .catch(function (err){
            res.status(500).send({
                message: `${err}`
            }) // FOR DEBUGGING ONLY, dont send exact error message in prod
        })
}

module.exports = {
    showAllUsers: showAllUsers,
    showOneUser: showOneUser,
    showUserOrders: showUserOrders,
    createUser: createUser,
    updateUser: updateUser,
    deleteUser: deleteUser,
    registerUser: registerUser,
    loginUser: loginUser,
    showLogin: showLogin,
    creditCheck: creditCheck
};
