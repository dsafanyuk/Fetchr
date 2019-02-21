module.exports = function (client, socket) {
    socket.broadcast.emit('UPDATE_ACCEPTED_ORDERS')
    console.log('EVENT RECEIVED: ORDER_ACCEPTED')

}
