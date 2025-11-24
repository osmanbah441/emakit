import 'package:category_repository/category_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:product_and_variation_manager/src/components/add_variation_form.dart';
import 'package:product_repository/product_repository.dart';

class CreateVariationAndOfferScreen extends StatelessWidget {
  const CreateVariationAndOfferScreen({
    super.key,
    required this.productRepository,
    required this.categoryRepository,
    required this.productId,
    required String categoryId,
  });

  final ProductRepository productRepository;
  final CategoryRepository categoryRepository;
  final String productId;

  void _submitVariation({
    required Map<String, String> selectedAttributes,
    required List<String> imageUrls,
    required double price,
    required int stock,
  }) async {
    await productRepository.createVariationAndOffer(
      storeId: '1',
      productId: productId,
      attributes: selectedAttributes,
      imageUrls: imageUrls,
      price: price,
      stock: stock,
    );
  }

  Future<_ProductAndCategory> _fetchData() async {
    final product = await productRepository.getStoreProductById(productId);
    if (product == null) {
      throw Exception('Failed to fetch product with ID $productId');
    }
    final category = await categoryRepository.productCategory(
      id: product.categoryId!,
    );

    if (category.isEmpty) {
      throw Exception('Failed to fetch category');
    }

    return _ProductAndCategory(product: product, category: category.first);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Variation and Offer')),
      body: FutureBuilder(
        future: _fetchData(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (asyncSnapshot.hasError) {
            return Center(child: Text('Error: ${asyncSnapshot.error}'));
          }

          final product = asyncSnapshot.data;
          if (product == null) {
            return const Center(child: Text('Product not found'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: AddVariationForm(
              attributeFields: product.category.variantFields,
              onSubmitted: _submitVariation,
            ),
          );
        },
      ),
    );
  }
}

class _ProductAndCategory {
  final StoreProduct product;
  final ProductCategory category;

  _ProductAndCategory({required this.product, required this.category});
}
