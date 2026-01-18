const express = require('express');
const orderController = require('../controllers/orderController');
const auth = require('../middleware/auth');

const router = express.Router();

router.post('/place', auth, orderController.placeOrder);
router.get('/history', auth, orderController.getOrderHistory);
router.get('/:id', auth, orderController.getOrder);
router.put('/:id/status', orderController.updateOrderStatus);

module.exports = router;
