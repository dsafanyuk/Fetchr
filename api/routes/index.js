var express = require('express');
var router = express.Router();
var userRouter = require ('./userRoute')
var orderRouter = require ('./orderRoute')

router.all('/user*', userRouter)
router.all('/order*', orderRouter)

module.exports = router;
