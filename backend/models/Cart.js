const mongoose = require('mongoose');

const cartSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true,
    unique: true,
  },
  items: [{
    foodId: {
      type: String,
      required: true,
    },
    foodName: String,
    foodPrice: Number,
    quantity: {
      type: Number,
      required: true,
      min: 1,
    },
    selectedOptions: {
      spiceLevel: {
        type: String,
        enum: ['mild', 'medium', 'hot', 'very-hot'],
        default: 'medium',
      },
      specialInstructions: String,
    },
    totalPrice: {
      type: Number,
      default: 0,
    },
    addedAt: {
      type: Date,
      default: Date.now,
    },
  }],
  subtotal: {
    type: Number,
    default: 0,
  },
  deliveryFee: {
    type: Number,
    default: 200,
  },
  discount: {
    type: Number,
    default: 0,
  },
  promoCode: String,
  total: {
    type: Number,
    default: 0,
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
  updatedAt: {
    type: Date,
    default: Date.now,
  },
});

cartSchema.pre('save', function(next) {
  this.subtotal = this.items.reduce((sum, item) => {
    item.totalPrice = item.foodPrice * item.quantity;
    return sum + item.totalPrice;
  }, 0);

  this.total = this.subtotal + this.deliveryFee - this.discount;
  this.updatedAt = Date.now();
  next();
});

module.exports = mongoose.model('Cart', cartSchema);
