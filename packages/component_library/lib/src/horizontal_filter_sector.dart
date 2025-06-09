import 'package:flutter/material.dart';

class HorizontalFilterSelector<T> extends StatefulWidget {
  final String? title;
  final List<T> options;
  final ValueChanged<T?> onOptionSelected;
  final T? selectedOption;
  final String Function(T) itemLabelBuilder;

  const HorizontalFilterSelector({
    super.key,
    this.title,
    required this.options,
    required this.onOptionSelected,
    this.selectedOption,
    required this.itemLabelBuilder,
  });

  @override
  State<HorizontalFilterSelector<T>> createState() =>
      _HorizontalFilterSelectorState<T>();
}

class _HorizontalFilterSelectorState<T>
    extends State<HorizontalFilterSelector<T>> {
  T? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.selectedOption;
  }

  @override
  void didUpdateWidget(covariant HorizontalFilterSelector<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedOption != oldWidget.selectedOption) {
      _selectedOption = widget.selectedOption;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Text(widget.title!, style: textTheme.titleSmall),
        const SizedBox(height: 12),
        SizedBox(
          height: 48, // Adjust height as needed for your chips
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: widget.options.map((option) {
                bool isSelected = _selectedOption == option;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(
                      widget.itemLabelBuilder(option),
                      style: textTheme.labelLarge?.copyWith(
                        color: isSelected ? colorScheme.onPrimary : null,
                      ),
                    ),
                    selectedColor: colorScheme.primary,
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedOption = selected ? option : null;
                      });
                      widget.onOptionSelected(_selectedOption);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
