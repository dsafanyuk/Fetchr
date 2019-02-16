module.exports = function(client,socket){
    socket.emit('UPDATE_OPEN_ORDERS')
    console.log('EVENT RECEIVED: ORDER_CREATED')

}
