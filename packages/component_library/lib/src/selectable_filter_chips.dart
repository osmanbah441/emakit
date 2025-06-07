import 'package:flutter/material.dart';

class SelectableFilterChips<T> extends StatefulWidget {
  final String title;
  final List<T> options;
  final ValueChanged<T?> onOptionSelected;
  final T? selectedOption;
  final String Function(T) itemLabelBuilder;

  const SelectableFilterChips({
    super.key,
    required this.title,
    required this.options,
    required this.onOptionSelected,
    this.selectedOption,
    required this.itemLabelBuilder,
  });

  @override
  State<SelectableFilterChips<T>> createState() =>
      _SelectableFilterChipsState<T>();
}

class _SelectableFilterChipsState<T> extends State<SelectableFilterChips<T>> {
  T? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.selectedOption;
  }

  @override
  void didUpdateWidget(covariant SelectableFilterChips<T> oldWidget) {
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
        Text(widget.title, style: textTheme.titleSmall),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.options.map((option) {
            bool isSelected = _selectedOption == option;
            return FilterChip(
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
            );
          }).toList(),
        ),
      ],
    );
  }
}
