import 'package:flutter/material.dart';
import 'api_service.dart';
import 'mock_service.dart';
import 'models.dart';

class AppState extends ChangeNotifier {
  final MockApiService _mockApi = MockApiService();

  User? _currentUser;
  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;

  List<FoodItem> _foods = [];
  List<FoodItem> get foods => _foods;
  bool _isLoadingFoods = false;
  bool get isLoadingFoods => _isLoadingFoods;

  List<CartItem> _cart = [];
  List<CartItem> get cart => _cart;
  String? _promoCode;
  String? get promoCode => _promoCode;

  double get subtotal => _cart.fold(0, (sum, item) => sum + item.totalPrice);
  double get deliveryFee => _cart.isEmpty ? 0 : 350.0;
  double get total => subtotal + deliveryFee;

  List<Order> _orders = [];
  List<Order> get orders => _orders;

  Future<void> autoLoginDemoUser() async {
    try {
      final result = await ApiService.login(email: 'demo@curryflow.com', password: 'demo123');
      if (result['success']) {
        _currentUser = result['user'];
        await fetchFoods();
        notifyListeners();
        return;
      }
    } catch (e) {
      debugPrint("Auto login failed, will try to register: $e");
    }
    
    try {
      final result = await register(
        name: 'Demo User',
        email: 'demo@curryflow.com',
        password: 'demo123',
        phone: '+94 77 000 0000',
      );
      if (result) {
        await fetchFoods();
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Auto register failed: $e");
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final result = await ApiService.login(email: email, password: password);
      debugPrint("Login result: $result");
      if (result['success']) {
        _currentUser = result['user'];
        debugPrint("User logged in: ${_currentUser?.name}");
        await fetchFoods();
        await fetchCart();
        notifyListeners();
        return true;
      } else {
        debugPrint("Login failed: ${result['message']}");
        return false;
      }
    } catch (e) {
      debugPrint("Login error: $e");
      return false;
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      final result = await ApiService.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
      );
      if (result['success']) {
        _currentUser = result['user'];
        await fetchFoods();
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Register error: $e");
      return false;
    }
  }

  void logout() {
    _currentUser = null;
    _cart.clear();
    _orders.clear();
    ApiService.setAuthToken('');
    notifyListeners();
  }

  Future<void> fetchFoods({String? category}) async {
    if (_isLoadingFoods) return;
    _isLoadingFoods = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    try {
      _foods = await _mockApi.getFoodItems();
      
      
      if (category != null && category.isNotEmpty && category != 'All') {
        _foods = _foods.where((food) => food.category == category).toList();
      }
    } catch (e) {
      debugPrint("Error fetching foods: $e");
    } finally {
      _isLoadingFoods = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  Future<void> fetchCart() async {
    try {
      debugPrint("Fetching cart from database...");
      final result = await ApiService.getCart();
      if (result['success']) {
        _cart.clear();
        final cartData = result['cart'];
        if (cartData != null && cartData['items'] != null) {
          for (var item in cartData['items']) {
            _cart.add(CartItem(
              id: item['_id'] ?? DateTime.now().toString(),
              food: FoodItem(
                id: item['foodId'],
                name: item['foodName'] ?? 'Unknown',
                price: (item['foodPrice'] ?? 0).toDouble(),
                description: '',
                imageUrl: 'https://via.placeholder.com/300x200?text=${item['foodName']}',
                category: '',
                rating: 4.5,
                dietaryTags: [],
                ingredients: [],
              ),
              quantity: item['quantity'] ?? 1,
              selectedOptions: List<String>.from(item['selectedOptions']?.values ?? []),
            ));
          }
        }
        debugPrint("Cart loaded from database. Total items: ${_cart.length}");
        notifyListeners();
      } else {
        debugPrint("Could not fetch cart: ${result['message']}");
      }
    } catch (e) {
      debugPrint("Error fetching cart: $e");
    }
  }

  Future<void> addToCart(FoodItem food, {int quantity = 1}) async {
    try {
      debugPrint("Adding to cart: ${food.name}, quantity: $quantity");
      final result = await ApiService.addToCart(
        foodId: food.id,
        quantity: quantity,
        selectedOptions: {'spiceLevel': 'medium'},
        foodName: food.name,
        foodPrice: food.price,
      );
      debugPrint("Cart result: $result");
      if (result['success']) {

        _cart.add(CartItem(
          id: DateTime.now().toString(),
          food: food,
          quantity: quantity,
          selectedOptions: ['medium'],
        ));
        debugPrint("Item added to cart. Total items: ${_cart.length}");
        notifyListeners();
      } else {
        debugPrint("Cart add failed: ${result['message']}");
      }
    } catch (e) {
      debugPrint("Error adding to cart: $e");
    }
  }

  void removeFromCart(String cartItemId) {
    _cart.removeWhere((item) => item.id == cartItemId);
    notifyListeners();
  }

  void updateQuantity(String cartItemId, int newQuantity) {
    final index = _cart.indexWhere((item) => item.id == cartItemId);
    if (index >= 0) {
      if (newQuantity <= 0) {
        removeFromCart(cartItemId);
      } else {
        _cart[index].quantity = newQuantity;
        notifyListeners();
      }
    }
  }

  Future<bool> applyPromoCode(String code) async {
    try {
      final result = await ApiService.applyPromoCode(code);
      if (result['success']) {
        _promoCode = code;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Error applying promo code: $e");
      return false;
    }
  }

  void clearCart() {
    _cart.clear();
    _promoCode = null;
    notifyListeners();
  }

  Future<bool> placeOrder({
    required Map<String, dynamic> deliveryAddress,
    required String paymentMethod,
    String? notes,
  }) async {
    try {
      final result = await ApiService.placeOrder(
        deliveryAddress: deliveryAddress,
        paymentMethod: paymentMethod,
        notes: notes,
      );
      if (result['success']) {
        clearCart();
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Error placing order: $e");
      return false;
    }
  }

  Future<void> fetchOrderHistory() async {
    try {
      await ApiService.getOrderHistory();
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching order history: $e");
    }
  }
}
