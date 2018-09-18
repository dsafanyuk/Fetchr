var express = require('express');
var router = express.Router();

// GET /user
function showAllUsers(req,res){
    res.send('show all users')
}

// GET /user/{id}
function showOneUser(req,res){
    res.send('show one user')
}

// POST /user
function createUser(req,res){
    res.send('create user')
}

// UPDATE /user{id}
function updateUser(req,res){
    res.send('update user')
}

// DELETE /user/{id}
function deleteUser(req,res){
    res.send('delete me')
}



module.exports = {
    showAllUsers: showAllUsers,
    showOneUser: showOneUser,
    createUser: createUser,
    updateUser: updateUser,
    deleteUser: deleteUser
}
