import 'package:flutter/material.dart';

class ExtendedOutlineButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Widget? icon;

  const ExtendedOutlineButton({
    super.key,
    this.onPressed,
    required this.label,
    this.icon,
  });

  ExtendedOutlineButton.isLoadingProgress({required String label, Key? key})
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
      width: double.infinity,
      height: 40,

      child: OutlinedButton.icon(
        icon: icon,
        onPressed: onPressed,
        label: Text(label),
      ),
    );
  }
}
