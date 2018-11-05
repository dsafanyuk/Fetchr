const express = require('express');
const router = express.Router();

const orderController = require('./orderController');

router.get('/', orderController.showAllOrders);
router.get('/:order_id', orderController.showOneOrder);
router.patch('/:order_id', orderController.updateOrder);
router.post('/', orderController.createOrder);
router.get('/:order_id/summary', orderController.showOneOrderSummary);

module.exports = router;
