import 'package:flutter/material.dart';

class ToastWidget extends StatelessWidget {
  final String message;

  const ToastWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      left: 20,
      right: 20,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        color: Colors.green,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
} 