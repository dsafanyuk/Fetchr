var express = require('express');
var router = express.Router();

// GET /order
function showAllOrders(req,res){
    res.send('show all orders')
}

// GET /order/{id}
function showOneOrder(req,res){
    res.send('show one order')
}

// POST /order
function createOrder(req,res){
    res.send('create order')
}

// UPDATE /order{id}
function updateOrder(req,res){
    res.send('update order')
}

// DELETE /order/{id}
function deleteOrder(req,res){
    res.send('delete me')
}



module.exports = {
    showAllOrders: showAllOrders,
    showOneOrder: showOneOrder,
    createOrder: createOrder,
    updateOrder: updateOrder,
    deleteOrder: deleteOrder
}
