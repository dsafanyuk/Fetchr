var express = require('express');
var router = express.Router();
var userRouter = require ('../users/userRoute')
var orderRouter = require ('../orders/orderRoute')

router.all('/user*', userRouter)
router.all('/order*', orderRouter)

module.exports = router;
