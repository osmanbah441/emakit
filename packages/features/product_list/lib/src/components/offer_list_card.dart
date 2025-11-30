import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class OfferListCard extends StatelessWidget {
  final StoreProduct offer;
  final VoidCallback onTap;

  const OfferListCard({super.key, required this.offer, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 1,
      color:
          colorScheme.surfaceContainerLow, // Adapts to light/dark automatically
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppNetworkImage(
                imageUrl: offer.productMedia!.first.url,
                width: 104,
                height: 104,
                borderRadius: BorderRadius.circular(12),
                fit: BoxFit.cover,
              ),

              const SizedBox(width: 16),

              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      offer.productName!,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(offer.variantSignature!, style: textTheme.bodySmall),
                    const SizedBox(height: 4),
                    Text(
                      'NLE ${offer.offerPrice!.toStringAsFixed(2)}',
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Stock: ${offer.offerStockQuantity!}',
                          style: textTheme.labelMedium,
                        ),
                        StatusBadge(status: OfferStatus.active),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final OfferStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = status.baseColor;

    // Logic:
    // Light Mode: Light pastel BG (shade 100), Dark text (shade 800)
    // Dark Mode: Low opacity BG, Light text (shade 200/300)

    final backgroundColor = isDark
        ? baseColor.withValues(alpha: .20)
        : baseColor.shade100;

    final textColor = isDark ? baseColor.shade200 : baseColor.shade800;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.displayName,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

enum OfferStatus {
  active,
  paused,
  outOfStock;

  // We return a MaterialColor so we can access shades (shade100, shade800, etc.)
  MaterialColor get baseColor => switch (this) {
    OfferStatus.active => Colors.green,
    OfferStatus.paused => Colors.orange,
    OfferStatus.outOfStock => Colors.red,
  };

  String get displayName => switch (this) {
    OfferStatus.active => 'Active',
    OfferStatus.paused => 'Paused',
    OfferStatus.outOfStock => 'Out of Stock',
  };
}
