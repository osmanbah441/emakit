import 'package:flutter/material.dart';
import 'dart:math' as math;

class StarRatingComponent extends StatelessWidget {
  final double averageRating;
  final int reviewCount;
  final TextStyle? textStyle;

  const StarRatingComponent({
    super.key,
    required this.averageRating,
    required this.reviewCount,
    this.textStyle,
  });

  String _formatReviewCount(int count) {
    if (count < 1000) {
      return count.toString();
    }

    final List<String> suffixes = ['k', 'M', 'B', 'T'];
    final int log1000 = (math.log(count) / math.log(1000)).floor();

    if (log1000 >= suffixes.length) {
      return '>999T';
    }

    final double scaledValue = count / math.pow(1000, log1000);
    final String suffix = suffixes[log1000 - 1];

    String formattedValue = scaledValue.toStringAsFixed(
      scaledValue % 1 == 0 ? 0 : 1,
    );

    return '$formattedValue$suffix';
  }

  @override
  Widget build(BuildContext context) {
    final int filledStars = averageRating.floor();
    final bool hasHalfStar =
        (averageRating - filledStars) >= 0.25 &&
        (averageRating - filledStars) < 0.75;
    final int emptyStars = 5 - filledStars - (hasHalfStar ? 1 : 0);
    final theme = Theme.of(context);
    final double starSize = 16;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 4,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...List.generate(
              filledStars,
              (index) => Icon(
                Icons.star,
                color: theme.colorScheme.secondary,
                size: starSize,
              ),
            ),
            if (hasHalfStar)
              Icon(
                Icons.star_half,
                color: theme.colorScheme.secondary,
                size: starSize,
              ),
            ...List.generate(
              emptyStars,
              (index) => Icon(
                Icons.star_border,
                color: theme.colorScheme.secondary,
                size: starSize,
              ),
            ),
          ],
        ),

        Text(
          '(${averageRating.toStringAsFixed(1)}) ${_formatReviewCount(reviewCount)} reviews',
          style: theme.textTheme.labelSmall,
        ),
      ],
    );
  }
}
