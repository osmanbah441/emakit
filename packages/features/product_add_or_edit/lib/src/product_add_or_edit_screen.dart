import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:component_library/component_library.dart';
import 'package:product_add_or_edit/src/product_add_or_edit_cubit.dart';
import 'package:product_add_or_edit/src/product_add_or_edit_state.dart';

import 'components/components.dart';

class ProductAddOrEditScreen extends StatelessWidget {
  const ProductAddOrEditScreen({
    super.key,
    this.productIdToEdit,
    required this.onSaveSuccess,
  });

  final String? productIdToEdit;
  final VoidCallback onSaveSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductAddOrEditCubit(productIdToEdit: productIdToEdit),
      child: ProductAddOrEditView(onSaveSuccess: onSaveSuccess),
    );
  }
}

class ProductAddOrEditView extends StatelessWidget {
  const ProductAddOrEditView({super.key, required this.onSaveSuccess});
  final VoidCallback onSaveSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductAddOrEditCubit, ProductAddOrEditState>(
      listener: (context, state) {
        if (state is ProductAddOrEditSuccess) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          } else if (state.saveCompleted && !state.isLoading) {
            final message = state.isEditMode
                ? 'Product updated successfully!'
                : 'Product added successfully!';
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
            onSaveSuccess();
          }
        }
      },
      builder: (context, state) {
        if (state is ProductAddOrEditLoading) {
          return const Scaffold(body: CenteredProgressIndicator());
        }

        if (state is ProductAddOrEditError) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text('Error loading data: ${state.message}'),
              ),
            ),
          );
        }

        if (state is ProductAddOrEditSuccess) {
          return _Success(
            state: state,
            cubit: context.read<ProductAddOrEditCubit>(),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _Success extends StatefulWidget {
  const _Success({required this.state, required this.cubit});

  final ProductAddOrEditSuccess state;
  final ProductAddOrEditCubit cubit;

  @override
  State<_Success> createState() => _SuccessState();
}

class _SuccessState extends State<_Success> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  final _detailsFormKey = GlobalKey<FormState>();

  final _specFormKey = GlobalKey<FormState>();

  Map<String, dynamic>? _specifications;
  final List<ProductMedia> _mediaList = [];

  void _onMediaAdded(ProductMedia media) => _mediaList.add(media);
  void _onMediaRemoved(ProductMedia media) => _mediaList.remove(media);

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.state.productToEdit?.name ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.state.productToEdit?.description ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    final hasSelectedCategory = widget.state.selectedCategory != null;
    final isDetailsValid = _detailsFormKey.currentState?.validate() ?? false;

    // ✅ Validate DynamicSpecForm
    final isSpecValid = _specFormKey.currentState?.validate() ?? true;

    if (!isDetailsValid || !isSpecValid || !hasSelectedCategory) {
      // Optional: show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields.')),
      );
      return;
    }

    await widget.cubit.upsertProduct(
      imageUrls: _mediaList,
      name: _nameController.text,
      description: _descriptionController.text,
      specs: _specifications,
      categoryId: widget.state.selectedCategory!.id!,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;

    return Scaffold(
      appBar: AppBar(
        title: Text(state.isEditMode ? 'Edit Product' : 'Add New Product'),
        actions: [
          IconButton(
            icon: state.isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save),
            onPressed: state.isLoading ? null : _handleSave,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: 100,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: ProductBasicInformationForm(
                    nameController: _nameController,
                    descriptionController: _descriptionController,
                    detailsFormKey: _detailsFormKey,
                    onCategorySelected: widget.cubit.onCategorySelected,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 2,
                  child: ProductSpecificationForm(
                    onChanged: (newSpecs) => _specifications = newSpecs,
                    specFormKey: _specFormKey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ProductMediaInput(
              onMediaAdded: _onMediaAdded,
              onMediaRemoved: _onMediaRemoved,
            ),
          ],
        ),
      ),
    );
  }
}
