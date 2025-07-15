import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../repositories/product_repository.dart';
import 'package:atividade_avaliativa_2/generated/l10n.dart';

class HomeViewModel extends ChangeNotifier {
  final ProductRepository _productRepository;

  HomeViewModel(this._productRepository);

  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;
  int _selectedTabIndex = 0;

  static const List<String> _tabTitles = ['Todos', 'Promoções', 'Lojas'];

  // Getters
  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get selectedTabIndex => _selectedTabIndex;
  List<String> get tabTitles => _tabTitles;

  void updateSelectedTab(int index) {
    if (index != _selectedTabIndex) {
      _selectedTabIndex = index;
      notifyListeners();
    }
  }

  Future<void> loadProducts(BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await _productRepository.getProducts();
      _error = null;
    } catch (e) {
      _error = S.of(context).errorLoadingProducts;
      debugPrint('Error loading products: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void refreshProducts(BuildContext context) {
    loadProducts(context);
  }
} 