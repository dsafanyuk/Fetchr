var express = require('express');
var router = express.Router();
var dbOptions = require("../db");

const knex = require("knex")(dbOptions);

// GET /orders
function showAllOrders(req,res){
    knex('orders').select('*')
        .then((rows) => {
            res.send(rows).status(200)
        })
        .catch(function (err) {
            res.status(500).send({
                message: `${err}`
            }) // FOR DEBUGGING ONLY, dont send exact message in prod
        })
}

// GET /orders/{id}
function showOneOrder(req,res){
    knex('orders').where('order_id', req.params.order_id)
        .then((rows) => {
            res.send(rows).status(200)
        })
        .catch(function (err) {
            res.status(500).send({
                message: `${err}`
            }) // FOR DEBUGGING ONLY, dont send exact message in prod
        })
}

// POST /orders
function createOrder(req,res){
    let request = req.body;
    knex("orders").insert(request)
        // if order successfully inserted
        .then((order_id) => {
            // Select the order that was just created
            knex("orders").select('*').where('order_id', order_id)
                .then((rows) => {
                    res.status(201).send(`Order created for id ${rows[0].order_id}`)
                })
        })
        // else send err
        .catch(function (err) {
            res.status(500).send({
                message: `${err}`
            }) // FOR DEBUGGING ONLY, dont send exact message in prod
        })
}

// UPDATE /orders{id}
function updateOrder(req,res){
    let order = req.body;
    knex('orders').where('order_id', req.params.order_id)
        .update({
            customer_id: order.customer_id,
            courier_id: order.courier_id,
            delivery_status: order.delivery_status,
            time_delivered: order.time_delivered
        })
        .then((rows) => {
            res.send('success').status(200)
        })

        .catch(function (err) {
            res.status(500).send({
                message: `${err}`
            }) // FOR DEBUGGING ONLY, dont send exact message in prod
        })
}

// GET /orders/{id}/summary
function showOneOrderSummary(req,res){
    // Retrieve order summary
    knex('orders')
        .innerJoin('order_summary', 'orders.order_id', 'order_summary.order_id')
        .innerJoin('products', 'order_summary.product_id', 'products.product_id')
        .where('orders.order_id', req.params.order_id)
        .select('product_name', 'quantity', 'price', 'product_url')
        .then((product) => {
            product.forEach(row => {
                product.price = product.price * product.quantity;
            });
            res.send(product).status(200)
        })
        .catch(function (err) {
            res.status(500).send({
                message: `${err}`
            }) // FOR DEBUGGING ONLY, dont send exact message in prod
        })
}


module.exports = {
    showAllOrders: showAllOrders,
    showOneOrder: showOneOrder,
    createOrder: createOrder,
    updateOrder: updateOrder,
    showOneOrderSummary: showOneOrderSummary
}
