import 'package:flutter/material.dart';

class OptionManagementFields extends StatelessWidget {
  final TextEditingController optionController;
  final List<String> optionValues;
  final VoidCallback onAddOption;
  final void Function(String option) onRemoveOption;

  const OptionManagementFields({
    super.key,
    required this.optionController,
    required this.optionValues,
    required this.onAddOption,
    required this.onRemoveOption,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Optional Values', style: theme.textTheme.titleMedium),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: optionValues.map((option) {
            return Chip(
              label: Text(option),
              onDeleted: () => onRemoveOption(option),
            );
          }).toList(),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            spacing: 12,
            children: [
              Expanded(
                child: TextField(
                  controller: optionController,
                  decoration: InputDecoration(hintText: 'Enter option value'),
                  onSubmitted: (_) => onAddOption(),
                ),
              ),
              SizedBox(
                height: 40,
                child: OutlinedButton(
                  onPressed: onAddOption,
                  child: Text('Add option'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
