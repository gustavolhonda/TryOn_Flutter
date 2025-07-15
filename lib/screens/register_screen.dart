import 'package:flutter/material.dart';
import '../generated/l10n.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).registerTitle),
      ),
      body: Center(
        child: Text(
          S.of(context).registerScreen,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
} 