class User {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? avatarUrl;
  final List<Address> savedAddresses;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatarUrl,
    this.savedAddresses = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      avatarUrl: json['avatarUrl'],
      savedAddresses: (json['savedAddresses'] as List?)
          ?.map((addr) => Address.fromJson(addr))
          .toList() ?? [],
    );
  }
}

class Address {
  final String id;
  final String label;
  final String fullAddress;
  final bool isDefault;

  Address({
    required this.id,
    required this.label,
    required this.fullAddress,
    this.isDefault = false,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] ?? '',
      label: json['name'] ?? json['label'] ?? '',
      fullAddress: json['street'] ?? '',
      isDefault: json['isDefault'] ?? false,
    );
  }
}

class FoodItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;
  final String category;
  final List<String> dietaryTags;
  final List<String> ingredients;
  final bool isAvailable;
  final bool isPopular;

  FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.rating = 4.5,
    required this.category,
    this.dietaryTags = const [],
    this.ingredients = const [],
    this.isAvailable = true,
    this.isPopular = false,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? 'https://via.placeholder.com/400x300',
      rating: (json['rating'] ?? 4.5).toDouble(),
      category: json['category'] ?? '',
      dietaryTags: List<String>.from(json['dietaryTags'] ?? []),
      ingredients: List<String>.from(json['ingredients'] ?? []),
      isAvailable: json['available'] ?? true,
      isPopular: false,
    );
  }
}

class CartItem {
  final String id;
  final FoodItem food;
  int quantity;
  final List<String> selectedOptions;

  CartItem({
    required this.id,
    required this.food,
    this.quantity = 1,
    this.selectedOptions = const [],
  });

  double get totalPrice => food.price * quantity;
}

class Order {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double subtotal;
  final double deliveryFee;
  final double totalAmount;
  final String status;
  final DateTime createdAt;
  final String deliveryAddress;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.deliveryAddress,
  });
}

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
  });
}
