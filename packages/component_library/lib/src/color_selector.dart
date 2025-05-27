import 'package:flutter/material.dart';

class ColorSelector extends StatelessWidget {
  final List<Color> colors;
  final Color selectedColor;
  final ValueChanged<Color> onColorSelected;

  const ColorSelector({
    super.key,
    required this.colors,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Color",
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
            children: colors.map<Widget>((color) {
              final bool isSelected = color == selectedColor;
              return GestureDetector(
                onTap: () => onColorSelected(color),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? Colors.blue.shade700
                          : Colors.grey.shade300,
                      width: isSelected ? 3.0 : 1.0,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, size: 20, color: Colors.white)
                      : null,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
