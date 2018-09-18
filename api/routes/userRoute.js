var express = require('express');
var router = express.Router();

userController = require('../controllers/users/userController')

router.get('/user', userController.showAllUsers)
router.get('/user/:id', userController.showOneUser)
router.patch('/user/:id', userController.updateUser)
router.post('/user', userController.createUser)
router.delete('/user/:id', userController.deleteUser)

module.exports = router;
