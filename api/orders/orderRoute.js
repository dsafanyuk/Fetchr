var express = require('express');
var router = express.Router();

orderController = require('./orderController')

router.get('/order', orderController.showAllOrders)
router.get('/order/:id', orderController.showOneOrder)
router.patch('/order/:id', orderController.updateOrder)
router.post('/order', orderController.createOrder)
router.delete('/order/:id', orderController.deleteOrder)

module.exports = router;
