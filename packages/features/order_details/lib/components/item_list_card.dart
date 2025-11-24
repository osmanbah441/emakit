import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class ItemListCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final int quantity;
  final Widget? action;
  final VoidCallback onTap;
  final OrderItemStatus itemStatus;

  const ItemListCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.quantity,
    this.action,
    required this.onTap,
    required this.itemStatus,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final (color, label) = switch (itemStatus) {
      OrderItemStatus.pending => (Colors.orange, 'Pending'),
      OrderItemStatus.approved => (Colors.green, 'Confirmed'),
      OrderItemStatus.outForDelivery => (Colors.purple, 'Delivered'),
      OrderItemStatus.rejected => (Colors.red, 'Cancelled'),
    };

    final priceWidget = Text(
      "Nle ${price.toStringAsFixed(2)}",
      style: theme.textTheme.titleLarge?.copyWith(
        color: theme.colorScheme.primary,
      ),
    );

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 12,
            children: [
              AppNetworkImage(
                imageUrl: imageUrl,
                height: 136,
                width: 136,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(12),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelLarge,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [priceWidget, Text('Quantity: $quantity')],
                        ),
                        Text(
                          label,
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),

                    if (action != null &&
                        itemStatus != OrderItemStatus.rejected &&
                        itemStatus != OrderItemStatus.approved) ...[
                      const SizedBox(height: 8),
                      action!,
                    ],
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
