const express = require('express');
const { check } = require('express-validator/check');
const jwt = require('jsonwebtoken');
const userController = require('./userController');
const registerController = require('./registerController');
const loginController = require('./loginController');

const router = express.Router({ mergeParams: true }); // don't forget the parent params!

router.post('/register', [
  check('email_address', 'Not an email address').isEmail().trim(),
  check('password', 'Password must have at least one lowercase, one uppercase, a number,  and a minimum of 8 characters')
    .matches(/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,20}$/, 'i').trim(),
  check('phone', 'Only digits').isMobilePhone().trim(),
  check('room_num', 'Please enter 4 digits, no more no less').isLength({ min: 4, max: 4 }).isNumeric().trim(),
  check('first_name', 'Cannot have numbers').isAlpha().trim(),
  check('last_name', 'Cannot have numbers').isAlpha().trim(),
], registerController.registerUser);

router.post('/login', loginController.loginUser);

router.get('/login', userController.showLogin);

router.get('/', userController.showAllUsers);

router.get('/:user_id/', verifyToken, userController.showOneUser); // eslint-disable-line no-use-before-define

router.get('/:user_id/orders', userController.showUserOrders);

router.patch('/:user_id', userController.updateUser);

router.post('/', userController.createUser);

router.delete('/:user_id', userController.deleteUser);


// IMPORTANT, FORMAT OF TOKEN
// Authorization: Bearer <access_token>

// Verify token
function verifyToken(req, res, next) {
  // Get auth header value
  const bearerHeader = req.headers.authorization;

  // Check if bearer is undefined
  if (typeof bearerHeader !== 'undefined') {
    // Split at space
    const bearer = bearerHeader.split(' ');
    // Get token from array
    const bearerToken = bearer[1];

    // Verifies secret
    jwt.verify(bearerToken, 'secretkey', (err, decoded) => {
      if (!err) {
        // if everything is good, save to request for use in other routes
        req.token = decoded;
        next();
      } else {
        return res.json({ success: false, message: 'Failed to authenticate token.' });
      }

      return 0;
    });
  } else {
    // If there is no token, return an error
    return res.status(403).send({
      success: false,
      message: 'No token provided.',
    });
  }

  return 0;
}

module.exports = router;
