module.exports = function (data, socket) {
    socket.broadcast.emit('UPDATE_DELIVERED_ORDERS', data)
    console.log('EVENT RECEIVED: ORDER_DELIVERED')
}
