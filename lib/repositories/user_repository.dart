import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRepository {
  static const String _baseUrl = 'http://10.0.2.2:3001';
  static const String _testBaseUrl = 'http://localhost:3001';
  
  final bool useTestUrl;
  
  UserRepository({this.useTestUrl = false});
  
  String get baseUrl => useTestUrl ? _testBaseUrl : _baseUrl;

  Future<String> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final message = responseData['message'];
        return message == 'success' ? 'success' : 'unknown_success';
      } else {
        switch (response.statusCode) {
          case 400:
            return 'missing_fields';
          case 404:
            return 'wrong_username';
          case 401:
            return 'wrong_password';
          default:
            return 'error_${response.statusCode}';
        }
      }
    } catch (e) {
      return 'failed_connection';
    }
  }
} 