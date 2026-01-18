require('dotenv').config();
const mongoose = require('mongoose');
const Food = require('./models/Food');

const sriLankanFoods = [
  {
    name: 'Chicken Curry',
    price: 450,
    description: 'Authentic Sri Lankan chicken curry with roasted spices',
    category: 'Rice & Curry',
    rating: 4.7,
    dietaryTags: ['Non-Vegetarian', 'Gluten-Free'],
    ingredients: ['Chicken', 'Coconut Milk', 'Spices', 'Curry Leaves'],
    imageUrl: 'https://via.placeholder.com/400x300?text=Chicken+Curry',
  },
  {
    name: 'Fish Ambul Thiyal',
    price: 520,
    description: 'Sour and spicy fish curry with tamarind and chili',
    category: 'Rice & Curry',
    rating: 4.6,
    dietaryTags: ['Non-Vegetarian', 'Gluten-Free'],
    ingredients: ['Fish', 'Tamarind', 'Chili', 'Curry Leaves'],
    imageUrl: 'https://via.placeholder.com/400x300?text=Fish+Ambul+Thiyal',
  },
  {
    name: 'Kottu Chicken',
    price: 380,
    description: 'Shredded roti with spicy chicken and vegetables',
    category: 'Kottu',
    rating: 4.8,
    dietaryTags: ['Non-Vegetarian'],
    ingredients: ['Roti', 'Chicken', 'Vegetables', 'Spices'],
    imageUrl: 'https://via.placeholder.com/400x300?text=Kottu+Chicken',
  },
  {
    name: 'Kottu Cheese',
    price: 350,
    description: 'Shredded roti with melted cheese and vegetables',
    category: 'Kottu',
    rating: 4.5,
    dietaryTags: ['Vegetarian'],
    ingredients: ['Roti', 'Cheese', 'Vegetables'],
    imageUrl: 'https://via.placeholder.com/400x300?text=Kottu+Cheese',
  },
  {
    name: 'String Hoppers',
    price: 280,
    description: 'Thin rice noodles with spicy curry sauce',
    category: 'Hoppers',
    rating: 4.4,
    dietaryTags: ['Vegetarian', 'Vegan'],
    ingredients: ['Rice Noodles', 'Coconut Milk', 'Spices'],
    imageUrl: 'https://via.placeholder.com/400x300?text=String+Hoppers',
  },
  {
    name: 'Egg Hopper',
    price: 200,
    description: 'Bowl-shaped pancake with eggs and sweet sauce',
    category: 'Hoppers',
    rating: 4.6,
    dietaryTags: ['Vegetarian'],
    ingredients: ['Flour', 'Egg', 'Coconut Milk', 'Sugar'],
    imageUrl: 'https://via.placeholder.com/400x300?text=Egg+Hopper',
  },
  {
    name: 'Fish Rolls',
    price: 180,
    description: 'Crispy pastry rolls filled with spiced fish',
    category: 'Short Eats',
    rating: 4.5,
    dietaryTags: ['Non-Vegetarian'],
    ingredients: ['Fish', 'Pastry', 'Spices', 'Onion'],
    imageUrl: 'https://via.placeholder.com/400x300?text=Fish+Rolls',
  },
  {
    name: 'Samosa',
    price: 120,
    description: 'Crispy triangular pastry with potato and spice filling',
    category: 'Short Eats',
    rating: 4.3,
    dietaryTags: ['Vegetarian'],
    ingredients: ['Pastry', 'Potato', 'Peas', 'Spices'],
    imageUrl: 'https://via.placeholder.com/400x300?text=Samosa',
  },
  {
    name: 'Chicken Roll',
    price: 150,
    description: 'Cylindrical pastry with seasoned chicken filling',
    category: 'Short Eats',
    rating: 4.4,
    dietaryTags: ['Non-Vegetarian'],
    ingredients: ['Pastry', 'Chicken', 'Spices', 'Egg'],
    imageUrl: 'https://via.placeholder.com/400x300?text=Chicken+Roll',
  },
  {
    name: 'Devilled Prawns',
    price: 620,
    description: 'Jumbo prawns stir-fried in a sweet and spicy tomato sauce with onions and capsicum.',
    category: 'Seafood',
    rating: 4.8,
    dietaryTags: ['Non-Vegetarian', 'Gluten-Free'],
    ingredients: ['Prawns', 'Chili', 'Garlic', 'Mustard'],
    imageUrl: 'https://via.placeholder.com/400x300?text=Devilled+Prawns',
  },
  {
    name: 'Garlic Butter Crab',
    price: 750,
    description: 'Fresh crab with garlic and butter sauce',
    category: 'Seafood',
    rating: 4.9,
    dietaryTags: ['Non-Vegetarian', 'Gluten-Free'],
    ingredients: ['Crab', 'Garlic', 'Butter', 'Herbs'],
    imageUrl: 'https://via.placeholder.com/400x300?text=Garlic+Butter+Crab',
  },
  {
    name: 'Chicken Fried Rice',
    price: 400,
    description: 'Fragrant fried rice with tender chicken and vegetables',
    category: 'Rice Specialties',
    rating: 4.6,
    dietaryTags: ['Non-Vegetarian'],
    ingredients: ['Rice', 'Chicken', 'Vegetables', 'Soy Sauce'],
    imageUrl: 'https://via.placeholder.com/400x300?text=Chicken+Fried+Rice',
  },
  {
    name: 'Vegetable Fried Rice',
    price: 320,
    description: 'Colorful fried rice with mixed vegetables',
    category: 'Rice Specialties',
    rating: 4.4,
    dietaryTags: ['Vegetarian', 'Vegan'],
    ingredients: ['Rice', 'Vegetables', 'Soy Sauce', 'Garlic'],
    imageUrl: 'https://via.placeholder.com/400x300?text=Vegetable+Fried+Rice',
  },
  {
    name: 'Biriyani',
    price: 480,
    description: 'Fragrant rice cooked with marinated chicken and spices',
    category: 'Rice Specialties',
    rating: 4.7,
    dietaryTags: ['Non-Vegetarian'],
    ingredients: ['Rice', 'Chicken', 'Yogurt', 'Spices'],
    imageUrl: 'https://via.placeholder.com/400x300?text=Biriyani',
  },
  {
    name: 'Vegetable Curry',
    price: 280,
    description: 'Mix of seasonal vegetables in creamy coconut curry',
    category: 'Rice & Curry',
    rating: 4.5,
    dietaryTags: ['Vegetarian', 'Vegan'],
    ingredients: ['Vegetables', 'Coconut Milk', 'Spices'],
    imageUrl: 'https://via.placeholder.com/400x300?text=Vegetable+Curry',
  },
];

async function seedDatabase() {
  try {
    await mongoose.connect(process.env.MONGO_URI);
    console.log('✅ Connected to MongoDB');

    await Food.deleteMany({});
    console.log('🗑️  Cleared existing foods');

    const result = await Food.insertMany(sriLankanFoods);
    console.log(`✅ Seeded ${result.length} food items`);

    const categories = await Food.distinct('category');
    console.log(`📂 Categories: ${categories.join(', ')}`);

    console.log('\n✨ Database seeding complete!');
    process.exit(0);
  } catch (error) {
    console.error('❌ Seeding error:', error.message);
    process.exit(1);
  }
}

seedDatabase();
