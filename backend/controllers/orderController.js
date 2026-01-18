const Order = require('../models/Order');
const Cart = require('../models/Cart');

exports.placeOrder = async (req, res) => {
  try {
    const { deliveryAddress, paymentMethod, notes } = req.body;

    const cart = await Cart.findOne({ userId: req.userId });
    if (!cart || cart.items.length === 0) {
      return res.status(400).json({ message: 'Cart is empty' });
    }

    const orderId = `ORDER-${Date.now()}`;
    const order = new Order({
      userId: req.userId,
      orderId,
      items: cart.items,
      deliveryAddress,
      paymentMethod,
      subtotal: cart.subtotal,
      deliveryFee: cart.deliveryFee,
      discount: cart.discount,
      total: cart.total,
      notes,
      estimatedDeliveryTime: new Date(Date.now() + 45 * 60000),
      status: 'pending',
      paymentStatus: paymentMethod === 'cod' ? 'pending' : 'completed',
    });

    await order.save();

    cart.items = [];
    cart.subtotal = 0;
    cart.total = 0;
    cart.discount = 0;
    cart.promoCode = null;
    await cart.save();

    res.status(201).json({
      message: 'Order placed successfully',
      order: {
        id: order._id,
        orderId: order.orderId,
        status: order.status,
        total: order.total,
        estimatedDeliveryTime: order.estimatedDeliveryTime,
      },
    });
  } catch (error) {
    res.status(500).json({ message: 'Server error', error: error.message });
  }
};

exports.getOrderHistory = async (req, res) => {
  try {
    const orders = await Order.find({ userId: req.userId })
      .sort({ createdAt: -1 });

    res.json({
      orders: orders.map((order) => ({
        id: order._id,
        orderId: order.orderId,
        status: order.status,
        total: order.total,
        createdAt: order.createdAt,
        estimatedDeliveryTime: order.estimatedDeliveryTime,
      })),
      count: orders.length,
    });
  } catch (error) {
    res.status(500).json({ message: 'Server error', error: error.message });
  }
};

exports.getOrder = async (req, res) => {
  try {
    const order = await Order.findById(req.params.id);

    if (!order) {
      return res.status(404).json({ message: 'Order not found' });
    }

    if (order.userId.toString() !== req.userId) {
      return res.status(403).json({ message: 'Not authorized' });
    }

    res.json({ order });
  } catch (error) {
    res.status(500).json({ message: 'Server error', error: error.message });
  }
};

exports.updateOrderStatus = async (req, res) => {
  try {
    const { status } = req.body;

    const validStatuses = ['pending', 'confirmed', 'preparing', 'out-for-delivery', 'delivered', 'cancelled'];
    if (!validStatuses.includes(status)) {
      return res.status(400).json({ message: 'Invalid status' });
    }

    const order = await Order.findByIdAndUpdate(
      req.params.id,
      { status, updatedAt: Date.now() },
      { new: true }
    );

    if (!order) {
      return res.status(404).json({ message: 'Order not found' });
    }

    res.json({
      message: 'Order status updated',
      order,
    });
  } catch (error) {
    res.status(500).json({ message: 'Server error', error: error.message });
  }
};
