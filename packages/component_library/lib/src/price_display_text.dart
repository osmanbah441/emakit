import 'package:flutter/material.dart';

class PriceDisplayText extends StatelessWidget {
  final double price;
  final String currencySymbol;

  const PriceDisplayText({
    super.key,
    required this.price,
    this.currencySymbol = '\$', // Default to USD
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$currencySymbol${price.toStringAsFixed(2)}',
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
