const mongoose = require('mongoose');

const foodSchema = new mongoose.Schema({
  id: String,
  name: {
    type: String,
    required: true,
  },
  price: {
    type: Number,
    required: true,
  },
  description: String,
  imageUrl: String,
  category: {
    type: String,
    required: true,
  },
  rating: {
    type: Number,
    default: 4.5,
  },
  dietaryTags: [String],
  ingredients: [String],
  available: {
    type: Boolean,
    default: true,
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

module.exports = mongoose.model('Food', foodSchema);
