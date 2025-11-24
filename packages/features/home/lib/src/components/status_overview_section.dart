import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:home/src/components/store_metric_card.dart';

class StatusOverviewSection extends StatelessWidget {
  final String title;
  final double amountHeld;
  final List<StatusItemData> items;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const StatusOverviewSection({
    super.key,
    required this.title,
    required this.items,
    this.buttonText,
    this.onButtonPressed,
    required this.amountHeld,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleLarge),
            const SizedBox(height: 20),

            ...items.map((item) => StatusListItem(data: item)),
            if (amountHeld > 0)
              StoreMetricCard(
                title: 'Expected amount held by Platform',
                value: amountHeld.toString(),
                icon: Icons.money_off_rounded,
              ),
            if (buttonText != null && onButtonPressed != null) ...[
              const SizedBox(height: 28),
              PrimaryActionButton(
                label: 'View Orders',
                onPressed: onButtonPressed,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class StatusListItem extends StatelessWidget {
  final StatusItemData data;

  const StatusListItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              data.icon,
              const SizedBox(width: 12),
              Text(data.label, style: theme.textTheme.bodyMedium),
            ],
          ),
          Text(
            data.value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class StatusItemData {
  final String label;
  final String value;
  final Widget icon;

  const StatusItemData({
    required this.label,
    required this.value,
    required this.icon,
  });
}
