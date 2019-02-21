const socket_io = require('socket.io');
const updateOpenOrders = require('./socket/updateOpenOrders')
const updateAcceptedOrders = require('./socket/updateAcceptedOrders')
const updateDeliveredOrders = require('./socket/updateDeliveredOrders')
const io = socket_io();

const socketApi = {};

socketApi.io = io;

io.on('connection', function (socket) {
    console.log('connected')
    socket.on('disconnect',function(data){
        console.log('disconnected')
    })
    socket.on('ORDER_CREATED', function(client){
        updateOpenOrders(client,socket)
    })
    socket.on('ORDER_ACCEPTED', function (client){
        updateAcceptedOrders(client,socket)
    })
    socket.on('ORDER_DELIVERED', function (client){
        updateDeliveredOrders(client, socket)
    })
});

module.exports = socketApi;
