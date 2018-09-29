var express = require("express");
var router = express.Router();
var dbOptions = require("../db");

const knex = require("knex")(dbOptions);
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

// POST /user
function createUser(req, res) {
    let request = req.body;
    knex("users").insert(request)
        // if user successfully inserted
        .then((rows) => {
            // Select the user that was just created
            knex("users").select('*').where('user_id', rows)
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


// UPDATE /user{id}
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

module.exports = {
    showAllUsers: showAllUsers,
    showOneUser: showOneUser,
    showUserOrders: showUserOrders,
    createUser: createUser,
    updateUser: updateUser,
    deleteUser: deleteUser
};
