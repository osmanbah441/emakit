import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_add_or_edit/src/product_add_or_edit_cubit.dart';
import 'package:product_add_or_edit/src/product_add_or_edit_state.dart';

import 'dynamic_specs_form.dart';

class ProductSpecificationForm extends StatelessWidget {
  const ProductSpecificationForm({
    super.key,
    required this.onChanged,
    required this.specFormKey,
  });

  final void Function(Map<String, dynamic>?) onChanged;
  final GlobalKey<FormState> specFormKey;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: BlocBuilder<ProductAddOrEditCubit, ProductAddOrEditState>(
          builder: (context, state) {
            state as ProductAddOrEditSuccess;

            final showDynamicForm = state.selectedCategory != null;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dynamic Specifications & Variants',
                  style: theme.textTheme.titleLarge,
                ),
                const Divider(height: 30),
                if (showDynamicForm)
                  DynamicSpecForm(formKey: specFormKey, onChanged: onChanged)
                else
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        'Select a category to load its specifications.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                const SizedBox(height: 30),
                Text('Category Variations', style: theme.textTheme.titleMedium),
                const Divider(),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children:
                      state.selectedCategory?.attributes
                          .where((link) => link.isVariant)
                          .map((link) => Chip(label: Text(link.attributeName)))
                          .toList() ??
                      [],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
