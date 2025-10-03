import 'package:flutter/material.dart';

class ExtendedElevatedButton extends StatelessWidget {
  const ExtendedElevatedButton({
    super.key,
    this.onPressed,
    required this.label,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
  });

  final VoidCallback? onPressed;
  final String label;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;

  ExtendedElevatedButton.isLoadingProgress({String? label, Key? key})
    : this(
        label: label ?? 'Loading',
        icon: Transform.scale(
          scale: 0.5,
          child: const CircularProgressIndicator(),
        ),
        key: key,
      );

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: icon,
        onPressed: onPressed,
        style: onPressed == null
            ? null
            : ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  backgroundColor ?? colorScheme.secondary,
                ),
                foregroundColor: WidgetStateProperty.all(
                  foregroundColor ?? colorScheme.onSecondary,
                ),
              ),
        label: Text(label),
      ),
    );
  }
}
