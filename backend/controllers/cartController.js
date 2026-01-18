const Cart = require('../models/Cart');
const Food = require('../models/Food');

exports.getCart = async (req, res) => {
  try {
    let cart = await Cart.findOne({ userId: req.userId }).populate('items.foodId');

    if (!cart) {
      cart = new Cart({ userId: req.userId, items: [] });
      await cart.save();
    }

    res.json({
      cart: {
        id: cart._id,
        items: cart.items,
        subtotal: cart.subtotal,
        deliveryFee: cart.deliveryFee,
        discount: cart.discount,
        promoCode: cart.promoCode,
        total: cart.total,
      },
    });
  } catch (error) {
    res.status(500).json({ message: 'Server error', error: error.message });
  }
};

exports.addToCart = async (req, res) => {
  try {
    const { foodId, foodName, foodPrice, quantity, selectedOptions } = req.body;

    let cartFood = {
      foodId,
      foodName: foodName || 'Unknown Food',
      foodPrice: foodPrice || 0,
    };

    if (!foodName || !foodPrice) {
      try {
        const food = await Food.findById(foodId);
        if (food) {
          cartFood.foodName = food.name;
          cartFood.foodPrice = food.price;
        }
      } catch (e) {
        console.log('Could not fetch from DB, using provided values');
      }
    }

    let cart = await Cart.findOne({ userId: req.userId });
    if (!cart) {
      cart = new Cart({ userId: req.userId, items: [] });
    }

    const existingItem = cart.items.find(
      (item) => item.foodId.toString() === foodId
    );

    if (existingItem) {
      existingItem.quantity += quantity;
      existingItem.totalPrice = existingItem.foodPrice * existingItem.quantity;
    } else {
      cart.items.push({
        foodId,
        foodName: cartFood.foodName,
        foodPrice: cartFood.foodPrice,
        quantity,
        selectedOptions: selectedOptions || {},
        totalPrice: cartFood.foodPrice * quantity,
      });
    }

    await cart.save();

    res.json({
      message: 'Item added to cart',
      cart: {
        id: cart._id,
        items: cart.items,
        subtotal: cart.subtotal,
        deliveryFee: cart.deliveryFee,
        total: cart.total,
      },
    });
  } catch (error) {
    res.status(500).json({ message: 'Server error', error: error.message });
  }
};

exports.updateCartItem = async (req, res) => {
  try {
    const { itemId } = req.params;
    const { quantity } = req.body;

    if (quantity < 1) {
      return res.status(400).json({ message: 'Quantity must be at least 1' });
    }

    const cart = await Cart.findOne({ userId: req.userId });
    if (!cart) {
      return res.status(404).json({ message: 'Cart not found' });
    }

    const cartItem = cart.items.id(itemId);
    if (!cartItem) {
      return res.status(404).json({ message: 'Item not found in cart' });
    }

    cartItem.quantity = quantity;
    cartItem.totalPrice = cartItem.foodPrice * quantity;

    await cart.save();

    res.json({
      message: 'Cart updated',
      cart: {
        id: cart._id,
        items: cart.items,
        subtotal: cart.subtotal,
        total: cart.total,
      },
    });
  } catch (error) {
    res.status(500).json({ message: 'Server error', error: error.message });
  }
};

exports.removeFromCart = async (req, res) => {
  try {
    const { itemId } = req.params;

    const cart = await Cart.findOne({ userId: req.userId });
    if (!cart) {
      return res.status(404).json({ message: 'Cart not found' });
    }

    cart.items.id(itemId).remove();
    await cart.save();

    res.json({
      message: 'Item removed from cart',
      cart: {
        id: cart._id,
        items: cart.items,
        subtotal: cart.subtotal,
        total: cart.total,
      },
    });
  } catch (error) {
    res.status(500).json({ message: 'Server error', error: error.message });
  }
};

exports.clearCart = async (req, res) => {
  try {
    const cart = await Cart.findOne({ userId: req.userId });
    if (!cart) {
      return res.status(404).json({ message: 'Cart not found' });
    }

    cart.items = [];
    cart.subtotal = 0;
    cart.total = 0;
    cart.discount = 0;
    cart.promoCode = null;

    await cart.save();

    res.json({ message: 'Cart cleared' });
  } catch (error) {
    res.status(500).json({ message: 'Server error', error: error.message });
  }
};

exports.applyPromoCode = async (req, res) => {
  try {
    const { promoCode } = req.body;

    const cart = await Cart.findOne({ userId: req.userId });
    if (!cart) {
      return res.status(404).json({ message: 'Cart not found' });
    }

    let discount = 0;
    const validCodes = {
      'SAVE10': 0.10,
      'SAVE20': 0.20,
      'FREE': 200,
    };

    if (validCodes[promoCode]) {
      const discountValue = validCodes[promoCode];
      
      if (promoCode === 'FREE') {
        discount = 200;
        cart.deliveryFee = 0;
      } else {
        discount = Math.floor(cart.subtotal * discountValue);
      }
      
      cart.promoCode = promoCode;
      cart.discount = discount;
    } else {
      return res.status(400).json({ message: 'Invalid promo code' });
    }

    await cart.save();

    res.json({
      message: 'Promo code applied',
      cart: {
        id: cart._id,
        items: cart.items,
        subtotal: cart.subtotal,
        deliveryFee: cart.deliveryFee,
        discount: cart.discount,
        promoCode: cart.promoCode,
        total: cart.total,
      },
    });
  } catch (error) {
    res.status(500).json({ message: 'Server error', error: error.message });
  }
};
