import 'package:flutter/material.dart';

class WishlistToggleButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback? onToggle;

  const WishlistToggleButton({
    super.key,
    this.isFavorite = false,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Tooltip(
      message: isFavorite ? "Remove from Wishlist" : "Add to Wishlist",
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: IconButton(
          key: ValueKey<bool>(isFavorite), // Key for AnimatedSwitcher
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite
                ? Colors
                      .red
                      .shade600 // Explicit red for favorite
                : colorScheme.onSurface, // Themed color for unfavorite
            size: 24,
          ),
          onPressed: onToggle,
        ),
      ),
    );
  }
}
