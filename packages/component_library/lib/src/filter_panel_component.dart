import 'package:flutter/material.dart';

class FilterPanelComponent extends StatefulWidget {
  final Map<String, List<String>> filterData;
  final Map<String, Set<String>> activeFilters;
  final ValueChanged<Map<String, Set<String>>> onFiltersChanged;

  const FilterPanelComponent({
    super.key,
    required this.filterData,
    required this.activeFilters,
    required this.onFiltersChanged,
  });

  @override
  State<FilterPanelComponent> createState() => _FilterPanelComponentState();
}

class _FilterPanelComponentState extends State<FilterPanelComponent> {
  late String _selectedCategory;
  late Map<String, Set<String>> _selectedOptions;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.filterData.keys.first;
    _selectedOptions = widget.activeFilters.map(
      (key, value) => MapEntry(key, Set.from(value)),
    );
  }

  @override
  void didUpdateWidget(covariant FilterPanelComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.activeFilters != oldWidget.activeFilters) {
      setState(() {
        _selectedOptions = widget.activeFilters.map(
          (key, value) => MapEntry(key, Set.from(value)),
        );
      });
    }
  }

  void _onChipSelected(String category, String option, bool isSelected) {
    final newSelections = _selectedOptions.map(
      (key, value) => MapEntry(key, Set.from(value)),
    );
    newSelections.putIfAbsent(category, () => {});

    if (isSelected) {
      newSelections[category]!.add(option);
    } else {
      newSelections[category]!.remove(option);
    }
    widget.onFiltersChanged(newSelections.cast<String, Set<String>>());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedCategoryOptions = widget.filterData[_selectedCategory]!;

    return Row(
      children: [
        Container(
          width: 140,
          decoration: BoxDecoration(
            border: Border(right: BorderSide(color: Colors.grey.shade300)),
          ),
          child: ListView.builder(
            itemCount: widget.filterData.keys.length,
            itemBuilder: (context, index) {
              final category = widget.filterData.keys.elementAt(index);
              final isSelected = category == _selectedCategory;
              return Material(
                color: isSelected
                    ? theme.primaryColor.withOpacity(0.1)
                    : Colors.transparent,
                child: InkWell(
                  onTap: () => setState(() => _selectedCategory = category),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 12.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: isSelected
                              ? theme.primaryColor
                              : Colors.transparent,
                          width: 4,
                        ),
                      ),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSelected ? theme.primaryColor : Colors.black87,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) =>
                FadeTransition(opacity: animation, child: child),
            child: ListView(
              key: ValueKey<String>(_selectedCategory),
              padding: const EdgeInsets.all(16.0),
              children: [
                Text(_selectedCategory, style: theme.textTheme.titleLarge),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: selectedCategoryOptions.map((option) {
                    final isSelected =
                        _selectedOptions[_selectedCategory]?.contains(option) ??
                        false;
                    return FilterChip(
                      label: Text(option),
                      selected: isSelected,
                      onSelected: (selected) =>
                          _onChipSelected(_selectedCategory, option, selected),
                      selectedColor: theme.primaryColor.withOpacity(0.2),
                      checkmarkColor: theme.primaryColor,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
