import 'package:component_library/src/section_title.dart';
import 'package:component_library/src/summary_row.dart';
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
          const SectionTitle(title: 'Order Summary'),
          const SizedBox(height: 16.0),
          SummaryRow(label: 'Subtotal', value: subtotal),
          SummaryRow(label: 'Shipping', value: shippingCost),
          SummaryRow(label: 'Taxes', value: taxes),
          const Divider(height: 24.0, thickness: 1.0),
          SummaryRow(
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
