// product_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({
    super.key,
    required this.name,
    this.storeName,
    this.onStoreTap,
    this.averageRating = 0,
    this.reviewCount = 0,
  });

  final String name;
  final double averageRating;
  final int reviewCount;
  final String? storeName;
  final VoidCallback? onStoreTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: textTheme.titleLarge),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (storeName != null)
              TextButton(
                onPressed: onStoreTap,
                child: Text('by $storeName', style: textTheme.labelSmall),
              ),
            StarRatingComponent(
              averageRating: averageRating,
              reviewCount: reviewCount,
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
