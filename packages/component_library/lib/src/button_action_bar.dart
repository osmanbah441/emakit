import 'package:flutter/material.dart';

class ButtonActionBar extends StatelessWidget {
  const ButtonActionBar({
    super.key,
    required this.leftLabel,
    required this.rightLabel,
    this.onLeftTap,
    this.onRightTap,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
  });

  final String leftLabel;
  final String rightLabel;
  final VoidCallback? onLeftTap;
  final VoidCallback? onRightTap;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      spacing: 8,
      children: [
        ElevatedButton(onPressed: onLeftTap, child: Text(leftLabel)),
        ElevatedButton(onPressed: onRightTap, child: Text(rightLabel)),
      ],
    );
  }
}
