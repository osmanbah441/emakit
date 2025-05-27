import 'package:flutter/material.dart';

class CartItemRow extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String quantityText; // e.g., "Quantity: 1"
  final int currentQuantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const CartItemRow({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.quantityText,
    required this.currentQuantity,
    required this.onDecrement,
    required this.onIncrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.grey[200], // Placeholder background
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover, // Adjust fit as needed
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                          : null,
                      strokeWidth: 2,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.broken_image,
                    size: 40,
                    color: Colors.grey,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 16.0),

          // Item Details (Title and Quantity Text)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  quantityText,
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
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
      borderRadius: BorderRadius.circular(
        12.0,
      ), // Half of width/height for circular
      child: Container(
        width: 28, // Smaller button size
        height: 28,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F0F0), // Light grey background
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey.shade300), // Subtle border
        ),
        child: Icon(icon, size: 18, color: Colors.black),
      ),
    );
  }
}
