var express = require('express');
var router = express.Router();

userController = require('./userController')

router.get('/user/', userController.showAllUsers)
router.get('/user/:user_id', userController.showOneUser)
router.patch('/user/:user_id', userController.updateUser)
router.post('/user', userController.createUser)
router.delete('/user/:user_id', userController.deleteUser)

module.exports = router;
