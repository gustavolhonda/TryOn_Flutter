import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../repositories/cart_repository.dart';

class OrdersViewModel extends ChangeNotifier {
  final CartRepository _cartRepository;

  OrdersViewModel(this._cartRepository) {
    _watchCartItems();
  }

  List<CartItem> _cartItems = [];
  bool _isLoading = false;

  // Getters
  List<CartItem> get cartItems => _cartItems;
  bool get isLoading => _isLoading;
  
  double get totalPrice {
    return _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  int get totalItems {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  void _watchCartItems() {
    _cartRepository.watchAllCartItems().listen((items) {
      _cartItems = items;
      notifyListeners();
    });
  }

  Future<void> updateQuantity(CartItem item, int newQuantity) async {
    if (newQuantity <= 0) {
      await removeFromCart(item);
    } else {
      _isLoading = true;
      notifyListeners();
      
      try {
        final updatedItem = item.copyWith(quantity: newQuantity);
        await _cartRepository.updateCartItem(updatedItem);
      } catch (e) {
        debugPrint('Error updating quantity: $e');
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> removeFromCart(CartItem item) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await _cartRepository.removeFromCart(item);
    } catch (e) {
      debugPrint('Error removing from cart: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> clearCart() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await _cartRepository.clearCart();
    } catch (e) {
      debugPrint('Error clearing cart: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void incrementQuantity(CartItem item) {
    updateQuantity(item, item.quantity + 1);
  }

  void decrementQuantity(CartItem item) {
    updateQuantity(item, item.quantity - 1);
  }
} 