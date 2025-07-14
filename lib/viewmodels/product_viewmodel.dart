import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../repositories/cart_repository.dart';

class ProductViewModel extends ChangeNotifier {
  final CartRepository _cartRepository;

  ProductViewModel(this._cartRepository);

  Product? _selectedProduct;
  String? _selectedImage;
  final Map<int, String?> _selectedSizes = {};
  final Map<int, bool> _favorites = {};
  bool _showToast = false;
  String _toastMessage = '';

  // Getters
  Product? get selectedProduct => _selectedProduct;
  String? get selectedImage => _selectedImage;
  Map<int, String?> get selectedSizes => _selectedSizes;
  Map<int, bool> get favorites => _favorites;
  bool get showToast => _showToast;
  String get toastMessage => _toastMessage;

  void setSelectedProduct(Product product) {
    _selectedProduct = product;
    _selectedImage = product.images.isNotEmpty ? product.images.first : null;
    notifyListeners();
  }

  void setSelectedImage(String imageUrl) {
    _selectedImage = imageUrl;
    notifyListeners();
  }

  void setSelectedSize(int productId, String size) {
    _selectedSizes[productId] = size;
    notifyListeners();
  }

  String? getSelectedSize(int productId) {
    return _selectedSizes[productId];
  }

  void toggleFavorite(int productId) {
    _favorites[productId] = !(_favorites[productId] ?? false);
    notifyListeners();
  }

  bool isFavorite(int productId) {
    return _favorites[productId] ?? false;
  }

  void showToastMessage(String message) {
    _toastMessage = message;
    _showToast = true;
    notifyListeners();
    
    // Auto-hide toast after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      _showToast = false;
      notifyListeners();
    });
  }

  Future<void> addToCart(Product product, String size) async {
    try {
      await _cartRepository.addToCart(product, size);
      showToastMessage('Produto adicionado ao carrinho!');
    } catch (e) {
      showToastMessage('Erro ao adicionar ao carrinho');
      debugPrint('Error adding to cart: $e');
    }
  }

  Future<void> addToCartWithSelectedSize(Product product) async {
    final selectedSize = getSelectedSize(product.id);
    if (selectedSize != null) {
      await addToCart(product, selectedSize);
    } else {
      showToastMessage('Selecione um tamanho');
    }
  }
} 