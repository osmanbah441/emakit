import 'package:flutter/material.dart';
import 'package:domain_models/domain_models.dart';
import 'package:component_library/component_library.dart';
import 'package:product_repository/product_repository.dart';

class ProductVariationAddScreen extends StatelessWidget {
  final String productId;
  final ProductRepository productRepository;

  const ProductVariationAddScreen({
    super.key,
    required this.productId,
    required this.productRepository,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Variation'), centerTitle: false),
      body: FutureBuilder<ProductWithAttributes>(
        future: productRepository.getProductWithAttributes(productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CenteredProgressIndicator();
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Product data not found.'));
          }

          final product = snapshot.data!;
          return VariationForm(
            product: product,
            productRepository: productRepository,
          );
        },
      ),
    );
  }
}

class VariationForm extends StatefulWidget {
  final ProductWithAttributes product;
  final ProductRepository productRepository;

  const VariationForm({
    super.key,
    required this.product,
    required this.productRepository,
  });

  @override
  State<VariationForm> createState() => _VariationFormState();
}

class _VariationFormState extends State<VariationForm> {
  final _formKey = GlobalKey<FormState>();

  final _stockController = TextEditingController();
  final _priceController = TextEditingController();
  final _activeUrlController = TextEditingController();

  final _imageUrls = <String>[];
  bool _isAttemptingSubmit = false;

  final Map<String, String?> _selectedAttributes = {};

  @override
  void dispose() {
    _stockController.dispose();
    _priceController.dispose();
    _activeUrlController.dispose();
    super.dispose();
  }

  String? _validateIntInput(String? value) {
    if (value == null || value.isEmpty) return 'Field is required.';
    if (int.tryParse(value) == null || int.parse(value) <= 0) {
      return 'Enter a valid positive number.';
    }
    return null;
  }

  void _submit() async {
    setState(() {
      _isAttemptingSubmit = true;
    });

    if (!_formKey.currentState!.validate()) return;

    await widget.productRepository.insertProductVariant(
      storeId: "b6a74a2b-4e00-4c54-a54e-8941c3668142",
      productId: widget.product.productId,
      stock: int.parse(_stockController.text),
      price: int.parse(_priceController.text),
      attributes: _selectedAttributes.map(
        (key, value) => MapEntry(key, value!),
      ),
      imageUrls: _imageUrls,
    );
  }

  void _submitImageUrl() {
    final url = _activeUrlController.text.trim();

    if (url.isEmpty) return;
    if (!url.startsWith('http')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid URL. Must start with http or https.'),
        ),
      );
      return;
    }

    setState(() {
      _imageUrls.add(url);
      _activeUrlController.clear();
    });
  }

  Widget _buildAttributeDropdown(ProductVariantAttribute attribute) {
    return DropdownButtonFormField<String>(
      items: attribute.options.map((option) {
        return DropdownMenuItem(value: option, child: Text(option));
      }).toList(),
      decoration: InputDecoration(labelText: attribute.attributeName),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (value) {
        setState(() {
          _selectedAttributes[attribute.attributeId] = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a ${attribute.attributeName}.';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isImageMissing = _isAttemptingSubmit && _imageUrls.isEmpty;
    final bool isImageMaxed = _imageUrls.length >= 4;
    final errorColor = Theme.of(context).colorScheme.error;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.product.productName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),

            // Stock & Price fields
            Row(
              spacing: 16,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Price'),
                    validator: _validateIntInput,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _stockController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Stock'),
                    validator: _validateIntInput,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Attribute dropdowns
            ...widget.product.attributes.map((attr) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: _buildAttributeDropdown(attr),
              );
            }),

            const SizedBox(height: 32),
            Text(
              'Images (${_imageUrls.length} / 4)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),

            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _imageUrls.map((url) {
                return Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Theme.of(context).dividerColor,
                        ),
                        image: DecorationImage(
                          image: NetworkImage(url),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: -5,
                      right: -5,
                      child: IconButton(
                        icon: const Icon(
                          Icons.remove_circle,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            _imageUrls.remove(url);
                          });
                        },
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),

            if (isImageMissing)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'You must add at least one image.',
                  style: TextStyle(color: errorColor, fontSize: 12),
                ),
              ),

            if (!isImageMaxed)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _activeUrlController,
                        keyboardType: TextInputType.url,
                        decoration: InputDecoration(
                          labelText: 'Image URL',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () => _activeUrlController.clear(),
                          ),
                        ),
                        onFieldSubmitted: (_) => _submitImageUrl(),
                        validator: (value) {
                          if (value != null &&
                              value.isNotEmpty &&
                              !value.startsWith('http')) {
                            return 'URL must start with http or https.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    PrimaryActionButton(
                      label: 'Add Image',
                      isExtended: false,
                      onPressed: _submitImageUrl,
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 32),
            PrimaryActionButton(label: 'Submit', onPressed: _submit),
          ],
        ),
      ),
    );
  }
}
