// lib/components/generic_action_button.dart
import 'package:flutter/material.dart';

class GenericActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const GenericActionButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(label));
  }
}
