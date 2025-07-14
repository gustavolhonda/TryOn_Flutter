import '../database/database.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartRepository {
  final AppDatabase _database;

  CartRepository(this._database);

  Stream<List<CartItem>> watchAllCartItems() {
    return _database.cartDao.watchAllCartItems();
  }

  Future<List<CartItem>> getAllCartItems() {
    return _database.cartDao.getAllCartItems();
  }

  Future<void> addToCart(Product product, String size) async {
    final existingItem = await _database.cartDao.getCartItem(product.id, size);
    
    if (existingItem != null) {
      final updatedItem = existingItem.copyWith(quantity: existingItem.quantity + 1);
      await _database.cartDao.updateCartItem(updatedItem);
    } else {
      final newItem = CartItem.fromProduct(product, size);
      await _database.cartDao.insertCartItem(newItem);
    }
  }

  Future<void> updateCartItem(CartItem cartItem) async {
    await _database.cartDao.updateCartItem(cartItem);
  }

  Future<void> removeFromCart(CartItem cartItem) async {
    await _database.cartDao.deleteCartItem(cartItem);
  }

  Future<void> clearCart() async {
    await _database.cartDao.deleteAllCartItems();
  }
} 