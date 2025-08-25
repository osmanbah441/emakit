import 'package:flutter/material.dart';

import 'filter_panel_component.dart';

class FilterPage extends StatefulWidget {
  final Map<String, List<String>> filterData;
  final Map<String, Set<String>> activeFilters;

  const FilterPage({
    super.key,
    required this.activeFilters,
    required this.filterData,
  });

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  late Map<String, Set<String>> _currentSelections;

  @override
  void initState() {
    super.initState();
    _currentSelections = widget.activeFilters.map(
      (key, value) => MapEntry(key, Set.from(value)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FilterPanelComponent(
        filterData: widget.filterData,
        activeFilters: _currentSelections,
        onFiltersChanged: (newFilters) {
          setState(() {
            _currentSelections = newFilters;
          });
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(
          16.0,
        ).copyWith(bottom: MediaQuery.of(context).padding.bottom + 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() => _currentSelections.clear()),
                child: const Text('Clear Filters'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(_currentSelections),
                child: const Text('Show Results'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
