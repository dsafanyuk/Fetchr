const knex = require('knex')(require('../db'));
const {fixDateTime} = require('./courierHelper')
const moment = require('moment');

// GET /courier/:user_id/order
function availableOrders(req, res) {
  knex('orders').innerJoin('users', 'orders.customer_id', 'users.user_id')
    .select(
      'user_id',
      'order_id',
      'first_name',
      'room_num',
      'delivery_status',
      'orders.time_created',
      'order_total',
    )
    .whereNull('courier_id')
    .whereNot('customer_id', req.params.user_id)
    .then((orders) => {
      orders.forEach(order => {
        order.time_created = fixDateTime(order.time_created)
      });
      res.send(orders);
    })
    .catch((err) => {
      res.status(500).json({
        message: `${err}`,
      }); // FOR DEBUGGING ONLY, dont send exact message in prod
      console.log(err);
    });
}

// GET /courier/:user_id/order/accepted
function acceptedOrders(req, res) {
  knex('orders').innerJoin('users', 'orders.customer_id', 'users.user_id')
    .select(
      'user_id',
      'order_id',
      'first_name',
      'room_num',
      'delivery_status',
      'orders.time_created',
    )
    .where({
      'courier_id': req.params.user_id,
      'delivery_status': 'in-progress'
    })
    .then((orders) => {
      orders.forEach(order => {
        order.time_created = fixDateTime(order.time_created)
      });
      res.send(orders);
    })
    .catch((err) => {
      res.status(500).json({
        message: `${err}`,
      }); // FOR DEBUGGING ONLY, dont send exact message in prod
      console.log(err);
    });
}

// GET /courier/:user_id/order/delivered
function deliveredOrders(req, res) {
  knex('orders').innerJoin('users', 'orders.customer_id', 'users.user_id')
    .select(
      'user_id',
      'order_id',
      'first_name',
      'room_num',
      'delivery_status',
      'orders.time_delivered',
    )
    .where({
       'courier_id': req.params.user_id,
       'delivery_status': 'delivered'
    })
    .then((orders) => {
      orders.forEach(order => {
        order.time_delivered = fixDateTime(order.time_delivered)
      });
      res.send(orders);
    })
    .catch((err) => {
      res.status(500).json({
        message: `${err}`,
      }); // FOR DEBUGGING ONLY, dont send exact message in prod
      console.log(err);
    });
}

// Get total available Orders
function countAvailableOrder(req, res ){
 knex.raw ('SELECT COUNT(*) as count_av FROM orders WHERE courier_id is null')
.then((orders) => {
    res.send(orders);
})
}
// Get delivered Orders
function countDelivered(req, res ){

  knex.raw ('SELECT COUNT(*) as count_d FROM orders WHERE courier_id = '+ req.params.user_id +
           ' AND delivery_status = \'pending\' ')
.then((count_d) => {
     res.send(count_d);
 })
}
function getRevenue(req, res ){
  knex.raw ('SELECT SUM(order_total) as revenue FROM orders WHERE courier_id = '+ req.params.user_id)
.then((revenue) => {
     res.send(revenue);
 })
}
// POST /accept
function acceptOrder(req, res) {
  knex('orders')
    .whereNull('courier_id')
    .andWhere('order_id', req.body.order_id)
    .update({
      delivery_status: 'in-progress',
      courier_id: req.body.courier_id,
    })
    .then((rows) => {
      if (rows) {
        res.send("success");
      }
      else {
        res.send("fail");
      }
    })
    .catch((err) => {
      res.status(500).json({
        message: `${err}`,
      }); // FOR DEBUGGING ONLY, dont send exact message in prod
      console.log(err);
    });
}

// POST /deliver
function deliverOrder(req, res) {
  knex('orders')
    .where('order_id', req.body.order_id)
    .update({
      delivery_status: 'delivered',
      courier_id: req.body.courier_id,
      time_delivered: moment(new Date()).format("YYYY-MM-DD HH:mm:ss")
    })
    .then((rows) => {
      res.status(200).send('success');
    })
    .catch((err) => {
      res.status(500).json({
        message: `${err}`,
      }); // FOR DEBUGGING ONLY, dont send exact message in prod
      console.log(err);
    });
}

function courierInfo(req, res) {
    knex.raw(
    `select count(*) as delivered, cid.first_name, cid.last_name, cid.phone_number
       from (select courier_id, first_name, last_name, phone_number
               from orders
              inner join users on orders.courier_id = users.user_id
              where order_id = ${req.params.order_id}) cid
      inner join orders on orders.courier_id = cid.courier_id
      where orders.delivery_status = 'delivered'
      group by cid.courier_id, cid.first_name, cid.last_name, cid.phone_number`
    )
    .then((courierInfo) => {
      res.send(courierInfo);
    })
}
module.exports = {
  availableOrders,
  acceptedOrders,
  deliveredOrders,
  acceptOrder,
  deliverOrder,
  countAvailableOrder,
  countDelivered,
  getRevenue,
  courierInfo,
};
