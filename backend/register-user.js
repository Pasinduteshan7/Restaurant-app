require('dotenv').config();
const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const User = require('./models/User');

async function registerTestUser() {
  try {
    await mongoose.connect(process.env.MONGO_URI);
    console.log('✅ MongoDB connected');

    const existingUser = await User.findOne({ email: 'user@example.com' });
    if (existingUser) {
      console.log('User already exists:', existingUser.email);
      process.exit(0);
    }

    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash('password', salt);

    const user = new User({
      name: 'Test User',
      email: 'user@example.com',
      password: hashedPassword,
      phone: '+94 77 000 0000',
    });

    await user.save();
    console.log('✅ Test user created successfully!');
    console.log('Email: user@example.com');
    console.log('Password: password');

    process.exit(0);
  } catch (error) {
    console.error('❌ Error:', error.message);
    process.exit(1);
  }
}

registerTestUser();
