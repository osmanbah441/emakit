import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class SpecificationSection extends StatelessWidget {
  const SpecificationSection({
    super.key,
    required this.description,
    this.specifications = const {},
  });

  final Map<String, dynamic> specifications;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        Text(
          'Product Details',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),

        Text(description),
        ...specifications.keys.toList().map((key) {
          return TextRowComponent(
            label: key,
            value: specifications[key].toString(),
          );
        }),
      ],
    );
  }
}
