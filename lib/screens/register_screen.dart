import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar'),
      ),
      body: const Center(
        child: Text(
          'Tela de Registro',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
} 