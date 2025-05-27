import 'package:flutter/material.dart';

class AddToCartButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isIncart;

  const AddToCartButton({super.key, this.onPressed, this.isIncart = false});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: 'Add to Cart',
      icon: Icon(Icons.add_shopping_cart_sharp),
    );
  }
}
