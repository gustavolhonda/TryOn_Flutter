import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductRepository {
  static const String _baseUrl = 'http://10.0.2.2:3001';
  static const String _testBaseUrl = 'http://localhost:3001';
  
  final bool useTestUrl;
  
  ProductRepository({this.useTestUrl = false});
  
  String get baseUrl => useTestUrl ? _testBaseUrl : _baseUrl;

  Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
} 