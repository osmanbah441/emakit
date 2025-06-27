import 'package:flutter/material.dart';

class SecondaryActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Widget? icon;

  const SecondaryActionButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        icon: icon,
        onPressed: onPressed,

        label: Text(label),
      ),
    );
  }
}
