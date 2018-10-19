var express = require('express');
var router = express.Router();

orderController = require('./orderController')

router.get('/', orderController.showAllOrders)
router.get('/:order_id', orderController.showOneOrder)
router.patch('/:order_id', orderController.updateOrder)
router.post('/', orderController.createOrder)
router.get('/:order_id/summary', orderController.showOneOrderSummary)

module.exports = router;