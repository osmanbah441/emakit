import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

import 'order_action_dialogs.dart';
import 'item_list_card.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.quantity,
    required this.onTap,
    required this.itemStatus,
    this.onConfirmTapped,
    this.onCancelTapped,
  });

  final String imageUrl;
  final String title;
  final double price;
  final int quantity;
  final VoidCallback onTap;
  final OrderItemStatus itemStatus;
  final VoidCallback? onConfirmTapped;
  final VoidCallback? onCancelTapped;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ItemListCard(
      imageUrl: imageUrl,

      title: title,
      price: price,
      onTap: onTap,
      itemStatus: itemStatus,
      quantity: quantity,
      action: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 12,
        children: [
          OutlinedButton(
            style: OutlinedButton.styleFrom().copyWith(
              foregroundColor: WidgetStateProperty.all(colorScheme.error),
            ),
            onPressed: () async {
              final confirmed = await showCancelItemDialog(context);
              if (confirmed == true) onCancelTapped?.call();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom().copyWith(
              backgroundColor: WidgetStateProperty.all(colorScheme.secondary),
              foregroundColor: WidgetStateProperty.all(colorScheme.onSecondary),
            ),
            child: Text('Confirm'),
            onPressed: () async {
              final confirmed = await showConfirmItemDialog(context);
              if (confirmed == true) onConfirmTapped?.call();
            },
          ),
        ],
      ),
    );
  }
}
