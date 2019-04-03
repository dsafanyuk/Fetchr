const express = require('express');

const router = express.Router();
const userRouter = require('../users/userRoute');
const orderRouter = require('../orders/orderRoute');
const productRouter = require('../products/productRoute');
const courierRouter = require('../courier/courierRoute');
const adminRouter = require('../admin/adminRoute');
const verifyToken = require('./verifyToken');

router.use('/users', userRouter);
router.use('/orders', verifyToken, orderRouter);
router.use('/products', verifyToken, productRouter);
router.use('/courier', courierRouter);
router.use('/admin', adminRouter);

module.exports = router;
