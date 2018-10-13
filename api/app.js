var   express       = require('express');
var   path          = require('path');
var   cookieParser  = require('cookie-parser');
var   logger        = require('morgan');
var   apiRouter     = require('./routes/index');
var   auth          = require('./auth')();
var   app           = express();
var   cors          = require('cors')

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

// Enable cross origin requests 
// This allows Vue to make requests to the server
app.use(cors())

app.use(auth.initialize());

app.use('/api', apiRouter);

module.exports = app;
