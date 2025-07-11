import 'package:flutter/material.dart';

class ExtendedElevatedButton extends StatelessWidget {
  const ExtendedElevatedButton({
    super.key,
    this.onPressed,
    required this.label,
    this.icon,
  });

  final VoidCallback? onPressed;
  final String label;
  final Widget? icon;

  ExtendedElevatedButton.isLoadingProgress({required String label, Key? key})
    : this(
        label: label,
        icon: Transform.scale(
          scale: 0.5,
          child: const CircularProgressIndicator(),
        ),
        key: key,
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: icon,
        onPressed: onPressed,

        label: Text(label),
      ),
    );
  }
}
