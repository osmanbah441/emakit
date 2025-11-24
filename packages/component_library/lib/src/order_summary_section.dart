import 'package:flutter/material.dart';

class OrderSummarySection extends StatelessWidget {
  final String subtotal;
  final String? shippingCost;
  final String? taxes;
  final String total;
  final String? discount;
  final String? orderId;
  final String? date;
  final String? shippingAddress;

  const OrderSummarySection({
    super.key,
    required this.subtotal,
    this.shippingCost,
    this.taxes,
    required this.total,
    this.discount,
    this.orderId,
    this.date,
    this.shippingAddress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            if (orderId != null)
              _KeyValueRow(label: 'Order ID', value: orderId!),
            if (date != null) _KeyValueRow(label: 'Date', value: date!),
            if (shippingAddress != null)
              _KeyValueRow(label: 'Delivery Address', value: shippingAddress!),
            _KeyValueRow(label: 'Subtotal', value: subtotal),
            if (shippingCost != null)
              _KeyValueRow(label: 'Shipping', value: shippingCost!),
            if (taxes != null) _KeyValueRow(label: 'Taxes', value: taxes!),
            if (discount != null)
              _KeyValueRow(
                label: 'Discount',
                value: discount!,
                textStyle: textTheme.bodyMedium?.copyWith(color: Colors.green),
              ),
            const Divider(height: 8),
            _KeyValueRow(
              label: 'Total',
              value: total,
              textStyle: textTheme.titleMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KeyValueRow extends StatelessWidget {
  const _KeyValueRow({
    required this.label,
    required this.value,
    this.textStyle,
  });

  final String label;
  final String value;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textStyle),
          Text(value, style: textStyle),
        ],
      ),
    );
  }
}
