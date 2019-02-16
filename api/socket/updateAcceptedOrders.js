module.exports = function (client, socket) {
    socket.emit('UPDATE_ACCEPTED_ORDERS')
    console.log('EVENT RECEIVED: ORDER_ACCEPTED')

}
