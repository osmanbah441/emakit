import 'package:add_edit_product/src/add_edit_product_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductVariationStep extends StatefulWidget {
  const AddProductVariationStep({super.key});

  @override
  State<AddProductVariationStep> createState() =>
      _AddProductVariationStepState();
}

class _AddProductVariationStepState extends State<AddProductVariationStep> {
  final _formKey = GlobalKey<FormState>();
  final _controllers = <String, TextEditingController>{};
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _selectedImages = <({Uint8List bytes, String mimeType})>[];

  final _maxImages = 6;
  final _minImages = 4;

  late final List<Map<String, dynamic>> _fields;

  @override
  void initState() {
    super.initState();

    final state = context.read<AddEditProductCubit>().state;
    final variation = state.newProductVariation!;

    _fields = state.variationFields;
    _priceController.text = variation.price.toString();
    _stockController.text = variation.stockQuantity.toString();

    for (var field in _fields) {
      final key = field["name"];
      final initialValue = variation.attributes[key]?.toString() ?? '';
      _controllers[key] = TextEditingController(text: initialValue);
    }
  }

  @override
  void dispose() {
    _priceController.dispose();
    _stockController.dispose();
    for (var c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _onImagesSelected(List<({Uint8List bytes, String mimeType})> newImages) {
    setState(() {
      final slots = _maxImages - _selectedImages.length;
      if (slots <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Maximum $_maxImages images selected.')),
        );
        return;
      }

      _selectedImages.addAll(newImages.take(slots));
      if (newImages.length > slots) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Only $_maxImages images allowed.')),
        );
      }
    });
  }

  void _onImageRemoved(({Uint8List bytes, String mimeType}) image) {
    setState(() {
      _selectedImages.remove(image);
    });
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedImages.length < _minImages) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select at least $_minImages images.')),
      );
      return;
    }

    final attributes = <String, dynamic>{};
    for (var field in _fields) {
      final name = field['name'];
      final value = _controllers[name]?.text.trim();
      if (value == null || value.isEmpty) continue;
      attributes[name] = int.tryParse(value) ?? double.tryParse(value) ?? value;
    }

    context.read<AddEditProductCubit>().createProductVariation(
      attributes: attributes,
      images: _selectedImages,
      price: double.tryParse(_priceController.text) ?? 0.0,
      stockQuantity: int.tryParse(_stockController.text) ?? 0,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product Variation Submitted')),
    );
  }

  Widget _buildDynamicField(Map<String, dynamic> field) {
    final name = field["name"];
    final controller = _controllers[name]!;

    if (field["type"] == "list") {
      final options = List<String>.from(field["options"]);
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: DropdownButtonFormField<String>(
          value: controller.text.isNotEmpty ? controller.text : null,
          decoration: InputDecoration(
            labelText: name,
            border: const OutlineInputBorder(),
          ),
          items: options
              .map((opt) => DropdownMenuItem(value: opt, child: Text(opt)))
              .toList(),
          onChanged: (val) => controller.text = val ?? '',
          validator: (val) =>
              val == null || val.isEmpty ? 'Select $name' : null,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: name,
          border: const OutlineInputBorder(),
        ),
        validator: (val) => val == null || val.isEmpty ? 'Enter $name' : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.watch<AddEditProductCubit>().state;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Please fill in the details and upload your best images...",
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  ..._fields.map(_buildDynamicField),

                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _priceController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d{0,2}'),
                            ),
                          ],
                          decoration: const InputDecoration(labelText: 'Price'),
                          validator: (val) =>
                              val == null || val.isEmpty ? 'Enter price' : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _stockController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Stock Quantity',
                            border: OutlineInputBorder(),
                          ),
                          validator: (val) =>
                              val == null || val.isEmpty ? 'Enter stock' : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  MultipleImagesPickerWidget(
                    selectedImages: _selectedImages,
                    onImagesSelected: _onImagesSelected,
                    onImageRemoved: _onImageRemoved,
                    maxImages: _maxImages,
                    minImages: _minImages,
                    pickerTitle:
                        "Upload 4-6 photos of the same item, from different angles.",
                  ),
                ],
              ),
            ),
          ),
        ),
        ButtonActionBar(
          leftLabel: 'Back',
          rightLabel: 'List Product',
          onLeftTap: () => context.read<AddEditProductCubit>().goToStep(
            state.creatingFromExistingProduct != null
                ? AddEditProductStep.similarProducts
                : AddEditProductStep.newProduct,
          ),
          onRightTap: _selectedImages.length < _minImages ? null : _onSubmit,
        ),
      ],
    );
  }
}
