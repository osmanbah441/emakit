import 'package:flutter/material.dart';

import 'app_barge_icon_button.dart';

class CartIconButton extends StatelessWidget {
  const CartIconButton({
    super.key,
    required this.itemCount,
    required this.onPressed,
  });

  final int itemCount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => AppBadgeIconButton(
    itemCount: itemCount,
    icon: Icons.shopping_cart_outlined,
    tooltip: 'Cart',
    onPressed: onPressed,
  );
}
