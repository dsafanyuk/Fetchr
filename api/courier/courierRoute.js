const express = require('express');

const router = express.Router();
const courierController = require('./courierController');

router.get('/:user_id/order', courierController.availableOrders);
router.get('/:user_id/order/accepted', courierController.acceptedOrders);
router.get('/:user_id/order/delivered', courierController.deliveredOrders)
router.get('/:user_id/countAvailableOrder', courierController.countAvailableOrder);
router.get('/:user_id/getTotalDelivered', courierController.countDelivered);
router.get('/:user_id/getRevenue', courierController.getRevenue);
router.post('/accept', courierController.acceptOrder);
router.post('/deliver', courierController.deliverOrder);


module.exports = router;
