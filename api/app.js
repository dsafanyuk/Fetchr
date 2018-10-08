var   express       = require('express');
var   path          = require('path');
var   cookieParser  = require('cookie-parser');
var   bodyParser    = require('body-parser')
var   logger        = require('morgan');
var   dbOptions     = require('./db')
const knex = require('knex')(dbOptions);
var   passport      = require('passport');
var   LocalStrategy = require('passport-local').Strategy;
var   session       = require('express-session')
var   apiRouter     = require('./routes/index');
var   app           = express();

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

// Express Session
/*app.use(session({
    secret: 'secret',
    saveUninitialized: true,
    resave: true
}))*/

app.use(passport.initialize());
app.use(passport.session());

app.use('*', (req,res,next)=>{
    console.log('middle ware 1')
    next();
})

app.use('*', (req,res,next)=>{
    console.log('middle ware 2')
    next();
})

app.use('*', (req,res,next)=>{
    console.log('middle ware 3')
    next();
})

app.use('/api', apiRouter);

module.exports = app;
