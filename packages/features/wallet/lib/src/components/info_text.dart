import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class InfoText extends StatelessWidget {
  const InfoText({super.key, required this.amount, this.text});
  final double amount;
  final String? text;

  static const double processingRate = 1.5 / 100;

  String get _processingFee => (amount * processingRate).toStringAsFixed(2);
  String get _totalCharge =>
      (amount + (amount * processingRate)).toStringAsFixed(2);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final infoSection = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextRowComponent(
          label: 'Processing Fee',
          value: 'NLe $_processingFee',
          labelStyle: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        TextRowComponent(
          label: 'Total',
          value: 'NLe $_totalCharge',
          valueStyle: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
    return Container(
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (amount > 0) infoSection,
          if (text != null)
            Text(
              text!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
        ],
      ),
    );
  }
}
