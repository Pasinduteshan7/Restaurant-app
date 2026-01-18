const express = require('express');
const cartController = require('../controllers/cartController');
const auth = require('../middleware/auth');

const router = express.Router();

router.get('/', auth, cartController.getCart);
router.post('/add', auth, cartController.addToCart);
router.put('/:itemId', auth, cartController.updateCartItem);
router.delete('/:itemId', auth, cartController.removeFromCart);
router.delete('/', auth, cartController.clearCart);
router.post('/promo', auth, cartController.applyPromoCode);

module.exports = router;
