import 'package:flutter/material.dart';
import '../generated/l10n.dart';
import 'home_screen.dart';
import 'orders_screen.dart';
import 'notifications_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    HomeScreenWrapper(),
    OrdersScreen(),
    NotificationsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: S.of(context).mainHome,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_cart),
            label: S.of(context).mainOrders,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.notifications),
            label: S.of(context).mainNotifications,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF8B3A2E),
        onTap: _onItemTapped,
        backgroundColor: const Color(0xFFFCEAE5),
      ),
    );
  }
} 