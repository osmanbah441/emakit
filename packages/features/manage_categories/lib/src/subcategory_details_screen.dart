import 'dart:math';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

enum VariationInputType {
  text,
  list;

  String get label =>
      this == VariationInputType.text ? 'Text Input' : 'Selectable Options';
}

class SubcategoryEditorForm extends StatefulWidget {
  final Category category;
  final void Function(List<Map<String, dynamic>>) onSave;

  const SubcategoryEditorForm({
    super.key,
    required this.category,
    required this.onSave,
  });

  @override
  State<SubcategoryEditorForm> createState() => _SubcategoryEditorFormState();
}

class _SubcategoryEditorFormState extends State<SubcategoryEditorForm> {
  late List<Map<String, dynamic>> variationFields;

  @override
  void initState() {
    super.initState();
    variationFields = List<Map<String, dynamic>>.from(
      widget.category.variationFields ?? [],
    );
  }

  void addField(Map<String, dynamic> field) {
    setState(() => variationFields.add(field));
  }

  void updateField(String id, Map<String, dynamic> updates) {
    final index = variationFields.indexWhere((f) => f['id'] == id);
    if (index != -1) {
      variationFields[index] = {...variationFields[index], ...updates};
    }
    setState(() {});
  }

  void removeField(String id) {
    setState(() => variationFields.removeWhere((f) => f['id'] == id));
  }

  void addOption(String id, String option) {
    final index = variationFields.indexWhere((f) => f['id'] == id);
    if (index != -1) {
      final options = List<String>.from(
        variationFields[index]['options'] ?? [],
      );
      if (!options.contains(option)) {
        options.add(option);
        updateField(id, {'options': options});
      }
    }
  }

  void removeOption(String id, String option) {
    final index = variationFields.indexWhere((f) => f['id'] == id);
    if (index != -1) {
      final options = List<String>.from(
        variationFields[index]['options'] ?? [],
      );
      options.remove(option);
      updateField(id, {'options': options});
    }
  }

  void showAddFieldDialog() {
    showDialog(
      context: context,
      builder: (_) => _AddFieldDialog(onAdd: (field) => addField(field)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Subcategory')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Variation Fields',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              ElevatedButton.icon(
                onPressed: showAddFieldDialog,
                icon: const Icon(Icons.add),
                label: const Text('Add Field'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (variationFields.isEmpty)
            const Text('No fields added yet.')
          else
            ...variationFields.map(
              (field) => _VariationFieldTile(
                field: field,
                onRemove: () => removeField(field['id']),
                onAddOption: (opt) => addOption(field['id'], opt),
                onRemoveOption: (opt) => removeOption(field['id'], opt),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton.icon(
          icon: const Icon(Icons.save),
          label: const Text('Save'),
          onPressed: () {
            widget.onSave(variationFields);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

// ───────────────────────────── COMPONENTS ─────────────────────────────

class _AddFieldDialog extends StatefulWidget {
  final void Function(Map<String, dynamic>) onAdd;

  const _AddFieldDialog({required this.onAdd});

  @override
  State<_AddFieldDialog> createState() => _AddFieldDialogState();
}

class _AddFieldDialogState extends State<_AddFieldDialog> {
  final TextEditingController nameController = TextEditingController();
  VariationInputType selectedType = VariationInputType.text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Field'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Field Name'),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<VariationInputType>(
            value: selectedType,
            items: VariationInputType.values
                .map((e) => DropdownMenuItem(value: e, child: Text(e.label)))
                .toList(),
            onChanged: (val) =>
                setState(() => selectedType = val ?? VariationInputType.text),
            decoration: const InputDecoration(labelText: 'Input Type'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final name = nameController.text.trim();
            if (name.isNotEmpty) {
              widget.onAdd({
                'id':
                    '${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(999)}',
                'name': name,
                'type': selectedType.name,
                'options': <String>[],
              });
              Navigator.pop(context);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

class _VariationFieldTile extends StatelessWidget {
  final Map<String, dynamic> field;
  final VoidCallback onRemove;
  final void Function(String) onAddOption;
  final void Function(String) onRemoveOption;

  const _VariationFieldTile({
    required this.field,
    required this.onRemove,
    required this.onAddOption,
    required this.onRemoveOption,
  });

  @override
  Widget build(BuildContext context) {
    final isList = field['type'] == VariationInputType.list.name;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ExpansionTile(
        title: Text(field['name']),
        subtitle: Text(isList ? 'Selectable Options' : 'Text Input'),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: onRemove,
        ),
        children: [
          if (isList)
            Padding(
              padding: const EdgeInsets.all(16),
              child: _OptionListEditor(
                options: List<String>.from(field['options'] ?? []),
                onAdd: onAddOption,
                onRemove: onRemoveOption,
              ),
            ),
        ],
      ),
    );
  }
}

class _OptionListEditor extends StatefulWidget {
  final List<String> options;
  final void Function(String) onAdd;
  final void Function(String) onRemove;

  const _OptionListEditor({
    required this.options,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  State<_OptionListEditor> createState() => _OptionListEditorState();
}

class _OptionListEditorState extends State<_OptionListEditor> {
  final TextEditingController controller = TextEditingController();

  void submit() {
    final text = controller.text.trim();
    if (text.isNotEmpty) {
      widget.onAdd(text);
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.options
              .map(
                (opt) => InputChip(
                  label: Text(opt),
                  onDeleted: () => widget.onRemove(opt),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(hintText: 'Add option'),
                onSubmitted: (_) => submit(),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: submit,
            ),
          ],
        ),
      ],
    );
  }
}
