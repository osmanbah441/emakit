import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double totalPrice;
  final int currentQuantity;
  final Map<String, dynamic> attributes;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final String currency;

  const CartItemCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.totalPrice,
    required this.currentQuantity,
    required this.onDecrement,
    required this.onIncrement,
    this.currency = '\$',
    this.attributes = const {},
  });

  String formatAttributes() {
    if (attributes.isEmpty) return '';

    StringBuffer formattedText = StringBuffer();
    attributes.forEach((key, value) {
      // You can add more sophisticated formatting based on the key or value type
      // For example, if 'color' is a hex code, you might want to display the name
      // or if 'size' is in bytes, convert it to KB/MB.

      if (formattedText.isNotEmpty) {
        formattedText.write(", "); // Separate attributes with a comma and space
      }
      formattedText.write("${_capitalize(key)}: $value");
    });

    return formattedText.toString();
  }

  // Helper function to capitalize the first letter of a string
  String _capitalize(String s) =>
      (s.isEmpty) ? s : s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 80.0,
            width: 80.0,
            child: CachedProductImage(
              imageUrl: imageUrl,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          const SizedBox(width: 16.0),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: textTheme.titleMedium),
                const SizedBox(height: 4.0),
                Text(formatAttributes(), style: textTheme.labelSmall),
                const SizedBox(height: 8.0),
                Text(
                  '$currency ${totalPrice.toStringAsFixed(2)}',
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Quantity Controls
          Row(
            children: [
              _buildQuantityButton(context, Icons.remove, onDecrement),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  currentQuantity.toString(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),

              _buildQuantityButton(context, Icons.add, onIncrement),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(
    BuildContext context,
    IconData icon,
    VoidCallback onPressed,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: colorScheme.primary),
        ),
        child: Icon(icon),
      ),
    );
  }
}
