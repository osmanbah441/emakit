import 'package:domain_models/domain_models.dart';
import 'package:domain_models/src/store_variation.dart';
import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class VariationListItem extends StatelessWidget {
  final StoreVariation variation;
  final String imageUrl;

  const VariationListItem({
    required this.variation,
    required this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final price = variation.price / 100.0;
    final priceText = '\$${price.toStringAsFixed(2)}';
    final stockText = 'Stock: ${variation.stockQuantity}';

    Color stockColor;
    // Keeping specific shades for semantic color coding (low stock/good stock)
    if (variation.stockQuantity < 50) {
      stockColor = Colors.orange.shade800;
    } else {
      stockColor = Colors.green.shade600;
    }

    return InkWell(
      onTap: () {
        debugPrint(
          'Tapped on variation: ${variation.id} (${variation.variantSignature})',
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppNetworkImage(
              borderRadius: BorderRadius.circular(8),
              imageUrl: 'https://via.placeholder.com/80',
              width: 80,
              height: 80,
            ),

            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    variation.variantSignature,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Text(
                        'Price: $priceText',
                        style: textTheme.titleSmall?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 16),

                      Text(
                        stockText,
                        style: textTheme.bodyMedium?.copyWith(
                          color: stockColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            IconButton(
              icon: Icon(Icons.delete_outline, color: colorScheme.error),
              onPressed: () {
                debugPrint('Deleting variation: ${variation.id}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
