const express = require('express');

const router = express.Router();
const adminController = require('./adminController');
const verifyAdmin = require('./verifyAdmin')

router.get('/products', adminController.showAllProducts);
router.post('/products', adminController.addProduct);
router.put('/product/:product_id', adminController.editProduct);

router.get('/users', adminController.showAllUsers);
router.post('/users', adminController.addUser);
router.put('/user/:user_id', adminController.editUser);

router.get('/total/orders', adminController.totalOrders);
router.get('/total/delivered', adminController.totalDelivered);
router.get('/total/users', adminController.totalUsers);
router.get('/total/amountOrdered', adminController.totalAmountOrdered);

router.get('/orders/recent', adminController.recentOrders);

router.get('/couriers/topThree', adminController.topThreeCouriers);

router.get('/graphs/ordersPerDay', adminController.ordersPerDay);
router.get('/graphs/productsPerDay', adminController.productsPerDay);
router.get('/graphs/prodsSoldByCat', adminController.prodsSoldByCat);
router.get('/verify', verifyAdmin.isAdmin);

module.exports = router;
