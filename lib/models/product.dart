class Product {
  final int id;
  final String name;
  final double price;
  final String shopName;
  final String shopCategory;
  final String description;
  final double rating;
  final List<String> availableSizes;
  final List<String> images;
  final bool? isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.shopName,
    required this.shopCategory,
    required this.description,
    required this.rating,
    required this.availableSizes,
    required this.images,
    this.isFavorite,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      shopName: json['shopName'] as String,
      shopCategory: json['shopCategory'] as String,
      description: json['description'] as String,
      rating: (json['rating'] as num).toDouble(),
      availableSizes: List<String>.from(json['avaliableSizes'] as List),
      images: List<String>.from(json['image'] as List),
      isFavorite: json['isFavorite'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'shopName': shopName,
      'shopCategory': shopCategory,
      'description': description,
      'rating': rating,
      'avaliableSizes': availableSizes,
      'image': images,
      'isFavorite': isFavorite,
    };
  }

  Product copyWith({
    int? id,
    String? name,
    double? price,
    String? shopName,
    String? shopCategory,
    String? description,
    double? rating,
    List<String>? availableSizes,
    List<String>? images,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      shopName: shopName ?? this.shopName,
      shopCategory: shopCategory ?? this.shopCategory,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      availableSizes: availableSizes ?? this.availableSizes,
      images: images ?? this.images,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
} 