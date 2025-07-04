import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddOrEditCategoryDialog extends StatefulWidget {
  const AddOrEditCategoryDialog({
    super.key,
    this.parentId,
    this.category,
    required this.onSave,
  });

  final Category? category;
  final String? parentId;
  final Future<void> Function(Category category) onSave;

  @override
  State<AddOrEditCategoryDialog> createState() =>
      _AddOrEditCategoryDialogState();
}

class _AddOrEditCategoryDialogState extends State<AddOrEditCategoryDialog> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ({Uint8List bytes, String mimeType})? _imageBytes;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      _nameController.text = widget.category!.name;
      _descriptionController.text = widget.category!.description;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim();

    final categoryToSave = Category(
      id: widget.category?.id,
      name: name,
      description: description.isNotEmpty ? description : '',
      parentId: widget.parentId ?? widget.category?.parentId,
    );

    try {
      await widget.onSave(categoryToSave);

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to save category: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.category != null
            ? 'Edit Category'
            : (widget.parentId == null
                  ? 'Add Main Category'
                  : 'Add Subcategory'),
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            spacing: 16,
            children: [
              SingleImagePickerWidget(
                initialImage: _imageBytes,
                onImagePicked: (e) {
                  setState(() {
                    _imageBytes = e;
                  });
                },
                onImageRemoved: () {
                  setState(() {
                    _imageBytes = null;
                  });
                },
                height: 128,
                width: 128,
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Category Name',
                  hintText: 'e.g., "Electronics"',
                ),
                autofocus: true,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Name is required'
                    : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (Optional)',
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _onSubmit,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(widget.category != null ? 'Save' : 'Add'),
        ),
      ],
    );
  }
}
