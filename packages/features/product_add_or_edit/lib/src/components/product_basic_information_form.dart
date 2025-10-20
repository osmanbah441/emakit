import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_add_or_edit/src/product_add_or_edit_cubit.dart';

import '../product_add_or_edit_state.dart';

class ProductBasicInformationForm extends StatelessWidget {
  const ProductBasicInformationForm({
    super.key,
    required this.nameController,
    required this.descriptionController,
    required this.detailsFormKey,
    required this.onCategorySelected,
  });

  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final GlobalKey<FormState> detailsFormKey;
  final Function(Category?)? onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: detailsFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Basic Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(height: 30),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Product name is required' : null,
              ),
              const SizedBox(height: 16),
              BlocBuilder<ProductAddOrEditCubit, ProductAddOrEditState>(
                builder: (context, state) {
                  state as ProductAddOrEditSuccess;
                  return DropdownButtonFormField<Category>(
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                    items: state.allCategories
                        .map(
                          (c) =>
                              DropdownMenuItem(value: c, child: Text(c.name)),
                        )
                        .toList(),
                    onChanged: onCategorySelected,
                    validator: (v) =>
                        v == null ? 'Category selection is required' : null,
                  );
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator: (v) => v == null || v.length < 20
                    ? 'Description must be at least 20 characters'
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
