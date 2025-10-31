import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:domain_models/src/buyer_product.dart';
import 'package:flutter/material.dart';

class _ProductImage extends StatelessWidget {
  final String url;
  final String? statusLabel;

  const _ProductImage({required this.url, this.statusLabel});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Stack(
      children: [
        AppNetworkImage(
          imageUrl: url,
          height: 160,
          fit: BoxFit.cover,
          borderRadius: BorderRadius.circular(12),
        ),
        if (statusLabel != null)
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusLabel == 'Sale'
                      ? colorScheme.error
                      : colorScheme.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  statusLabel!,
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _RatingBar extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const _RatingBar({this.rating = 4.0, this.reviewCount = 0});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < rating.floor()
                  ? Icons.star_rate_rounded
                  : Icons.star_border_rounded,
              color:
                  colorScheme.tertiary, // Themed color for stars (gold/yellow)
              size: 18,
            );
          }),
        ),
        if (reviewCount > 0)
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              '(${reviewCount.toString()})',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
      ],
    );
  }
}

class BuyerProductListCard extends StatelessWidget {
  final BuyerProductsList product;
  final Function(String productId, String variantId) onProductTap;

  const BuyerProductListCard({
    super.key,
    required this.product,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => onProductTap(product.id, product.variantId),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _ProductImage(
                    url: 'https://picsum.photos/seed/${product.id}/120/120',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      const _RatingBar(rating: 4.5, reviewCount: 120),
                      const SizedBox(height: 8),
                      Text(
                        'NLE \t ${product.price.toStringAsFixed(2)}',
                        style: textTheme.headlineSmall?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      PrimaryActionButton(
                        label: 'View Details',
                        onPressed: () =>
                            onProductTap(product.id, product.variantId),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
