import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Esqueceu a Senha'),
      ),
      body: const Center(
        child: Text(
          'Tela de Recuperação de Senha',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
} 