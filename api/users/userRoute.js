const express = require('express');
const { check } = require('express-validator/check');
const jwt = require('jsonwebtoken');
const userController = require('./userController');
const registerController = require('./registerController');
const loginController = require('./loginController');
const verifyToken = require('../routes/verifyToken');

const router = express.Router({
  mergeParams: true,
}); // don't forget the parent params!

router.post('/register', [
  check('email_address', 'Not an email address').isEmail().trim(),
  check('password', 'Password must have at least one lowercase, one uppercase, a number,  and a minimum of 8 characters')
    .matches(/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,20}$/, 'i').trim(),
  check('phone', 'Only digits').isMobilePhone().trim(),
  check('room_num', 'Please enter 4 digits, no more no less').isLength({
    min: 4,
    max: 4,
  }).isNumeric().trim(),
  check('first_name', 'Cannot have numbers').isAlpha().trim(),
  check('last_name', 'Cannot have numbers').isAlpha().trim(),
], registerController.registerUser);

router.post('/:user_id/wallet', verifyToken, userController.addBalance);

router.get('/:user_id/wallet', verifyToken, userController.checkBalance);

router.post('/favorite', verifyToken, userController.favorite);

router.post('/unfavorite', verifyToken, userController.unfavorite);

router.get('/:user_id/favorites', verifyToken, userController.favorites);

router.get('/:user_id/creditCheck',  verifyToken, userController.creditCheck);

router.post('/login', loginController.loginUser);

router.get('/:user_id/',  verifyToken, userController.showOneUser); // eslint-disable-line no-use-before-define

router.get('/:user_id/orders',  verifyToken, userController.showUserOrders);

router.patch('/:user_id',  verifyToken, userController.updateUser);

router.post('/',  verifyToken, userController.createUser);

module.exports = router;
