var express = require('express');
var router = express.Router({mergeParams: true}) // don't forget the parent params!
var   passport      = require('passport');
var   LocalStrategy = require('passport-local').Strategy;
const { check } = require('express-validator/check');

userController = require('./userController')

router.post('/register', [
    check('email_address', 'Not an email address').isEmail().trim(),
    check('password', 'Password must have a minimum of 8 characters').isLength({min: 10}).trim(),
    check('confirm_password').custom((value, {req}) => {
        if(value !== req.body.password) {
            throw new Error('Password confirmation must match the password')
        }
        else{
            return true;
        }
    }).isLength({min: 10}).trim(),
    check('room_num', 'Please enter 4 digits, no more no less').isLength({min: 4, max: 4}).isNumeric().trim(),
    check('first_name', 'Cannot have numbers').isAlpha().trim(),
    check('last_name', 'Cannot have numbers').isAlpha().trim()
], userController.registerUser)

router.post('/login', passport.authenticate('local', {successRedirect: '/', failureRedirect:'/login', failureFlash: true}), userController.loginUser)

router.get('/', userController.showAllUsers)

router.get('/:user_id/',userController.showOneUser)

router.get('/:user_id/orders', userController.showUserOrders)

router.patch('/:user_id', userController.updateUser)

router.post('/', userController.createUser)

router.delete('/:user_id', userController.deleteUser)

module.exports = router;
