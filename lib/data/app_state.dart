import 'package:flutter/material.dart';
import 'mock_service.dart';
import 'models.dart';

class AppState extends ChangeNotifier {
  final MockApiService _api = MockApiService();

  // User State
  User? _currentUser;
  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;

  // Data State
  List<FoodItem> _foods = [];
  List<FoodItem> get foods => _foods;
  bool _isLoadingFoods = false;
  bool get isLoadingFoods => _isLoadingFoods;

  // Cart State
  List<CartItem> _cart = [];
  List<CartItem> get cart => _cart;
  String? _promoCode;
  String? get promoCode => _promoCode;

  double get subtotal => _cart.fold(0, (sum, item) => sum + item.totalPrice);
  double get deliveryFee => _cart.isEmpty ? 0 : 350.0; // Fixed mock fee
  double get total => subtotal + deliveryFee;

  // Order State
  List<Order> _orders = [];
  List<Order> get orders => _orders;

  // --- Auth Actions ---
  Future<void> login(String email, String password) async {
    _currentUser = await _api.login(email, password);
    await fetchFoods(); // Load data on login
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    _cart.clear();
    _orders.clear();
    notifyListeners();
  }

  // --- Data Actions ---
  Future<void> fetchFoods() async {
    if (_isLoadingFoods) return;
    _isLoadingFoods = true;
    notifyListeners(); // Notify loading start

    try {
      _foods = await _api.getFoodItems();
    } catch (e) {
      debugPrint("Error fetching foods: $e");
    } finally {
      _isLoadingFoods = false;
      notifyListeners();
    }
  }

  // --- Cart Actions ---
  void addToCart(FoodItem food, {int quantity = 1, List<String> options = const []}) {
    // Check if item already exists with same options
    final existingIndex = _cart.indexWhere((item) => 
      item.food.id == food.id && listEquals(item.selectedOptions, options));

    if (existingIndex >= 0) {
      _cart[existingIndex].quantity += quantity;
    } else {
      _cart.add(CartItem(
        id: DateTime.now().toString(),
        food: food,
        quantity: quantity,
        selectedOptions: options,
      ));
    }
    notifyListeners();
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

  void applyPromoCode(String code) {
    _promoCode = code;
    // logic to discount could go here
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    _promoCode = null;
    notifyListeners();
  }

  // --- Order Actions ---
  Future<Order> placeOrder(String address) async {
    final order = await _api.placeOrder(_cart, total, address);
    _orders.insert(0, order);
    clearCart();
    notifyListeners();
    return order;
  }
  
  bool listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
