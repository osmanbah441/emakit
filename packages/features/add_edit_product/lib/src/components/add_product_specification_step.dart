import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:add_edit_product/src/add_edit_product_cubit.dart';
import 'package:component_library/component_library.dart';

class AddProductSpecificationStep extends StatefulWidget {
  const AddProductSpecificationStep({super.key});

  @override
  State<AddProductSpecificationStep> createState() =>
      _AddProductSpecificationStepState();
}

class _AddProductSpecificationStepState
    extends State<AddProductSpecificationStep> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final Map<String, TextEditingController> _specControllers = {};

  AddEditProductCubit get _cubit => context.read<AddEditProductCubit>();

  @override
  void initState() {
    super.initState();
    final p = _cubit.state.extractedProductInfo!.generatedProduct;
    _nameController.text = p.name;
    // _descriptionController.text = p.description;
    // p.specifications.forEach((key, value) {
    //   _specControllers[key] = TextEditingController(text: value.toString());
    // });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    for (final controller in _specControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final specs = <String, dynamic>{};
    _specControllers.forEach((key, controller) {
      final value = controller.text.trim();
      if (value.isEmpty) return;
      specs[key] = int.tryParse(value) ?? double.tryParse(value) ?? value;
    });

    _cubit.createNewProduct(
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      specifications: specs,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => _cubit.goToStep(AddEditProductStep.guideLineImage),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Create New Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: BlocBuilder<AddEditProductCubit, AddEditProductState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 16,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Product Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) => val == null || val.isEmpty
                          ? 'Enter product name'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 5,
                      minLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) => val == null || val.isEmpty
                          ? 'Enter product description'
                          : null,
                    ),

                    for (final entry in _specControllers.entries)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: TextFormField(
                          controller: entry.value,
                          decoration: InputDecoration(
                            labelText: entry.key,
                            border: const OutlineInputBorder(),
                          ),
                          validator: (val) => val == null || val.isEmpty
                              ? 'Enter ${entry.key}'
                              : null,
                        ),
                      ),
                    const SizedBox(height: 2),
                    ProductVariationCard(
                      mode: ProductVariationMode.add,
                      isActive: true,
                      onAddLabelText: 'Validate variation',
                      onAdd: _cubit.verifyVariation,
                      optionalFields:
                          state.extractedProductInfo!.variationDefinationData,
                    ),
                    ExtendedElevatedButton(
                      label: 'Add Product',
                      onPressed:
                          (state.isVariationValid != null &&
                              state.isVariationValid!)
                          ? _handleSubmit
                          : null,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
