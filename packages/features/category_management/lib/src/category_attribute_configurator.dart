import 'package:flutter/material.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_management_cubit.dart';

class CategoryAttributeConfigurationDialog extends StatefulWidget {
  final String categoryId;
  final String categoryName;
  final List<LinkCategoryToAtrributes> originalAttributes;
  final List<AttributeDefinition> availableAttributes;

  const CategoryAttributeConfigurationDialog({
    super.key,
    required this.categoryId,
    required this.categoryName,
    required this.originalAttributes,
    required this.availableAttributes,
  });

  @override
  State<CategoryAttributeConfigurationDialog> createState() =>
      _CategoryAttributeConfigurationDialogState();
}

class _CategoryAttributeConfigurationDialogState
    extends State<CategoryAttributeConfigurationDialog> {
  late List<LinkCategoryToAtrributes> _configuredAttributes;
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _configuredAttributes = List.from(widget.originalAttributes);
  }

  bool _hasChanges() {
    final current = _configuredAttributes
        .where((config) => config.attributeId.isNotEmpty)
        .toList();

    final original = widget.originalAttributes
        .where((config) => config.attributeId.isNotEmpty)
        .toList();

    if (current.length != original.length) return true;

    Set<String> serializeList(List<LinkCategoryToAtrributes> list) {
      return list
          .map((c) => '${c.attributeId}:${c.isRequired}:${c.isVariant}')
          .toSet();
    }

    final currentSet = serializeList(current);
    final originalSet = serializeList(original);

    return currentSet.length != originalSet.length ||
        !currentSet.containsAll(originalSet);
  }

  void _addAttribute() {
    setState(() {
      _configuredAttributes.add(
        LinkCategoryToAtrributes(
          attributeId: '',
          attributeName: '',
          isRequired: false,
          isVariant: false,
        ),
      );
    });
  }

  void _deleteAttribute(int index) {
    setState(() => _configuredAttributes.removeAt(index));
  }

  void _updateAttribute(int index, {String? attributeId}) {
    final old = _configuredAttributes[index];
    setState(() {
      _configuredAttributes[index] = LinkCategoryToAtrributes(
        attributeId: attributeId ?? old.attributeId,
        attributeName: old.attributeName,
        dataType: old.dataType,
        isRequired: old.isRequired,
        isVariant: old.isVariant,
      );
    });
  }

  void _toggleProperty(int index, {bool? required, bool? variant}) {
    final old = _configuredAttributes[index];
    setState(() {
      _configuredAttributes[index] = LinkCategoryToAtrributes(
        attributeId: old.attributeId,
        attributeName: old.attributeName,
        dataType: old.dataType,
        isRequired: required ?? old.isRequired,
        isVariant: variant ?? old.isVariant,
      );
    });
  }

  // --- VALIDATION & SAVE ---

  bool _validateForm() {
    final usedIds = <String>{};
    for (final config in _configuredAttributes) {
      if (config.attributeId.isEmpty) {
        _showSnack('Please select an attribute for all rows.');
        return false;
      }
      if (usedIds.contains(config.attributeId)) {
        _showSnack('Duplicate attributes are not allowed.');
        return false;
      }
      usedIds.add(config.attributeId);
    }
    return true;
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: const Duration(seconds: 2)),
    );
  }

  Future<void> _saveConfiguration() async {
    if (!_validateForm()) return;

    setState(() => _saving = true);

    final validAttributes = _configuredAttributes
        .where((config) => config.attributeId.isNotEmpty)
        .toList();

    try {
      // Call the cubit. Some implementations return Future, others void.
      final res = context
          .read<CategoryManagementCubit>()
          .linkCategoryToAttributes(widget.categoryId, validAttributes);

      res;

      if (mounted) {
        _showSnack('Attributes saved successfully.');
        Navigator.of(context).pop(true);
      }
    } catch (e, st) {
      debugPrint('Error saving attributes: $e\n$st');
      _showSnack('Failed to save attributes.');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  // --- UI ---

  Widget _buildAttributeRow(LinkCategoryToAtrributes config, int index) {
    final usedIds = _configuredAttributes
        .where((c) => c != config)
        .map((c) => c.attributeId)
        .toSet();

    final availableDefinitions = widget.availableAttributes
        .where((def) => !usedIds.contains(def.id))
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              // use the stored attributeId (or null) as the value
              initialValue: config.attributeId.isNotEmpty
                  ? config.attributeId
                  : null,
              decoration: const InputDecoration(
                labelText: 'Attribute',
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(
                  value: '',
                  child: Text('Select Attribute'),
                ),
                ...availableDefinitions.map(
                  (def) =>
                      DropdownMenuItem(value: def.id, child: Text(def.name)),
                ),
              ],
              onChanged: (val) =>
                  _updateAttribute(index, attributeId: val ?? ''),
              validator: (val) =>
                  (val == null || val.isEmpty) ? 'Please select one' : null,
            ),
          ),
          const SizedBox(width: 12),
          Row(
            children: [
              Checkbox(
                value: config.isRequired,
                onChanged: (val) => _toggleProperty(index, required: val),
              ),
              const Text('Required'),
              const SizedBox(width: 8),
              Checkbox(
                value: config.isVariant,
                onChanged: (val) => _toggleProperty(index, variant: val),
              ),
              const Text('Variant'),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () => _deleteAttribute(index),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMax =
        _configuredAttributes.length >= widget.availableAttributes.length;
    final changesMade = _hasChanges();

    return AlertDialog(
      title: Text('Configure Attributes for: ${widget.categoryName}'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (int i = 0; i < _configuredAttributes.length; i++)
                _buildAttributeRow(_configuredAttributes[i], i),
            ],
          ),
        ),
      ),
      actions: [
        TextButton.icon(
          onPressed: isMax ? null : _addAttribute,
          icon: const Icon(Icons.add),
          label: const Text('Add Attribute'),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: _saving ? null : () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: (!_saving && changesMade) ? _saveConfiguration : null,
              child: _saving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save Configuration'),
            ),
          ],
        ),
      ],
    );
  }
}
