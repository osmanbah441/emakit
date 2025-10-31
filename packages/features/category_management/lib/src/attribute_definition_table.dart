import 'package:category_management/src/add_edit_attribute_dialog.dart';
import 'package:category_management/src/category_management_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:domain_models/src/attribute_data_type.dart';
import 'package:domain_models/src/attribute_definition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttributeDefinitionTable extends StatelessWidget {
  const AttributeDefinitionTable({super.key});

  void _showAddAttributeDialog(
    BuildContext context, [
    AttributeDefinition? attr,
  ]) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<CategoryManagementCubit>(),

        child: AddAttributeDialog(initialAttribute: attr),
      ),
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
          previous.attributes != current.attributes,
      builder: (context, state) {
        final attributes = state.attributes;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            PrimaryActionButton(
              isExtended: false,
              onPressed: () => _showAddAttributeDialog(context),
              icon: const Icon(Icons.add),
              label: 'Add New Attribute',
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
                      columns: [
                        DataColumn(
                          label: Text('Attribute Name', style: headerStyle),
                        ),
                        DataColumn(
                          label: Text('Data Type', style: headerStyle),
                        ),
                        DataColumn(label: Text('Unit', style: headerStyle)),
                        DataColumn(
                          label: Text('Option Values', style: headerStyle),
                        ),
                        DataColumn(label: Text('Actions', style: headerStyle)),
                      ],
                      rows: attributes.map((attr) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                attr.name,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            DataCell(Text(attr.dataType.displayString)),
                            DataCell(
                              Text(
                                (attr.unit == null || attr.unit!.isEmpty)
                                    ? '-'
                                    : attr.unit!,
                              ),
                            ),
                            DataCell(
                              attr.dataType == AttributeDataType.dropdown
                                  ? Text('(${attr.options?.length ?? 0})')
                                  : const Text('-'),
                            ),
                            DataCell(
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit, size: 20),
                                    onPressed: () =>
                                        _showAddAttributeDialog(context, attr),
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
