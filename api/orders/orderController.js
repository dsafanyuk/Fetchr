const knex = require('knex')(require('../db'));

// GET /order
function showAllOrders(req, res) {
  knex('orders').select('*')
    .then((rows) => {
      res.send(rows).status(200);
    })
    .catch((err) => {
      res.status(500).send({
        message: `${err}`,
      }); // FOR DEBUGGING ONLY, dont send exact message in prod
    });
}

// GET /order/{id}
function showOneOrder(req, res) {
  knex('orders').where('orderId', req.params.orderId)
    .then((rows) => {
      res.send(rows).status(200);
    })
    .catch((err) => {
      res.status(500).send({
        message: `${err}`,
      }); // FOR DEBUGGING ONLY, dont send exact message in prod
    });
}

// POST /orders
function createOrder(req, res) {
  const request = req.body;
  knex('orders').insert(request)
    // if order successfully inserted
    .then((orderId) => {
      // Select the order that was just created
      knex('orders').select('*').where('order_id', orderId)
        .then((rows) => {
          res.status(201).send(`Order created for id ${rows[0].orderId}`);
        });
    })
    // else send err
    .catch((err) => {
      res.status(500).send({
        message: `${err}`,
      }); // FOR DEBUGGING ONLY, dont send exact message in prod
    });
}

// UPDATE /orders{id}
function updateOrder(req, res) {
  const order = req.body;
  knex('orders').where('orderId', req.params.orderId)
    .update({
      customer_id: order.customer_id,
      courier_id: order.courier_id,
      delivery_status: order.delivery_status,
      time_delivered: order.time_delivered,
    })
    .then(() => {
      res.send('success').status(200);
    })

    .catch((err) => {
      res.status(500).send({
        message: `${err}`,
      }); // FOR DEBUGGING ONLY, dont send exact message in prod
    });
}

// GET /orders/{id}/summary
function showOneOrderSummary(req, res) {
  // Retrieve order summary
  knex('orders')
    .innerJoin('order_summary', 'orders.orderId', 'order_summary.orderId')
    .innerJoin('products', 'order_summary.product_id', 'products.product_id')
    .where('orders.orderId', req.params.orderId)
    .select('product_name', 'quantity', 'price', 'product_url')
    .then((productList) => {
      productList.forEach((product) => {
        product.price *= product.quantity; // eslint-disable-line no-param-reassign
      });
      res.send(productList).status(200);
    })
    .catch((err) => {
      res.status(500).send({
        message: `${err}`,
      }); // FOR DEBUGGING ONLY, dont send exact message in prod
    });
}

module.exports = {
  showAllOrders,
  showOneOrder,
  createOrder,
  updateOrder,
  showOneOrderSummary,
};
