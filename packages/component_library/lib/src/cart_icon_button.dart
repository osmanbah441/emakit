import 'package:flutter/material.dart';

class CartIconButton extends StatelessWidget {
  const CartIconButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => IconButton(
    icon: Icon(Icons.shopping_cart_outlined, size: 28),
    tooltip: 'Cart',
    onPressed: onPressed,
  );
}
