import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:component_library/component_library.dart';
import 'cubit.dart';
import 'package:domain_models/domain_models.dart';

// Note: The Category model is now ProductCategory
// The Attribute model is now ProductAttributeField
// The list of available categories should now be List<ProductCategory>

class ProductInfoForm extends StatefulWidget {
  final List<ProductCategory> availableCategories;

  const ProductInfoForm({super.key, required this.availableCategories});

  @override
  State<ProductInfoForm> createState() => _ProductInfoFormState();
}

class _ProductInfoFormState extends State<ProductInfoForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _manufacturerController;
  late final TextEditingController _descriptionController;

  // Change Category? to ProductCategory?
  ProductCategory? _selectedCategory;

  // Use ProductAttributeField as the key to associate controllers/values with the attribute field
  // For simplicity and consistency in this form, we'll keep using the attribute name as the key,
  // but the logic for managing fields changes based on the data type.
  final Map<String, TextEditingController> _requiredSpecControllers = {};
  // For Dropdown fields, we'll manage the selected value separately as a String or bool (for boolean)
  final Map<String, dynamic> _requiredSpecValues = {};

  final List<Map<String, TextEditingController>> _customRows = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _manufacturerController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _manufacturerController.dispose();
    _descriptionController.dispose();

    for (var c in _requiredSpecControllers.values) {
      c.dispose();
    }

    for (var row in _customRows) {
      row['attr']?.dispose();
      row['val']?.dispose();
    }

    super.dispose();
  }

  // Change Category? to ProductCategory?
  void _onCategoryChanged(ProductCategory? newCategory) {
    if (newCategory == _selectedCategory) return;

    // Dispose and clear old controllers
    for (var c in _requiredSpecControllers.values) {
      c.dispose();
    }
    _requiredSpecControllers.clear();
    _requiredSpecValues.clear();

    setState(() {
      _selectedCategory = newCategory;

      if (newCategory != null) {
        // Iterate over specificationFields
        for (final attribute in newCategory.specificationFields) {
          final key = attribute.name;
          switch (attribute.dataType) {
            case AttributeDataType.text:
            case AttributeDataType.number:
              _requiredSpecControllers[key] = TextEditingController();
              break;
            case AttributeDataType.dropdown:
              // Initialize dropdown value to null or the first option
              _requiredSpecValues[key] = null;
              break;
            case AttributeDataType.boolean:
              // Initialize boolean value to false
              _requiredSpecValues[key] = false;
              break;
            case AttributeDataType.unknown:
              // Optionally handle unknown types
              break;
          }
        }
      }
    });
  }

  void _addCustomRow() {
    setState(() {
      _customRows.add({
        'attr': TextEditingController(),
        'val': TextEditingController(),
      });
    });
  }

  void _removeCustomRow(int index) {
    final row = _customRows.removeAt(index);
    row['attr']?.dispose();
    row['val']?.dispose();
    setState(() {});
  }

  void _validateAndSubmit() {
    // Check if the form is valid (TextFormFields) AND a category is selected.
    if (_formKey.currentState!.validate() && _selectedCategory != null) {
      final Map<String, String> specs = {};

      // 1. Collect specs from required Text/Number fields
      _requiredSpecControllers.forEach((key, controller) {
        specs[key] = controller.text.trim();
      });

      // 2. Collect specs from required Dropdown/Boolean fields
      _requiredSpecValues.forEach((key, value) {
        // Dropdown/Boolean fields must have a selected value
        if (value != null) {
          specs[key] = value.toString();
        }
      });

      // Ensure all required fields have a value (especially for Dropdown/Boolean which don't use TextFormField validator)
      final allRequiredSpecs = _selectedCategory!.specificationFields;
      for (final attribute in allRequiredSpecs) {
        final specValue = specs[attribute.name];
        if (specValue == null || specValue.isEmpty) {
          // You might want to show an error for the missing required field here,
          // but for now, we'll rely on the UI validators for text fields
          // and the dropdown/checkbox UI logic to guide the user.
          if (attribute.dataType == AttributeDataType.dropdown ||
              attribute.dataType == AttributeDataType.boolean) {
            // For simplicity, we just return here. A proper UI error message should be implemented.
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${attribute.name} is required.'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
            return;
          }
        }
      }

      // 3. Collect specs from custom fields
      for (var row in _customRows) {
        final attr = row['attr']!.text.trim();
        final val = row['val']!.text.trim();
        if (attr.isNotEmpty && val.isNotEmpty) {
          specs[attr] = val;
        }
      }

      context.read<ProductAddVariationCubit>().setProductFields(
        name: _nameController.text.trim(),
        manufacturer: _manufacturerController.text.trim(),
        categoryId: _selectedCategory!.categoryId,
        description: _descriptionController.text.trim(),
        specs: specs,
      );
    }
  }

  Widget _buildCategoryDropdown() {
    // Change DropdownButtonFormField<Category> to DropdownButtonFormField<ProductCategory>
    return DropdownButtonFormField<ProductCategory>(
      decoration: const InputDecoration(labelText: 'Category'),
      value: _selectedCategory,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      // Change the list mapping to use ProductCategory properties
      items: widget.availableCategories
          .map(
            (c) => DropdownMenuItem(value: c, child: Text(c.fullPathName)),
          ) // Use fullPathName for display
          .toList(),
      onChanged: _onCategoryChanged,
      validator: (v) => v == null ? 'Please select a category' : null,
    );
  }

  // New widget builder for a single required specification field
  Widget _buildRequiredSpecField(ProductAttributeField attribute) {
    final key = attribute.name;
    final unit = attribute.unit;
    // All specificationFields are treated as required here

    switch (attribute.dataType) {
      case AttributeDataType.text:
      case AttributeDataType.number:
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: TextFormField(
            controller: _requiredSpecControllers[key],
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
            keyboardType: attribute.dataType == AttributeDataType.number
                ? TextInputType.number
                : TextInputType.text,
            decoration: InputDecoration(labelText: key, suffixText: unit),
            validator: (v) =>
                v == null || v.trim().isEmpty ? '$key is required' : null,
          ),
        );

      case AttributeDataType.dropdown:
        final options = attribute.options ?? [];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: key),
            value: _requiredSpecValues[key] as String?,
            items: options
                .map((opt) => DropdownMenuItem(value: opt, child: Text(opt)))
                .toList(),
            onChanged: (newValue) {
              setState(() {
                _requiredSpecValues[key] = newValue;
              });
            },
            validator: (v) => v == null ? '$key is required' : null,
          ),
        );

      case AttributeDataType.boolean:
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              Text(key),
              const Spacer(),
              Switch(
                value: _requiredSpecValues[key] as bool,
                onChanged: (newValue) {
                  setState(() {
                    _requiredSpecValues[key] = newValue;
                  });
                },
              ),
            ],
          ),
        );

      case AttributeDataType.unknown:
        return const SizedBox.shrink(); // Hide unknown types
    }
  }

  Widget _buildRequiredSpecsSection(ThemeData theme) {
    // Check for specificationFields
    if (_selectedCategory == null ||
        _selectedCategory!.specificationFields.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        const Divider(),
        const SizedBox(height: 24),
        Text(
          'Required Specifications',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        // Map over specificationFields to build the appropriate input field
        ..._selectedCategory!.specificationFields.map((attribute) {
          return _buildRequiredSpecField(attribute);
        }),
      ],
    );
  }

  Widget _buildCustomSpecRow(
    int index,
    Map<String, TextEditingController> row,
    ThemeData theme,
  ) {
    // ... (This section remains largely the same as it handles custom user input)
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: TextFormField(
              controller: row['attr'],
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(labelText: 'Attribute'),
              validator: (v) {
                if (row['val']!.text.isNotEmpty &&
                    (v == null || v.trim().isEmpty)) {
                  return 'Required';
                }
                return null;
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: TextFormField(
              controller: row['val'],
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(labelText: 'Value'),
              validator: (v) {
                if (row['attr']!.text.isNotEmpty &&
                    (v == null || v.trim().isEmpty)) {
                  return 'Required';
                }
                return null;
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _removeCustomRow(index),
            color: theme.colorScheme.error,
          ),
        ],
      ),
    );
  }

  Widget _buildCustomSpecsSection(ThemeData theme) {
    // ... (This section remains the same)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_customRows.isNotEmpty) ...[
          // Removed unnecessary map.entries, directly map the list
          ..._customRows.asMap().entries.map((entry) {
            final index = entry.key;
            final row = entry.value;
            return _buildCustomSpecRow(index, row, theme);
          }),
        ],
        TextButton(
          onPressed: _addCustomRow,
          child: const Text('Add Custom Specification'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Information',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _nameController,
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(labelText: 'Product Name'),
              validator: (v) {
                if (v == null || v.trim().isEmpty)
                  return 'Product name is required';
                if (v.length < 3) return 'Name must be at least 3 characters';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _manufacturerController,
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(labelText: 'Manufacturer'),
              validator: (v) => v == null || v.trim().isEmpty
                  ? 'Manufacturer is required'
                  : null,
            ),
            const SizedBox(height: 16),
            _buildCategoryDropdown(),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              maxLines: 4,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(labelText: 'Description'),
              validator: (v) {
                if (v == null || v.trim().isEmpty)
                  return 'Description is required';
                if (v.length < 10) return 'Description is too short';
                return null;
              },
            ),
            _buildRequiredSpecsSection(theme),
            _buildCustomSpecsSection(theme),
            const SizedBox(height: 32),
            PrimaryActionButton(
              label: 'Continue',
              onPressed: _validateAndSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
