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
        .catch(function (e) {
            res.send(e.sqlMessage)
        })
}

// GET /user/{id}
function showOneUser(req, res) {
    knex('users').where('user_id', req.params.user_id)
        .then((rows) => {
            res.send(rows).status(200)
        })
        .catch(function(err){
            res.status(500).send({ message: `${err}`}) // FOR DEBUGGING ONLY, send 500 only in prod
        })
}

// POST /user
function createUser(req, res) {
    let request = req.body;
    knex("users").insert(request)
        .then(function () {
            res.status(201).send('user created')
        })
        .catch(function (e) {
            res.send(e.sqlMessage)
        })
}


// UPDATE /user{id}
function updateUser(req, res) {
    res.send("update user");
}

// DELETE /user/{id}
function deleteUser(req, res) {
    res.send("delete me");
}

module.exports = {
    showAllUsers: showAllUsers,
    showOneUser: showOneUser,
    createUser: createUser,
    updateUser: updateUser,
    deleteUser: deleteUser
};
