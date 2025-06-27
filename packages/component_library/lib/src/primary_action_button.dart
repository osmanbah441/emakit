import 'package:flutter/material.dart';

class PrimaryActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Widget? icon;

  const PrimaryActionButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // height: 48.0,
      child: ElevatedButton.icon(
        icon: icon,
        onPressed: onPressed,

        label: Text(label),
      ),
    );
  }
}
