const jwt = require('jsonwebtoken');

function verifyToken(req, res, next) {
    // Get jwt in cookies
    const jwtCookie = req.header('token');
    // Get used id from browser cookies
    const user_id = req.header('user_id');
  

    // Check if there is cookie
    if (typeof jwtCookie === 'string') {
      // Verifies secret
      jwt.verify(jwtCookie, 'secretkey', (err, decoded) => {
        if (!err) {
          // if everything is good, save to request for use in other routes
          req.token = decoded;

          if(req.token.user.user_id == user_id) {
            console.log("authorized");
            next();
          }
          else {
            return res.status(403).json({ success: false, message: 'Not authorized'});
          }
        } else {
          return res.status(403).json({ success: false, message: "Can't verify token" });
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
  module.exports = verifyToken;
