module.exports = function(socket){
    socket.emit('UPDATE_OPEN_ORDERS')
    console.log('EVENT RECEIVED: ORDER_CREATED')
}
