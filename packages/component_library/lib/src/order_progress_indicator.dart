import 'package:flutter/material.dart';

class OrderProgressIndicator extends StatelessWidget {
  const OrderProgressIndicator({
    super.key,
    required this.completedItems,
    required this.totalItems,
  });

  final int completedItems;
  final int totalItems;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = totalItems == 0 ? 0.0 : completedItems / totalItems;

    return Column(
      spacing: 12,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$completedItems of $totalItems items delivered',
              style: theme.textTheme.titleMedium,
            ),
            Text(
              '${(progress * 100).round()}%',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
            ),
          ],
        ),
        LinearProgressIndicator(
          borderRadius: BorderRadius.circular(8),
          semanticsValue: '${(progress * 100).round()}%',
          semanticsLabel: 'Progress',
          minHeight: 8,
          value: progress,
          backgroundColor: theme.colorScheme.primaryContainer,
          valueColor: AlwaysStoppedAnimation<Color>(
            theme.colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
