import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suas notificações'),
        backgroundColor: const Color(0xFFFCEAE5),
        foregroundColor: const Color(0xFF5C4438),
      ),
      body: const Center(
        child: Text(
          'Nenhuma notificação',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
} 