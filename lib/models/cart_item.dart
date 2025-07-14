import 'package:floor/floor.dart';
import 'product.dart';

@Entity(tableName: 'cart_items')
class CartItem {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  
  final int productId;
  final String name;
  final double price;
  final String shopName;
  final String shopCategory;
  final String description;
  final double rating;
  final String size;
  final String imageUrl;
  final int quantity;

  CartItem({
    this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.shopName,
    required this.shopCategory,
    required this.description,
    required this.rating,
    required this.size,
    required this.imageUrl,
    this.quantity = 1,
  });

  factory CartItem.fromProduct(Product product, String size) {
    return CartItem(
      productId: product.id,
      name: product.name,
      price: product.price,
      shopName: product.shopName,
      shopCategory: product.shopCategory,
      description: product.description,
      rating: product.rating,
      size: size,
      imageUrl: product.images.isNotEmpty ? product.images.first : '',
      quantity: 1,
    );
  }

  CartItem copyWith({
    int? id,
    int? productId,
    String? name,
    double? price,
    String? shopName,
    String? shopCategory,
    String? description,
    double? rating,
    String? size,
    String? imageUrl,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      shopName: shopName ?? this.shopName,
      shopCategory: shopCategory ?? this.shopCategory,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      size: size ?? this.size,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
    );
  }

  double get totalPrice => price * quantity;
} 