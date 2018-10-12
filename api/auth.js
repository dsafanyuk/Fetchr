var passport = require("passport");  
var passportJWT = require("passport-jwt"); 
var cfg = require("./JWTconfig");
var ExtractJWT = passportJWT.ExtractJwt;
var Strategy = passportJWT.Strategy;
var dbOptions = require("./db");
const knex = require("knex")(dbOptions);  
var params = {  
    secretOrKey: cfg.jwtSecret,
    jwtFromRequest: ExtractJWT.fromAuthHeaderAsBearerToken()
};

module.exports = function() {  
    var strategy = new Strategy(params, function(payload, done) {
        var user = knex('users').select('*')[payload.id] || null;
        console.log("new Strategy callback fuction");
        if (user) {
            return done(null, {
                id: user.user_id
            });
        } else {
            return done(new Error("User not found"), null);
        }
    });
    passport.use(strategy);
    return {
        initialize: function() {
            return passport.initialize();
        },
        authenticate: function() {
            return passport.authenticate("jwt", cfg.jwtSession);
        }
    };
};