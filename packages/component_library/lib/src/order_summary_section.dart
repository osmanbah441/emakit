import 'package:component_library/src/section_title.dart';
import 'package:component_library/src/key_value_row.dart';
import 'package:flutter/material.dart';

class OrderSummarySection extends StatelessWidget {
  final String subtotal;
  final String shippingCost;
  final String taxes;
  final String total;

  const OrderSummarySection({
    super.key,
    required this.subtotal,
    required this.shippingCost,
    required this.taxes,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Summary', style: textTheme.titleLarge),
          KeyValueRow(label: 'Subtotal', value: subtotal),
          KeyValueRow(label: 'Shipping', value: shippingCost),
          KeyValueRow(label: 'Taxes', value: taxes),
          KeyValueRow(
            label: 'Total',
            value: total,
            valueTextStyle: textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
            labelTextStyle: textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
