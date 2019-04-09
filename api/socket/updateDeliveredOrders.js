module.exports = function (data, socket) {
    socket.emit('UPDATE_DELIVERED_ORDERS', data)
    console.log('EVENT RECEIVED: ORDER_DELIVERED')
}
