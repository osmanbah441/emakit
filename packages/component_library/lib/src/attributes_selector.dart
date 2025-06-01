import 'package:flutter/material.dart';

class AttributeSelector<T> extends StatelessWidget {
  final String selectorLabel;
  final List<T> options;
  final T? selectedOption;
  final ValueChanged<T> onOptionSelected;

  const AttributeSelector({
    super.key,
    required this.selectorLabel,
    required this.options,
    this.selectedOption,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${selectorLabel.substring(0, 1).toUpperCase()}${selectorLabel.substring(1)}:',
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 4.0),
        Wrap(
          spacing: 8.0, // Space between chips
          runSpacing: 8.0, // Space between rows of chips
          children: options.map((option) {
            final bool isSelected = option == selectedOption;

            return ChoiceChip(
              label: Text(option.toString()),
              selected: isSelected,
              onSelected: (bool selected) {
                if (selected) {
                  onOptionSelected(option);
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
