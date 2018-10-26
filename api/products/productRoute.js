var express = require("express");
var router = express.Router();
productController = require("./productController");

router.use("*", (req, res, next) => {
  if (req.query.sort) {
    req.sortParams = sortBy(req.query.sort)
  }
  next()
})
router.get("/filter/:category", productController.showItemByCategory)
router.get("/:product_id", productController.showOneProduct);
router.get("/", productController.showAllProducts);

module.exports = router;

/*------------------------ Helper Functions ---------------------------*/
function sortBy(sortQuery) {
  const sortParams = {
    option: '',
    orderBy: ''
  }
  // TODO VALIDATE INCOMING QUERIES
  Object.keys(sortQuery).forEach((option) => {
    sortParams.option = option
    sortParams.orderBy = sortQuery[option]
  })
  return sortParams
}
