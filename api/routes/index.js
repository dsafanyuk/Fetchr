var express = require('express');
var router = express.Router();
var userRouter = require ('../users/userRoute')
var orderRouter = require ('../orders/orderRoute')

router.use('/users', userRouter)
router.use('/orders', orderRouter)

module.exports = router;
