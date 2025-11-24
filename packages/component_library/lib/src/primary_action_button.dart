import 'package:flutter/material.dart';

class PrimaryActionButton extends StatelessWidget {
  const PrimaryActionButton({
    super.key,
    this.onPressed,
    required this.label,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.isExtended = true,
    this.buttonHeight = 40,
  });

  final VoidCallback? onPressed;
  final String label;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool? isExtended;
  final double buttonHeight;

  PrimaryActionButton.isLoadingProgress({String? label, Key? key})
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
      height: buttonHeight,
      width: isExtended! ? double.infinity : null,
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
