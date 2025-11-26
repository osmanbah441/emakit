
import 'package:flutter/material.dart';
import 'package:domain_models/domain_models.dart';

class ProductForm extends StatelessWidget {
  final List<ProductCategory> availableCategories;
  final void Function(ProductFormData data) onSubmit;

  const ProductForm({
    super.key,
    required this.availableCategories,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return _ProductInInternal(
      availableCategories: availableCategories,
      onSubmit: onSubmit,
    );
  }
}

class _ProductInInternal extends StatefulWidget {
  final List<ProductCategory> availableCategories;
  final void Function(ProductFormData data) onSubmit;

  const _ProductInInternal({
    required this.availableCategories,
    required this.onSubmit,
  });

  @override
  State<_ProductInInternal> createState() => _ProductInInternalState();
}

class _ProductInInternalState extends State<_ProductInInternal> {
  final _formKey = GlobalKey<FormState>();

  final _nameCtrl = TextEditingController();
  final _manufacturerCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();

  ProductCategory? _selectedCategory;
  final Map<String, TextEditingController> _specControllers = {};
  final Map<String, dynamic> _specValues = {};
  final List<Map<String, TextEditingController>> _customRows = [];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _manufacturerCtrl.dispose();
    _descriptionCtrl.dispose();
    _specControllers.values.forEach((c) => c.dispose());
    for (var r in _customRows) {
      r['attr']?.dispose();
      r['val']?.dispose();
    }
    super.dispose();
  }

  // PRIVATE HELPERS ------------------------------------------------

  void _selectCategory(ProductCategory? category) {
    if (category == _selectedCategory) return;

    _specControllers.values.forEach((c) => c.dispose());
    _specControllers.clear();
    _specValues.clear();

    setState(() {
      _selectedCategory = category;
      if (category != null) {
        for (final f in category.specificationFields) {
          switch (f.dataType) {
            case AttributeDataType.text:
            case AttributeDataType.number:
              _specControllers[f.name] = TextEditingController();
              break;
            case AttributeDataType.dropdown:
              _specValues[f.name] = null;
              break;
            case AttributeDataType.boolean:
              _specValues[f.name] = false;
              break;
            case AttributeDataType.unknown:
              break;
          }
        }
      }
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate() || _selectedCategory == null) return;

    final specs = <String, String>{};

    _specControllers.forEach((k, c) => specs[k] = c.text.trim());
    _specValues.forEach((k, v) {
      if (v != null) specs[k] = v.toString();
    });

    for (final r in _customRows) {
      final k = r['attr']!.text.trim();
      final v = r['val']!.text.trim();
      if (k.isNotEmpty && v.isNotEmpty) specs[k] = v;
    }

    widget.onSubmit(
      ProductFormData(
        name: _nameCtrl.text.trim(),
        manufacturer: _manufacturerCtrl.text.trim(),
        description: _descriptionCtrl.text.trim(),
        categoryId: _selectedCategory!.categoryId,
        specifications: specs,
        variationAttributes: _selectedCategory!.variantFields
      ),
    );
  }

  // UI BUILDERS ----------------------------------------------------

  Widget _buildCategory() => DropdownButtonFormField<ProductCategory>(
        value: _selectedCategory,
        decoration: const InputDecoration(labelText: 'Category'),
        items: widget.availableCategories
            .map((c) => DropdownMenuItem(
                  value: c,
                  child: Text(c.fullPathName),
                ))
            .toList(),
        onChanged: _selectCategory,
        validator: (v) => v == null ? 'Required' : null,
      );

  Widget _buildSpecField(ProductAttributeField f) {
    switch (f.dataType) {
      case AttributeDataType.text:
      case AttributeDataType.number:
        return TextFormField(
          controller: _specControllers[f.name],
          decoration: InputDecoration(labelText: f.name, suffixText: f.unit),
          validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
        );

      case AttributeDataType.dropdown:
        return DropdownButtonFormField<String>(
          decoration: InputDecoration(labelText: f.name),
          value: _specValues[f.name],
          items: (f.options ?? [])
              .map((o) => DropdownMenuItem(value: o, child: Text(o)))
              .toList(),
          onChanged: (v) => setState(() => _specValues[f.name] = v),
          validator: (v) => v == null ? 'Required' : null,
        );

      case AttributeDataType.boolean:
        return Row(
          children: [
            Expanded(child: Text(f.name)),
            Switch(
              value: _specValues[f.name] as bool,
              onChanged: (v) => setState(() => _specValues[f.name] = v),
            ),
          ],
        );

      case AttributeDataType.unknown:
        return const SizedBox.shrink();
    }
  }

  Widget _buildCustomRows() => Column(
        children: [
          ..._customRows.asMap().entries.map((e) {
            final i = e.key;
            final r = e.value;
            return Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: r['attr'],
                  decoration: const InputDecoration(labelText: 'Attribute'),
                )),
                const SizedBox(width: 12),
                Expanded(
                    child: TextFormField(
                  controller: r['val'],
                  decoration: const InputDecoration(labelText: 'Value'),
                )),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    r['attr']?.dispose();
                    r['val']?.dispose();
                    setState(() => _customRows.removeAt(i));
                  },
                )
              ],
            );
          }),
          TextButton(
            onPressed: () => setState(() => _customRows.add({
                  'attr': TextEditingController(),
                  'val': TextEditingController(),
                })),
            child: const Text('Add Custom Spec'),
          ),
        ],
      );

  // BUILD ----------------------------------------------------------

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
            Text('Product Info', style: theme.textTheme.titleMedium),
            const SizedBox(height: 24),

            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Product Name'),
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _manufacturerCtrl,
              decoration: const InputDecoration(labelText: 'Manufacturer'),
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),

            _buildCategory(),
            const SizedBox(height: 16),

            TextFormField(
              controller: _descriptionCtrl,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Description'),
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
            ),

            if (_selectedCategory != null) ...[
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 16),
              Text('Specifications', style: theme.textTheme.titleMedium),
              const SizedBox(height: 12),
              ..._selectedCategory!.specificationFields.map(_buildSpecField),
            ],

            const SizedBox(height: 16),
            _buildCustomRows(),

            const SizedBox(height: 32),
            FilledButton(
              onPressed: _submit,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
