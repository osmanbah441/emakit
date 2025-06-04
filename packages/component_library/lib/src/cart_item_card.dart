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

  const CartItemCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.totalPrice,
    required this.currentQuantity,
    required this.onDecrement,
    required this.onIncrement,
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
    final textTheme = Theme.of(context).textTheme;
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
                Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  '\$${totalPrice.toStringAsFixed(2)}',
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  formatAttributes(),
                  style: textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          // Quantity Controls
          Row(
            children: [
              _buildQuantityButton(Icons.remove, onDecrement),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  currentQuantity.toString(),
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              _buildQuantityButton(Icons.add, onIncrement),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(icon, size: 18, color: Colors.black),
      ),
    );
  }
}
