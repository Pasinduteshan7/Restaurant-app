require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const authRoutes = require('./routes/auth');
const cartRoutes = require('./routes/cart');
const foodRoutes = require('./routes/food');
const orderRoutes = require('./routes/order');

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cors());

mongoose
  .connect(process.env.MONGO_URI)
  .then(() => {
    console.log('✅ MongoDB connected successfully!');
    console.log(`📍 Database: lustradb`);
  })
  .catch((err) => {
    console.error('❌ MongoDB connection failed:', err.message);
    process.exit(1);
  });

app.use('/api/auth', authRoutes);
app.use('/api/cart', cartRoutes);
app.use('/api/foods', foodRoutes);
app.use('/api/orders', orderRoutes);

app.get('/api/health', (req, res) => {
  res.json({
    status: 'OK',
    message: 'CurryFlow Backend is running',
    timestamp: new Date().toISOString(),
  });
});

app.use((req, res) => {
  res.status(404).json({ message: 'Route not found' });
});

app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({
    message: 'Server error',
    error: process.env.NODE_ENV === 'development' ? err.message : 'Internal server error',
  });
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`🚀 Server running on http://localhost:${PORT}`);
  console.log(`📦 Environment: ${process.env.NODE_ENV}`);
  console.log(`\n✨ Available Endpoints:`);
  console.log(`  POST   /api/auth/register`);
  console.log(`  POST   /api/auth/login`);
  console.log(`  GET    /api/auth/profile`);
  console.log(`  POST   /api/auth/address`);
  console.log(`\n  GET    /api/foods`);
  console.log(`  GET    /api/foods/:id`);
  console.log(`  GET    /api/foods/categories`);
  console.log(`  GET    /api/foods/search?q=query`);
  console.log(`\n  GET    /api/cart`);
  console.log(`  POST   /api/cart/add`);
  console.log(`  PUT    /api/cart/:itemId`);
  console.log(`  DELETE /api/cart/:itemId`);
  console.log(`  POST   /api/cart/promo`);
  console.log(`\n  POST   /api/orders/place`);
  console.log(`  GET    /api/orders/history`);
  console.log(`  GET    /api/orders/:id`);
  console.log(`\n  GET    /api/health`);
});

module.exports = app;
