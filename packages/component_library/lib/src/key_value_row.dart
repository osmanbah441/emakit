import 'package:flutter/material.dart';

class KeyValueRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? labelTextStyle;
  final TextStyle? valueTextStyle;

  const KeyValueRow({
    super.key,
    required this.label,
    required this.value,
    this.labelTextStyle,
    this.valueTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = Theme.of(context).textTheme.titleSmall;

    return Column(
      children: [
        const Divider(height: 24.0, thickness: 1.0),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
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
        ),
      ],
    );
  }
}
