// lib/components/custom_elevated_button.dart
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget? icon;
  final String label;
  final VoidCallback? onPressed;

  const CustomElevatedButton({
    super.key,
    this.icon,
    required this.label,
    this.onPressed,
  });

  CustomElevatedButton.loading({Key? key})
    : this(
        key: key,
        label: 'Loading...',
        icon: Transform.scale(
          scale: 0.5,
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: icon == null
          ? ElevatedButton(onPressed: onPressed, child: Text(label))
          : ElevatedButton.icon(
              icon: icon,
              label: Text(label),
              onPressed: onPressed,
            ),
    );
  }
}
