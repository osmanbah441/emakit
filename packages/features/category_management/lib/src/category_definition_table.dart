import 'package:category_management/src/category_management_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_edit_category_dialog.dart';
import 'category_attribute_configurator.dart';

class CategoryDefinitionTable extends StatelessWidget {
  const CategoryDefinitionTable({super.key});

  void _showAddCategoryDialog(BuildContext context, [Category? cat]) {
    showDialog(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<CategoryManagementCubit>(),
          child: AddCategoryDialog(initialCategory: cat),
        );
      },
    );
  }

  void _showAttributeConfigurationDialog(
    BuildContext context,
    Category category,
    List<AttributeDefinition> attributes,
  ) {
    print(category.attributes);
    showDialog(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<CategoryManagementCubit>(),
          child: CategoryAttributeConfigurationDialog(
            categoryId: category.id!, // Pass the category you want to configure
            originalAttributes: category.attributes,
            categoryName: category.name,
            availableAttributes: attributes,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headerStyle = theme.textTheme.titleSmall?.copyWith(
      fontWeight: FontWeight.w600,
      color: theme.colorScheme.onSurfaceVariant,
    );

    return BlocBuilder<CategoryManagementCubit, CategoryManagementState>(
      buildWhen: (previous, current) =>
          previous.categories != current.categories,
      builder: (context, state) {
        final categories = state.categories;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            PrimaryActionButton(
              isExtended: false,
              // Call the new, simplified show dialog function
              onPressed: () => _showAddCategoryDialog(context),
              icon: const Icon(Icons.add),
              label: 'Add New Category',
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    width: double.infinity,
                    child: DataTable(
                      headingRowHeight: 48,
                      dataRowMinHeight: 100,
                      dataRowMaxHeight: 100,
                      columns: [
                        DataColumn(label: Text('Image', style: headerStyle)),
                        DataColumn(label: Text('Name', style: headerStyle)),
                        DataColumn(
                          label: Text('Parent Category', style: headerStyle),
                        ),
                        // Retain Actions column for Delete and future Configure/View
                        DataColumn(label: Text('Actions', style: headerStyle)),
                      ],
                      rows: categories.map((cat) {
                        final parentName = cat.parentId != null
                            ? categories
                                  .where((p) => p.id == cat.parentId)
                                  .map((p) => p.name)
                                  .firstOrNull // Use firstOrNull for safer access
                            : 'None';

                        return DataRow(
                          cells: [
                            DataCell(
                              AppNetworkImage(
                                imageUrl: cat.imageUrl,
                                width: 100,
                                height: 80,
                                fit: BoxFit.cover,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            DataCell(Text(cat.name)),
                            DataCell(
                              Text(parentName ?? 'None'),
                            ), // Handle null parent name
                            DataCell(
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.settings_outlined,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      _showAttributeConfigurationDialog(
                                        context,
                                        cat,
                                        state.attributes,
                                      );
                                    },
                                    tooltip: 'Configure Attributes',
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ), // Spacing between icons
                                  // Delete Button
                                  IconButton(
                                    icon: Icon(Icons.edit, size: 20),
                                    onPressed: () =>
                                        _showAddCategoryDialog(context, cat),
                                    tooltip: 'Edit',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
