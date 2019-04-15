module.exports = function (data, socket) {
    socket.emit('UPDATE_ACCEPTED_ORDERS', data)
    console.log('EVENT RECEIVED: ORDER_ACCEPTED')
}
