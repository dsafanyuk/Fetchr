const express = require('express');

const router = express.Router();
const userRouter = require('../users/userRoute');
const orderRouter = require('../orders/orderRoute');
const productRouter = require('../products/productRoute');
const courierRouter = require('../courier/courierRoute');

router.use('/users', userRouter);
router.use('/orders', orderRouter);
router.use('/products', productRouter);
router.use('/courier', courierRouter);

module.exports = router;
