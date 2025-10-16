import 'package:component_library/src/order_progress_indicator.dart';
import 'package:flutter/material.dart';

class OrderListCard extends StatelessWidget {
  final String orderId;
  final String formattedDate;
  final String amount;
  final VoidCallback onTap;
  final int totalItems;
  final int completedItems;

  const OrderListCard({
    super.key,
    required this.orderId,
    required this.formattedDate,
    required this.amount,
    required this.onTap,
    required this.totalItems,
    required this.completedItems,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardBorderRadius = BorderRadius.circular(12);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: cardBorderRadius),
      child: InkWell(
        borderRadius: cardBorderRadius,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderId,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(formattedDate, style: theme.textTheme.bodySmall),
                    ],
                  ),
                  Text(
                    amount,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                    ),
                  ),
                ],
              ),

              OrderProgressIndicator(
                completedItems: completedItems,
                totalItems: totalItems,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
