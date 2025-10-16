import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';
import 'package:image_picker/image_picker.dart';
import 'package:domain_models/domain_models.dart';
import 'package:category_repository/category_repository.dart';

class ProductAddImageSearchScreen extends StatelessWidget {
  const ProductAddImageSearchScreen({super.key, required this.onAddNewProduct});
  final Function(XFile, Category) onAddNewProduct;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _PickImageView(onAddNewProduct: onAddNewProduct),
    );
  }
}

class _PickImageView extends StatefulWidget {
  const _PickImageView({required this.onAddNewProduct});

  final Function(XFile, Category) onAddNewProduct;

  @override
  State<_PickImageView> createState() => _PickImageViewState();
}

class _PickImageViewState extends State<_PickImageView> {
  XFile? _image;
  Uint8List? _imageBytes;
  Category? _category;

  void _onSubmit() {
    if (_image != null && _category != null) {
      widget.onAddNewProduct(_image!, _category!);
      return;
    }
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('Please provider both image and category')),
      );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final bytes = await pickedFile.readAsBytes();
    setState(() {
      _image = pickedFile;
      _imageBytes = bytes;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder(
      future: CategoryRepository.instance.getAll(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasError) return ExceptionIndicator();
            final data = snapshot.data ?? [];

            if (data.isEmpty) {
              return Center(child: Text('No categories found'));
            }

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Showcase Your Product',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Upload a high-quality photo to attract buyers.',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                      const SizedBox(height: 8),

                      ImagePickerComponent(
                        initialImage: _imageBytes,
                        onImageSelected: _pickImage,
                        hintText: 'Tap to upload product image',
                      ),
                      const SizedBox(height: 24),

                      Text('Category', style: theme.textTheme.titleMedium),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<Category>(
                        initialValue: _category,
                        hint: Text('Select Category'),
                        items: data
                            .map(
                              (e) => DropdownMenuItem<Category>(
                                value: e,
                                child: Text(e.name),
                              ),
                            )
                            .toList(),
                        onChanged: (val) {
                          setState(() => _category = val);
                        },
                      ),

                      const Spacer(),
                      PrimaryActionButton(
                        icon: const Icon(Icons.add),
                        label: 'Create Product',
                        onPressed: _onSubmit,
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            );

          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const CenteredProgressIndicator();
        }
      },
    );
  }
}
