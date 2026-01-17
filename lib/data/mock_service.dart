import 'models.dart';

/// Simulates a backend service with mock data
class MockApiService {
  // Simulate network delay
  Future<void> _delay([int milliseconds = 800]) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }

  // --- Auth ---
  Future<User> login(String email, String password) async {
    await _delay();
    if (email == 'user@example.com' && password == 'password') {
      return _mockUser;
    }
    // For demo purposes, allow any login
    return _mockUser;
  }

  Future<User> register(String name, String email, String password) async {
    await _delay();
    return User(
      id: 'u_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      savedAddresses: [],
    );
  }

  // --- Food ---
  Future<List<FoodItem>> getFoodItems() async {
    await _delay(500);
    return _allFoods;
  }

  Future<List<FoodItem>> getFeaturedFoods() async {
    await _delay(500);
    return _allFoods.where((f) => f.isPopular).toList();
  }

  Future<List<FoodItem>> getFoodsByCategory(String category) async {
    await _delay(300);
    return _allFoods.where((f) => f.category == category).toList();
  }

  // --- Orders ---
  Future<Order> placeOrder(List<CartItem> items, double total, String address) async {
    await _delay(1500);
    return Order(
      id: 'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
      userId: _mockUser.id,
      items: items,
      subtotal: total - 5.0, // assumption
      deliveryFee: 5.0,
      totalAmount: total,
      status: 'Pending',
      createdAt: DateTime.now(),
      deliveryAddress: address,
    );
  }

  Future<List<Order>> getOrderHistory() async {
    await _delay();
    return _mockOrders;
  }

  // --- Mock Data ---

  static final User _mockUser = User(
    id: 'user_123',
    name: 'Kasun Perera',
    email: 'kasun@example.com',
    phone: '+94 77 123 4567',
    savedAddresses: [
      Address(id: 'a1', label: 'Home', fullAddress: '123 Galle Road, Colombo 03', isDefault: true),
      Address(id: 'a2', label: 'Work', fullAddress: '45 Lotus Tower, Colombo 10'),
    ],
  );

  static final List<FoodItem> _allFoods = [
    // Rice & Curry
    FoodItem(
      id: 'rc1',
      name: 'Chicken Rice & Curry',
      description: 'Traditional Sri Lankan rice and curry with spicy chicken curry, dhal, pol sambol, and papadum.',
      price: 1200.0,
      imageUrl: 'https://via.placeholder.com/300x200?text=Chicken+Rice',
      category: 'Rice & Curry',
      dietaryTags: ['Spicy', 'Halal'],
      ingredients: ['Basmati Rice', 'Chicken', 'Coconut Milk', 'Spices'],
      isPopular: true,
    ),
    FoodItem(
      id: 'rc2',
      name: 'Fish Ambul Thiyal',
      description: 'Sour fish curry served with white rice and vegetables. A southern specialty.',
      price: 1350.0,
      imageUrl: 'https://via.placeholder.com/300x200?text=Fish+Curry',
      category: 'Rice & Curry',
      dietaryTags: ['Spicy', 'Pescatarian'],
      isPopular: true,
    ),
    
    // Kottu
    FoodItem(
      id: 'k1',
      name: 'Chicken Kottu Roti',
      description: 'Chopped godamba roti stir-fried with chicken, vegetables, eggs, and spices. The ultimate street food.',
      price: 1100.0,
      imageUrl: 'https://via.placeholder.com/300x200?text=Chicken+Kottu',
      category: 'Kottu',
      dietaryTags: ['Spicy'],
      isPopular: true,
    ),
    FoodItem(
      id: 'k2',
      name: 'Cheese Kottu',
      description: 'Our famous chicken kottu topped with a generous layer of melted cheese.',
      price: 1500.0,
      imageUrl: 'https://via.placeholder.com/300x200?text=Cheese+Kottu',
      category: 'Kottu',
      dietaryTags: ['Spicy', 'Cheesy'],
      isPopular: true,
    ),
    FoodItem(
      id: 'k3',
      name: 'Vegetable Kottu',
      description: 'Spiced vegetable kottu with a variety of fresh vegetables.',
      price: 950.0,
      imageUrl: 'https://via.placeholder.com/300x200?text=Veg+Kottu',
      category: 'Kottu',
      dietaryTags: ['Vegan', 'Spicy'],
    ),

    // Hoppers
    FoodItem(
      id: 'h1',
      name: 'String Hoppers Set',
      description: '10 String hoppers served with pol sambol and mild dhal curry.',
      price: 850.0,
      imageUrl: 'https://via.placeholder.com/300x200?text=String+Hoppers',
      category: 'Hoppers',
      dietaryTags: ['Vegetarian'],
      ingredients: ['Rice Flour', 'Coconut', 'Lentils'],
    ),
    FoodItem(
      id: 'h2',
      name: 'Egg Hopper',
      description: 'Crispy bowl-shaped pancake with a soft egg in the center.',
      price: 150.0,
      imageUrl: 'https://via.placeholder.com/300x200?text=Egg+Hopper',
      category: 'Hoppers',
      dietaryTags: ['Vegetarian'],
    ),

    // Short Eats
    FoodItem(
      id: 's1',
      name: 'Fish Rolls (3pcs)',
      description: 'Breaded and deep-fried rolls filled with spicy mackerel and potato mix.',
      price: 450.0,
      imageUrl: 'https://via.placeholder.com/300x200?text=Fish+Rolls',
      category: 'Short Eats',
      dietaryTags: ['Spicy'],
    ),
    FoodItem(
      id: 's2',
      name: 'Vegetable Samosa',
      description: 'Crispy pastry filled with spiced vegetables.',
      price: 120.0,
      imageUrl: 'https://via.placeholder.com/300x200?text=Samosa',
      category: 'Short Eats',
      dietaryTags: ['Vegan'],
    ),
    FoodItem(
      id: 's3',
      name: 'Chicken Roll',
      description: 'Fresh roll filled with seasoned chicken and vegetables.',
      price: 180.0,
      imageUrl: 'https://via.placeholder.com/300x200?text=Chicken+Roll',
      category: 'Short Eats',
      dietaryTags: ['Spicy'],
    ),

    // Seafood
    FoodItem(
      id: 'sf1',
      name: 'Devilled Prawns',
      description: 'Jumbo prawns stir-fried in a sweet and spicy tomato sauce with onions and capsicum.',
      price: 2200.0,
      imageUrl: 'https://via.placeholder.com/300x200?text=Devilled+Prawns',
      category: 'Seafood',
      dietaryTags: ['Spicy', 'Gluten-Free'],
      isPopular: true,
    ),
    FoodItem(
      id: 'sf2',
      name: 'Garlic Butter Crab',
      description: 'Fresh crab cooked in garlic butter with fresh herbs.',
      price: 2500.0,
      imageUrl: 'https://via.placeholder.com/300x200?text=Garlic+Crab',
      category: 'Seafood',
      dietaryTags: ['Spicy'],
      isPopular: true,
    ),

    // Rice Specialties
    FoodItem(
      id: 'rs1',
      name: 'Vegetable Fried Rice',
      description: 'Wok-fried rice with carrots, leeks, and cabbage.',
      price: 950.0,
      imageUrl: 'https://via.placeholder.com/300x200?text=Veg+Fried+Rice',
      category: 'Rice Specialties',
      dietaryTags: ['Vegetarian'],
    ),
    FoodItem(
      id: 'rs2',
      name: 'Chicken Fried Rice',
      description: 'Flavored fried rice with tender chicken pieces and vegetables.',
      price: 1100.0,
      imageUrl: 'https://via.placeholder.com/300x200?text=Chicken+Fried+Rice',
      category: 'Rice Specialties',
      dietaryTags: ['Spicy'],
    ),
    FoodItem(
      id: 'rs3',
      name: 'Seafood Fried Rice',
      description: 'Premium fried rice with prawns, squid, and fish.',
      price: 1800.0,
      imageUrl: 'https://via.placeholder.com/300x200?text=Seafood+Fried+Rice',
      category: 'Rice Specialties',
      dietaryTags: ['Spicy'],
    ),
  ];

  static final List<Order> _mockOrders = [
    Order(
      id: 'ORD-8821',
      userId: 'user_123',
      items: [
        CartItem(id: 'c1', food: _allFoods[0], quantity: 1),
        CartItem(id: 'c2', food: _allFoods[2], quantity: 2),
      ],
      subtotal: 3400,
      deliveryFee: 200,
      totalAmount: 3600,
      status: 'Delivered',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      deliveryAddress: '123 Galle Road, Colombo 03',
    ),
  ];
}
