import 'package:go_router/go_router.dart';

import '../screens/login_screen.dart';
import '../screens/product_screen.dart';
import '../screens/register_screen.dart';
import '../screens/forget_password_screen.dart';
import '../screens/main_screen.dart';
import '../models/product.dart';

class AppRouter {
  static const String loginRoute = '/login';
  static const String mainRoute = '/main';
  static const String productRoute = '/product';
  static const String registerRoute = '/register';
  static const String forgetPasswordRoute = '/forget-password';

  static final GoRouter router = GoRouter(
    initialLocation: loginRoute,
    routes: [
      GoRoute(
        path: loginRoute,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: mainRoute,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: productRoute,
        builder: (context, state) {
          final product = state.extra as Product?;
          if (product != null) {
            return ProductScreen(product: product);
          } else {
            return const MainScreen();
          }
        },
      ),
      GoRoute(
        path: registerRoute,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: forgetPasswordRoute,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
    ],
  );
} 