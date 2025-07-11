import 'package:add_edit_product/src/add_edit_product_cubit.dart';
import 'package:component_library/component_library.dart';
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

  final _priceController = TextEditingController();
  final _stockController = TextEditingController();

  final _selectedImages = <({Uint8List bytes, String mimeType})>[];

  static const int _maxImages = 6;
  static const int _minImages = 4;

  late final Map<String, List<String>> _fields;
  final Map<String, String?> _selectedOptions = {};

  @override
  void initState() {
    super.initState();
    final state = context.read<AddEditProductCubit>().state;

    _fields = Map<String, List<String>>.from(state.variationFields);

    for (final name in _fields.keys) {
      _selectedOptions[name] = null; // Null means no selection yet
    }

    final variation = state.newProductVariation;
    _priceController.text = variation?.price.toString() ?? '';
    _stockController.text = variation?.stockQuantity.toString() ?? '';
  }

  @override
  void dispose() {
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  void _onImagesSelected(List<({Uint8List bytes, String mimeType})> newImages) {
    setState(() {
      final slots = _maxImages - _selectedImages.length;
      if (slots <= 0) return;

      _selectedImages.addAll(newImages.take(slots));
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

    final incomplete = _selectedOptions.entries.any(
      (e) => e.value == null || e.value!.isEmpty,
    );
    if (incomplete) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select all variation options.')),
      );
      return;
    }

    context.read<AddEditProductCubit>().createProductVariation(
      attributes: _selectedOptions.map((k, v) => MapEntry(k, v!)),
      images: _selectedImages,
      price: double.tryParse(_priceController.text) ?? 0.0,
      stockQuantity: int.tryParse(_stockController.text) ?? 0,
    );
  }

  Widget _buildDropdownField(String fieldName, List<String> options) {
    return DropdownButtonFormField<String>(
      value: _selectedOptions[fieldName],
      items: options
          .map((opt) => DropdownMenuItem<String>(value: opt, child: Text(opt)))
          .toList(),
      decoration: InputDecoration(
        labelText: fieldName,
        border: const OutlineInputBorder(),
      ),
      validator: (val) =>
          val == null || val.isEmpty ? 'Please select $fieldName' : null,
      onChanged: (val) {
        setState(() {
          _selectedOptions[fieldName] = val;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AddEditProductCubit>().state;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select variation options and fill in details.",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  ..._fields.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildDropdownField(entry.key, entry.value),
                    );
                  }),
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
                          decoration: const InputDecoration(
                            labelText: 'Price',
                            border: OutlineInputBorder(),
                          ),
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
                    pickerTitle: "Upload 4-6 images.",
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
          onRightTap: _onSubmit,
        ),
      ],
    );
  }
}
