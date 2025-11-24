import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:product_repository/product_repository.dart';
import 'components/product_info_card.dart';

class CreateOfferScreen extends StatefulWidget {
  final String variantId;
  final ProductRepository productRepository;

  const CreateOfferScreen({
    super.key,
    required this.variantId,
    required this.productRepository,
  });

  @override
  State<CreateOfferScreen> createState() => _CreateOfferScreenState();
}

class _CreateOfferScreenState extends State<CreateOfferScreen> {
  final _formKey = GlobalKey<FormState>();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();

  @override
  void dispose() {
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  void _submit(String variantId) async {
    if (!_formKey.currentState!.validate()) return;
    await widget.productRepository.createOffer(
      storeId: '1',
      variantId: variantId,
      price: double.parse(_priceController.text.trim()),
      stock: int.parse(_stockController.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Create Offer')),
      body: Form(
        key: _formKey,
        child: FutureBuilder(
          future: widget.productRepository.getStoreProductVariantById(
            widget.variantId,
          ),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return const CenteredProgressIndicator();
            }

            if (asyncSnapshot.hasError) {
              return Center(child: Text('Error: ${asyncSnapshot.error}'));
            }

            final storeProduct = asyncSnapshot.data;
            if (storeProduct == null) {
              return const Center(child: Text('Product not found'));
            }

            final mediaUrls =
                storeProduct.productMedia?.map((e) => e.url).toList() ?? [];

            final specs =
                storeProduct.productSpecifications?.map(
                  (k, v) => MapEntry(k, v.toString()),
                ) ??
                {};

            final signature =
                storeProduct.variantSignature ?? 'Variant signature N/A';

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductInfoCard(
                    title: storeProduct.productName ?? 'Product Name N/A',
                    subtitle: storeProduct.manufacturer ?? 'Manufacturer N/A',
                    aspectRatio: 4 / 3,
                    elevation: 0,
                    imageUrls: mediaUrls,
                    specs: specs,
                    variantSignature: storeProduct.variantSignature!,
                  ),

                  const SizedBox(height: 40),

                  Text(
                    'Variation Signature:',
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    signature,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 40),

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
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return "Required";
                            }
                            final parsed = double.tryParse(v);
                            if (parsed == null || parsed <= 0) return "Invalid";
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
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            labelText: "Stock Quantity",
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return "Required";
                            }
                            final parsed = int.tryParse(v);
                            if (parsed == null || parsed < 0) return "Invalid";
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  PrimaryActionButton(
                    label: "Create Offer",
                    onPressed: () => _submit(storeProduct.variantId!),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
