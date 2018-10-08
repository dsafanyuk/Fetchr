var express = require('express');
var router = express.Router({mergeParams: true}) // don't forget the parent params!
var   passport      = require('passport');
var   LocalStrategy = require('passport-local').Strategy;

userController = require('./userController')

router.post('/register', userController.registerUser)

router.post('/login', passport.authenticate('local', {successRedirect: '/', failureRedirect:'/login', failureFlash: true}), userController.loginUser)

router.get('/', userController.showAllUsers)

router.get('/:user_id/',userController.showOneUser)

router.get('/:user_id/orders', userController.showUserOrders)

router.patch('/:user_id', userController.updateUser)

router.post('/', userController.createUser)

router.delete('/:user_id', userController.deleteUser)

module.exports = router;
