import 'package:flutter/material.dart';

class WishlistToggleButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback? onToggle;

  const WishlistToggleButton({
    super.key,
    this.isFavorite = true,
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
          key: ValueKey<bool>(isFavorite),
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? colorScheme.error : null,
          ),
          onPressed: onToggle,
        ),
      ),
    );
  }
}
