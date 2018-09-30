var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var dbOptions = require('./db')
const knex = require('knex')(dbOptions);
var apiRouter = require('./routes/index');
var app = express();
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

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
