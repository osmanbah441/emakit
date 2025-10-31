import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class CartItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double lineTotalPrice;
  final double unitPrice;
  final bool inStock;
  final VoidCallback onTap;
  final bool isSelected;
  final ValueChanged<bool?> onSelect;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CartItemCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.lineTotalPrice,
    required this.unitPrice,
    required this.inStock,
    required this.onTap,
    required this.isSelected,
    required this.onSelect,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final priceSection = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              "Nle ${unitPrice.toStringAsFixed(2)}",
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            "Total Price: Nle ${lineTotalPrice.toStringAsFixed(2)}",
            style: theme.textTheme.labelLarge,
          ),
        ),
      ],
    );

    final subtitleWidget = Text(
      inStock ? "In Stock" : "Out of Stock",
      style: theme.textTheme.labelLarge?.copyWith(
        color: inStock ? Colors.green : Colors.red,
      ),
    );

    final actionWidget = QuantitySelector(
      quantity: quantity,
      onIncrement: onIncrement,
      onDecrement: onDecrement,
    );

    return Stack(
      children: [
        Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppNetworkImage(
                    imageUrl: imageUrl,
                    height: 136,
                    width: 136,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      spacing: 4,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelLarge,
                        ),
                        priceSection,
                        subtitleWidget,
                        actionWidget,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
              ),
            ),
            child: Checkbox(value: isSelected, onChanged: onSelect),
          ),
        ),
      ],
    );
  }
}
