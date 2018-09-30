var express = require('express');
var router = express.Router();
var userRouter = require ('../users/userRoute')
var orderRouter = require ('../orders/orderRoute')

router.use('/user', userRouter)
router.use('/order', orderRouter)

module.exports = router;
