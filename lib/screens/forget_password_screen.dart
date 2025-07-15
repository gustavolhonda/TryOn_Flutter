import 'package:flutter/material.dart';
import '../generated/l10n.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).forgotPasswordTitle),
      ),
      body: Center(
        child: Text(
          S.of(context).forgotPasswordScreen,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
} 