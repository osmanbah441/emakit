import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:collection';
import 'package:component_library/component_library.dart';

import 'product_details_cubit.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductDetailsCubit()..loadProduct(productId),
      child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state.status == ProductDetailsStatus.loading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state.status == ProductDetailsStatus.failure) {
            return Scaffold(
              appBar: AppBar(title: const Text('Error')),
              body: Center(
                child: Text('Error: ${state.error ?? "Unknown error"}'),
              ),
            );
          }
          if (state.product == null) {
            return Scaffold(
              appBar: AppBar(title: const Text('Not Found')),
              body: const Center(child: Text('Product not found.')),
            );
          }

          final product = state.product!;
          final cubit = context.read<ProductDetailsCubit>();
          final selectedVariation = state.selectedVariation;

          return Scaffold(
            appBar: AppBar(
              title: Text(product.name),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (Navigator.canPop(context)) Navigator.pop(context);
                },
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      product.description,
                      style: TextStyle(
                        fontSize: 14.0,
                        height: 1.5,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  if (selectedVariation != null)
                    ProductCarouselView(imageUrls: selectedVariation.imageUrls),
                  const SizedBox(height: 16),
                  if (selectedVariation != null)
                    Text(
                      '\$${selectedVariation.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 28.0,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                  if (selectedVariation == null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'This combination is not available.',
                        style: TextStyle(
                          color: Colors.orange.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  // Attribute Selectors
                  ...state.availableAttributes.entries.map((entry) {
                    final String attributeKey = entry.key;
                    final LinkedHashSet<dynamic> attributeValues = entry.value;

                    if (attributeValues.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return AttributeSelector<dynamic>(
                      key: ValueKey(attributeKey),
                      selectorLabel: attributeKey,
                      options: attributeValues.toList(),
                      selectedOption:
                          state.currentSelectedAttributes[attributeKey],
                      onOptionSelected: (selectedValue) {
                        cubit.updateSelectedAttribute(
                          attributeKey,
                          selectedValue,
                        );
                      },
                    );
                  }),

                  Row(
                    children: [
                      Expanded(
                        child: PrimaryActionButton(
                          onPressed: selectedVariation != null
                              ? () {
                                  cubit.addToCart(selectedVariation);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Added ${product.name} attribute: ${selectedVariation.attributes} to cart!',
                                      ),
                                    ),
                                  );
                                }
                              : null,
                          label: 'Add to Cart',
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: Theme.of(context).primaryColor,
                          size: 28,
                        ),
                        onPressed: () {
                          debugPrint(
                            'Add to Favorites tapped! Product: ${product.id}, Selected Variation: ${state.selectedVariation?.id}',
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Added ${product.name} to favorites!',
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  KeyValueSection(
                    title: 'Specifications',
                    data: product.specifications,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
