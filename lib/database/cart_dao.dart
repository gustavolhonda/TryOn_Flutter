import 'package:floor/floor.dart';
import '../models/cart_item.dart';

@dao
abstract class CartDao {
  @Query('SELECT * FROM cart_items')
  Stream<List<CartItem>> watchAllCartItems();

  @Query('SELECT * FROM cart_items')
  Future<List<CartItem>> getAllCartItems();

  @Query('SELECT * FROM cart_items WHERE productId = :productId AND size = :size')
  Future<CartItem?> getCartItem(int productId, String size);

  @insert
  Future<void> insertCartItem(CartItem cartItem);

  @update
  Future<void> updateCartItem(CartItem cartItem);

  @delete
  Future<void> deleteCartItem(CartItem cartItem);

  @Query('DELETE FROM cart_items')
  Future<void> deleteAllCartItems();
} 