import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import 'app/app.dart';
import 'database/database.dart';
import 'repositories/cart_repository.dart';
import 'repositories/product_repository.dart';
import 'repositories/user_repository.dart';
import 'viewmodels/login_viewmodel.dart';
import 'viewmodels/home_viewmodel.dart';
import 'viewmodels/product_viewmodel.dart';
import 'viewmodels/orders_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize database
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  
  // Initialize repositories
  final cartRepository = CartRepository(database);
  final productRepository = ProductRepository();
  final userRepository = UserRepository();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel(userRepository)),
        ChangeNotifierProvider(create: (_) => HomeViewModel(productRepository)),
        ChangeNotifierProvider(create: (_) => ProductViewModel(cartRepository)),
        ChangeNotifierProvider(create: (_) => OrdersViewModel(cartRepository)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TryOn',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF8B3A2E)),
        useMaterial3: true,
        textTheme: GoogleFonts.robotoTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFCEAE5),
          foregroundColor: Color(0xFF5C4438),
        ),
      ),
      routerConfig: AppRouter.router,
    );
  }
} 