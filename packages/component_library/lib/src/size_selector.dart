import 'package:flutter/material.dart';

class SizeSelector extends StatelessWidget {
  final List<String> sizes;
  final String selectedSize;
  final ValueChanged<String> onSizeSelected;

  const SizeSelector({
    super.key,
    required this.sizes,
    required this.selectedSize,
    required this.onSizeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Size',
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12.0),
          Wrap(
            spacing: 12.0, // Horizontal spacing
            runSpacing: 12.0, // Vertical spacing
            children: sizes.map<Widget>((size) {
              final bool isSelected = size == selectedSize;
              return InkWell(
                onTap: () => onSizeSelected(size),
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18.0,
                    vertical: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.black : Colors.grey[100],
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: isSelected ? Colors.black : Colors.grey.shade300,
                      width: 1.0,
                    ),
                  ),
                  child: Text(
                    size,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
