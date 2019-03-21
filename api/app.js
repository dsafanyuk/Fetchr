const express = require('express');
const path = require('path');
const cookieParser = require('cookie-parser');
const logger = require('morgan');
const cors = require('cors');
const Sentry = require('@sentry/node');
const apiRouter = require('./routes/index');

if (process.env.NODE_ENV === 'production') {
  Sentry.init({ dsn: 'https://a793d841eb444a7491f3bb6543e3957f@sentry.io/1411944' });
}

const whitelist = ['http://127.0.0.1:8080', 'https://fetchrapp.com', 'https://www.fetchrapp.com'];
const corsOptions = {
  origin(origin, callback) {
    if (whitelist.indexOf(origin) !== -1 || !origin) {
      callback(null, true);
    } else {
      callback(new Error('Not allowed by CORS'));
    }
  },
  credentials: true,
};

const app = express();
app.use(Sentry.Handlers.requestHandler());

app.use(logger('dev'));
app.use(express.json());
app.use(
  express.urlencoded({
    extended: false,
  }),
);
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use(cors(corsOptions));

app.use('/api', apiRouter);

app.get('*', (req, res, next) => {
  const err = new Error('Page Not Found');
  err.statusCode = 404;
  next(err);
});
module.exports = app;
