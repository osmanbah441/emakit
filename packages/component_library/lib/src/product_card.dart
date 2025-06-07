import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final VoidCallback? onWishlistToggle;
  final VoidCallback? onAddToCart;
  final bool isWishlisted;
  final VoidCallback? onTap;
  final bool isInCart;
  final double imageAspectRatio;
  final String currency;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.isWishlisted = false,
    this.onWishlistToggle,
    this.onAddToCart,
    this.onTap,
    this.isInCart = false,
    this.imageAspectRatio = 4 / 3,
    this.currency = '\$',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            CachedProductImage(
              imageUrl: imageUrl,
              aspectRatio: imageAspectRatio,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Text(
                    title,
                    style: textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '$currency${price.toStringAsFixed(2)}',
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WishlistToggleButton(
                        onToggle: onWishlistToggle,
                        isFavorite: isWishlisted,
                      ),
                      AddToCartButton(
                        onPressed: onAddToCart,
                        isIncart: isInCart,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
