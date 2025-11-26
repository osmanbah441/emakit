import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:component_library/component_library.dart';
import 'variation_images_picker.dart';

class AddVariationForm extends StatefulWidget {
  final List<ProductAttributeField> attributeFields;

  final void Function({
    required Map<String, String> selectedAttributes,
    required double price,
    required int stock,
    required List<String> imageUrls,
  })
  onSubmitted;

  const AddVariationForm({
    super.key,
    required this.attributeFields,
    required this.onSubmitted,
  });

  @override
  State<AddVariationForm> createState() => _AddVariationFormState();
}

class _AddVariationFormState extends State<AddVariationForm> {
  final _formKey = GlobalKey<FormState>();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();

  late Map<String, String> selectedAttributes;

  final List<String> _variationImageUrls = [];

  void _onAddImage() {
    setState(() {
      _variationImageUrls.add(
        'https://picsum.photos/seed/${DateTime.now().microsecondsSinceEpoch}/200/200',
      );
    });
  }

  void _onRemoveImage(int index) {
    setState(() => _variationImageUrls.removeAt(index));
  }

  @override
  void initState() {
    super.initState();
    selectedAttributes = {
      for (final field in widget.attributeFields) field.name: '',
    };
  }

  @override
  void dispose() {
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    widget.onSubmitted(
      selectedAttributes: selectedAttributes,
      price: double.parse(_priceController.text.trim()),
      stock: int.parse(_stockController.text.trim()),
      imageUrls: _variationImageUrls,
    );
  }

  // 💥 NEW: Dynamic field builder
  Widget _buildAttributeField(ProductAttributeField field) {
    final attributeName = field.name;

    switch (field.dataType) {
      case AttributeDataType.dropdown:
        final options = field.options;
        if (options == null || options.isEmpty) {
          return const SizedBox.shrink();
        }
        return DropdownButtonFormField<String>(
          value: selectedAttributes[attributeName]!.isEmpty
              ? null
              : selectedAttributes[attributeName],
          decoration: InputDecoration(
            labelText: attributeName,
            hintText: "Select $attributeName",
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          items: options
              .map((v) => DropdownMenuItem(value: v, child: Text(v)))
              .toList(),
          validator: (v) => v == null || v.isEmpty ? "Required" : null,
          onChanged: (value) {
            setState(() {
              selectedAttributes[attributeName] = value!;
            });
          },
        );

      case AttributeDataType.number:
        return TextFormField(
          initialValue: selectedAttributes[attributeName],
          keyboardType: TextInputType.number,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: attributeName,
            suffixText: field.unit ?? '',
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value == null || value.trim().isEmpty) return "Required";
            if (int.tryParse(value) == null) return "Must be a number";
            return null;
          },
          onChanged: (value) {
            selectedAttributes[attributeName] = value.trim();
          },
        );

      case AttributeDataType.text:
      default:
        return TextFormField(
          initialValue: selectedAttributes[attributeName],
          keyboardType: TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(labelText: attributeName),
          validator: (value) =>
              value == null || value.trim().isEmpty ? "Required" : null,
          onChanged: (value) {
            selectedAttributes[attributeName] = value.trim();
          },
        );
    }
  }
  // 💥 END NEW: Dynamic field builder

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Create Variation and Offer')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VariationImagesPicker(
                  imageUrls: _variationImageUrls,
                  onAddImage: _onAddImage,
                  onRemoveImage: _onRemoveImage,
                ),
                  
                const SizedBox(height: 32),
                  
                // 💥 CHANGED: Mapping over the new list and using the builder
                ...widget.attributeFields.map((field) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildAttributeField(field),
                  );
                }),
                const SizedBox(height: 16),
                  
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _priceController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d{0,2}'),
                          ),
                        ],
                        decoration: const InputDecoration(labelText: "Price"),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Required";
                          }
                          final p = double.tryParse(value);
                          if (p == null || p <= 0) return "Invalid";
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _stockController,
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: const InputDecoration(
                          labelText: "Stock Quantity",
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Required";
                          }
                          final s = int.tryParse(value);
                          if (s == null || s < 0) return "Invalid";
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                  
                const SizedBox(height: 24),
                PrimaryActionButton(label: "Create Variation", onPressed: _submit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}