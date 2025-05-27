import 'package:component_library/component_library.dart';

import 'package:flutter/material.dart';

class ProductInfoCard extends StatelessWidget {
  final String title;
  final VoidCallback? onAddToCart;
  final VoidCallback? onWishlistToggle;
  final bool isFavorite;
  final VoidCallback? onTap;
  final String imageUrl;
  final double price;

  const ProductInfoCard({
    super.key,
    required this.title,

    this.onTap,
    required this.imageUrl,
    required this.price,
    this.onAddToCart,
    this.onWishlistToggle,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageDisplay(imageUrl: imageUrl, heroTag: 'product_image'),
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PriceDisplayText(price: price),
                      const SizedBox(width: 8),
                      Expanded(
                        // Allow action buttons to take available space
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.end, // Align actions to the end
                          children: [
                            WishlistToggleButton(
                              isFavorite: isFavorite,
                              onToggle: onWishlistToggle,
                            ),
                            AddToCartButton(onPressed: onAddToCart),
                          ],
                        ),
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
