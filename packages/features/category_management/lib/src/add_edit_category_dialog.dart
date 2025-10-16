import 'package:category_management/src/category_management_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCategoryDialog extends StatefulWidget {
  final Category? initialCategory;

  const AddCategoryDialog({super.key, this.initialCategory});

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _imageUrlController;
  late final TextEditingController _descriptionController;

  String? _parentId;

  bool _isLoading = false;

  bool get isEditMode => widget.initialCategory != null;

  @override
  void initState() {
    super.initState();
    final category = widget.initialCategory;

    if (category != null) {
      _nameController = TextEditingController(text: category.name);
      _imageUrlController = TextEditingController(text: category.imageUrl);
      _descriptionController = TextEditingController(
        text: category.description,
      );
      _parentId = category.parentId;
    } else {
      _nameController = TextEditingController();
      _imageUrlController = TextEditingController(
        text:
            'https://picsum.photos/seed/${DateTime.now().microsecondsSinceEpoch}/100/100', // Default placeholder
      );
      _descriptionController = TextEditingController();
      _parentId = null;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _imageUrlController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final String? categoryId = isEditMode ? widget.initialCategory!.id : null;

      final categoryToSave = Category(
        id: categoryId, // Pass ID for update, or null for add
        name: _nameController.text.trim(),
        parentId: _parentId,
        imageUrl: _imageUrlController.text.trim(),
        description: _descriptionController.text.trim(),
        // Preserve existing attributes list if editing, or use empty list if adding.
        attributes: isEditMode ? widget.initialCategory!.attributes : const [],
      );

      context.read<CategoryManagementCubit>().upsertCategory(categoryToSave);

      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEditing = isEditMode;
    final titleText = isEditing
        ? 'Edit Product Category'
        : 'Add New Product Category';

    return AlertDialog(
      title: Text(
        titleText,
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      contentPadding: const EdgeInsets.all(24.0),
      actionsPadding: const EdgeInsets.only(right: 24, bottom: 24, top: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Category Name',
                  hintText: 'e.g., Laptops',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a category name' : null,
              ),
              const SizedBox(height: 16),

              BlocBuilder<CategoryManagementCubit, CategoryManagementState>(
                builder: (context, state) {
                  return DropdownButtonFormField<String?>(
                    value: _parentId, // Set the initial/current parent ID
                    decoration: const InputDecoration(
                      labelText: 'Parent Category (Optional)',
                    ),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('None')),
                      ...state.categories
                          .where(
                            (cat) =>
                                !isEditing ||
                                cat.id != widget.initialCategory!.id,
                          ) // **Prevent self-assignment**
                          .map((cat) {
                            return DropdownMenuItem(
                              value: cat.id,
                              child: Text(cat.name),
                            );
                          }),
                    ],
                    onChanged: (String? newValue) {
                      setState(() {
                        _parentId = newValue;
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'Image URL (Placeholder)',
                  hintText: 'https://picsum.photos/100/100',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter an image URL' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'A brief overview of the category content.',
                ),
                maxLines: 3,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a brief description' : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(width: 8),

        _isLoading
            ? PrimaryActionButton.isLoadingProgress()
            : PrimaryActionButton(
                label: isEditing ? 'Update' : 'Save', // Dynamic button label
                isExtended: false,
                onPressed: _saveForm,
              ),
      ],
    );
  }
}
