// product_list_screen.dart

import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:domain_models/domain_models.dart';

class FilterHeaderComponent extends StatelessWidget {
  // final String title;
  final ValueChanged<Category> onCategoryChanged;
  final List<Category> categories;
  final Category? activeCategory;

  const FilterHeaderComponent({
    super.key,
    // required this.title,
    required this.onCategoryChanged,
    required this.categories,
    this.activeCategory,
  });

  @override
  Widget build(BuildContext context) {
    return CircularImageSelector<Category>(
      items: categories,
      selectedLabel: activeCategory?.name,
      onItemChanged: (category) {
        onCategoryChanged(category);
      },
      labelBuilder: (category) => category.name,
      imageBuilder: (category) => category.imageUrl,
    );
  }
}
