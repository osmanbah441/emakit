import 'package:flutter/material.dart';

class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? labelTextStyle;
  final TextStyle? valueTextStyle;

  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.labelTextStyle,
    this.valueTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = Theme.of(context).textTheme.bodyLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style:
                labelTextStyle ??
                defaultTextStyle?.copyWith(fontWeight: FontWeight.w100),
          ),
          Text(
            value,
            style:
                valueTextStyle ??
                defaultTextStyle?.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
