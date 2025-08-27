// product_list_screen.dart

import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:domain_models/domain_models.dart';

class FilterHeaderComponent extends StatelessWidget {
  final String title;
  final ValueChanged<ProductCategory> onCategoryChanged;
  final List<ProductCategory> categories;
  final ProductCategory? activeCategory;

  const FilterHeaderComponent({
    super.key,
    required this.title,
    required this.onCategoryChanged,
    required this.categories,
    this.activeCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        CircularImageSelector<ProductCategory>(
          items: categories,
          selectedLabel: activeCategory?.name,
          onItemChanged: (category) {
            onCategoryChanged(category);
          },
          labelBuilder: (category) => category.name,
          imageBuilder: (category) => category.imageUrl,
        ),
      ],
    );
  }
}
