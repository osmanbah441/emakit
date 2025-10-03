import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class ItemListCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final double? listPrice;
  final Widget? subtitle;
  final Widget? action;
  final VoidCallback onTap;

  const ItemListCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.listPrice,
    this.subtitle,
    this.action,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final priceWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          spacing: 8,
          children: [
            if (listPrice != null && listPrice! > price)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.error,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "${((1 - (price / listPrice!)) * 100).toStringAsFixed(0)}%",
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onError,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Text(
              "Nle ${price.toStringAsFixed(2)}",
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),

        if (listPrice != null) ...[
          const SizedBox(width: 8),
          Text(
            "List: Nle ${listPrice!.toStringAsFixed(2)}",
            style: theme.textTheme.labelLarge?.copyWith(
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ],
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

                    priceWidget,
                    if (subtitle != null) subtitle!,
                    if (action != null) action!,
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
