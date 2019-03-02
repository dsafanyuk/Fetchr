module.exports = function(data,socket){
    socket.broadcast.emit('UPDATE_OPEN_ORDERS')
    console.log('EVENT RECEIVED: ORDER_CREATED')
}
