import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5000/api';
  static String? _authToken;

  static void setAuthToken(String token) {
    _authToken = token;
  }

  static Map<String, String> _getHeaders({bool requireAuth = true}) {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    if (requireAuth && _authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }
    return headers;
  }

  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: _getHeaders(requireAuth: false),
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        setAuthToken(data['token']);
        return {
          'success': true,
          'message': data['message'],
          'token': data['token'],
          'user': User.fromJson(data['user']),
        };
      } else {
        return {
          'success': false,
          'message': jsonDecode(response.body)['message'],
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: $e',
      };
    }
  }

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: _getHeaders(requireAuth: false),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setAuthToken(data['token']);
        return {
          'success': true,
          'message': data['message'],
          'token': data['token'],
          'user': User.fromJson(data['user']),
        };
      } else {
        return {
          'success': false,
          'message': jsonDecode(response.body)['message'],
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: $e',
      };
    }
  }

  static Future<User?> getProfile() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/auth/profile'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return User.fromJson(data['user']);
      }
      return null;
    } catch (e) {
      print('Error getting profile: $e');
      return null;
    }
  }

  static Future<List<FoodItem>> getAllFoods({String? category}) async {
    try {
      String url = '$baseUrl/foods';
      if (category != null) {
        url += '?category=$category';
      }

      final response = await http.get(
        Uri.parse(url),
        headers: _getHeaders(requireAuth: false),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<FoodItem> foods = (data['foods'] as List)
            .map((item) => FoodItem.fromJson(item))
            .toList();
        return foods;
      }
      return [];
    } catch (e) {
      print('Error fetching foods: $e');
      return [];
    }
  }

  static Future<FoodItem?> getFoodById(String foodId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/foods/$foodId'),
        headers: _getHeaders(requireAuth: false),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return FoodItem.fromJson(data['food']);
      }
      return null;
    } catch (e) {
      print('Error fetching food: $e');
      return null;
    }
  }

  static Future<List<String>> getCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/foods/categories'),
        headers: _getHeaders(requireAuth: false),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<String>.from(data['categories']);
      }
      return [];
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }

  static Future<List<FoodItem>> searchFoods(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/foods/search?q=$query'),
        headers: _getHeaders(requireAuth: false),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<FoodItem> foods = (data['foods'] as List)
            .map((item) => FoodItem.fromJson(item))
            .toList();
        return foods;
      }
      return [];
    } catch (e) {
      print('Error searching foods: $e');
      return [];
    }
  }

  static Future<Map<String, dynamic>> getCart() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/cart'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'cart': data['cart'],
        };
      }
      return {'success': false};
    } catch (e) {
      print('Error getting cart: $e');
      return {'success': false};
    }
  }

  static Future<Map<String, dynamic>> addToCart({
    required String foodId,
    required int quantity,
    Map<String, dynamic>? selectedOptions,
    String? foodName,
    double? foodPrice,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/cart/add'),
        headers: _getHeaders(),
        body: jsonEncode({
          'foodId': foodId,
          'foodName': foodName,
          'foodPrice': foodPrice,
          'quantity': quantity,
          'selectedOptions': selectedOptions ?? {},
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'message': data['message'],
          'cart': data['cart'],
        };
      } else {
        print('Add to cart failed: Status ${response.statusCode}, Body: ${response.body}');
        return {
          'success': false,
          'message': 'Failed to add to cart: ${response.statusCode}',
        };
      }
    } catch (e) {
      print('Error adding to cart: $e');
      return {
        'success': false,
        'message': 'Network error: $e',
      };
    }
  }

  static Future<Map<String, dynamic>> updateCartItem({
    required String itemId,
    required int quantity,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/cart/$itemId'),
        headers: _getHeaders(),
        body: jsonEncode({'quantity': quantity}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'cart': data['cart'],
        };
      }
      return {'success': false};
    } catch (e) {
      return {'success': false};
    }
  }

  static Future<Map<String, dynamic>> removeFromCart(String itemId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/cart/$itemId'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'cart': data['cart'],
        };
      }
      return {'success': false};
    } catch (e) {
      return {'success': false};
    }
  }

  static Future<Map<String, dynamic>> applyPromoCode(String code) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/cart/promo'),
        headers: _getHeaders(),
        body: jsonEncode({'promoCode': code}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'cart': data['cart'],
        };
      }
      return {
        'success': false,
        'message': jsonDecode(response.body)['message'],
      };
    } catch (e) {
      return {'success': false};
    }
  }

  static Future<Map<String, dynamic>> placeOrder({
    required Map<String, dynamic> deliveryAddress,
    required String paymentMethod,
    String? notes,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/orders/place'),
        headers: _getHeaders(),
        body: jsonEncode({
          'deliveryAddress': deliveryAddress,
          'paymentMethod': paymentMethod,
          'notes': notes ?? '',
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'message': data['message'],
          'order': data['order'],
        };
      }
      return {
        'success': false,
        'message': jsonDecode(response.body)['message'],
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: $e',
      };
    }
  }

  static Future<List<Map<String, dynamic>>> getOrderHistory() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/orders/history'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['orders']);
      }
      return [];
    } catch (e) {
      print('Error fetching orders: $e');
      return [];
    }
  }
}
