const knex = require('knex')(require('../db'));

// GET /order
function showAllOrders(req, res) {
  knex('orders')
    .select('*')
    .then((rows) => {
      res.send(rows).status(200);
    })
    .catch((err) => {
      res.status(500).send({
        message: `${err}`,
      }); // FOR DEBUGGING ONLY, dont send exact message in prod
    });
}

// GET /order/{order_id}
function showOneOrder(req, res) {
  knex('orders')
    .where('order_id', req.params.order_id)
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

  let order = {
    customer_id: request.customer_id,
    delivery_status: request.delivery_status,
    order_total: request.order_total,
  };

  let productsWithQuantity = request.productsWithQuantity;

  knex('orders')
    .insert(order)
    // if order successfully inserted
    .then((order_id) => {
      //add the new order_id to the json
      let orderProducts = productsWithQuantity.map((product) => {
        product.order_id = order_id[0];
        return product;
      });
      return orderProducts;
    })
    .then((orderProducts) => {
      //insert the products to the summary
      knex('order_summary')
        .insert(orderProducts)
        .then(() => {})
        .catch((err) => {
          res.status(500).send({
            message: `${err}`,
          });
        });
       return orderProducts[0].order_id;
    })
    .then((orderProducts) => {
      let order = orderProducts
      //if successful send back order id
      knex('users')
        .where('user_id', request.customer_id)
        .decrement(
          'wallet', request.order_total)
        .then(() => {
          console.log(order)
          res.send({ status: 'success', message: orderProducts }).status(200);
        })
        .catch((err) => {
          console.log(err)

          res.status(500).send({
            message: `${err}`
          })
        })
    })
    // else send err
    .catch((err) => {
      console.log(err)
      res.status(500).send({
        message: `${err}`,
      }); // FOR DEBUGGING ONLY, dont send exact message in prod
    });
}

// UPDATE /orders{id}
function updateOrder(req, res) {
  const order = req.body;
  knex('orders')
    .where('order_id', req.params.order_id)
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

// GET /orders/{order_id}/summary
function showOneOrderSummary(req, res) {
  // Retrieve order summary
  knex('orders')
    .innerJoin('order_summary', 'orders.order_id', 'order_summary.order_id')
    .innerJoin('products', 'order_summary.product_id', 'products.product_id')
    .where('orders.order_id', req.params.order_id)
    .select('product_name', 'quantity', 'price', 'product_url')
    .then((productList) => {
      productList.forEach((product) => {
        product.price *= product.quantity; // eslint-disable-line no-param-reassign
      });
      knex('orders')
        .where('orders.order_id', req.params.order_id)
        .select('delivery_status')
        .then((delivery_status) => {
          res.send({productList, delivery_status}).status(200)
        })
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
