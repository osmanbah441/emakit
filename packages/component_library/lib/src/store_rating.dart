import 'package:flutter/material.dart';

class _StarRating extends StatelessWidget {
  final double rating;
  final double size;

  const _StarRating({required this.rating, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor()
              ? Icons.star
              : index < rating
              ? Icons.star_half
              : Icons.star_border,
          color: Colors.amber,
          size: size,
        );
      }),
    );
  }
}

class StoreRating extends StatelessWidget {
  final String storeName;
  final double rating;
  final int reviewCount;

  const StoreRating({
    super.key,
    required this.storeName,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: theme.colorScheme.surfaceContainerHighest),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What buyers think of this store',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Based on $reviewCount reviews for $storeName',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  rating.toStringAsFixed(1),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                _StarRating(rating: rating, size: 18),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
