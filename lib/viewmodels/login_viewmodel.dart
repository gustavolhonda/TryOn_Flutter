import 'package:flutter/foundation.dart';
import '../repositories/user_repository.dart';

enum LoginError {
  none,
  requiredField,
  wrongEmail,
  wrongPassword,
  unknown,
}

class LoginViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  LoginViewModel(this._userRepository);

  String _username = '';
  String _password = '';
  LoginError _usernameError = LoginError.none;
  LoginError _passwordError = LoginError.none;
  bool _isLoading = false;
  bool _isLoginSuccessful = false;

  // Getters
  String get username => _username;
  String get password => _password;
  LoginError get usernameError => _usernameError;
  LoginError get passwordError => _passwordError;
  bool get isLoading => _isLoading;
  bool get isLoginSuccessful => _isLoginSuccessful;

  // Setters
  set username(String value) {
    _username = value;
    notifyListeners();
  }

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  void clearErrors() {
    _usernameError = LoginError.none;
    _passwordError = LoginError.none;
    notifyListeners();
  }

  void resetLoginState() {
    _isLoginSuccessful = false;
    notifyListeners();
  }

  Future<void> performLogin() async {
    _usernameError = LoginError.none;
    _passwordError = LoginError.none;

    final trimmedUsername = _username.trim();

    if (trimmedUsername.isEmpty) {
      _usernameError = LoginError.requiredField;
      notifyListeners();
      return;
    }

    if (_password.isEmpty) {
      _passwordError = LoginError.requiredField;
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final status = await _userRepository.login(trimmedUsername, _password);
      
      switch (status) {
        case 'success':
          _isLoginSuccessful = true;
          break;
        case 'wrong_username':
          _usernameError = LoginError.wrongEmail;
          break;
        case 'wrong_password':
          _passwordError = LoginError.wrongPassword;
          break;
        default:
          _usernameError = LoginError.unknown;
          break;
      }
    } catch (e) {
      _usernameError = LoginError.unknown;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 