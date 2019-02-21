module.exports = function (client, socket) {
    socket.broadcast.emit('UPDATE_DELIVERED_ORDERS')
    console.log('EVENT RECEIVED: ORDER_DELIVERED')

}
