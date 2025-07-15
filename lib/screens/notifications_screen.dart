import 'package:flutter/material.dart';
import '../generated/l10n.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).notificationsTitle),
        backgroundColor: const Color(0xFFFCEAE5),
        foregroundColor: const Color(0xFF5C4438),
      ),
      body: Center(
        child: Text(
          S.of(context).noNotifications,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
} 