var   express       = require('express');
var   path          = require('path');
var   cookieParser  = require('cookie-parser');
var   logger        = require('morgan');
var   apiRouter     = require('./routes/index');
var   app           = express();
var   cors          = require('cors')

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({
    extended: false
}));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use(cors())

app.use('/api', apiRouter);

app.get('*', function (req, res, next) {
    let err = new Error('Page Not Found');
    err.statusCode = 404;
    next(err);
});
module.exports = app;
