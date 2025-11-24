import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:component_library/component_library.dart';
import 'package:product_and_variation_manager/src/components/product_info_card.dart';
import 'package:product_repository/product_repository.dart';
import 'package:category_repository/category_repository.dart';
import 'package:product_and_variation_manager/src/components/image_upload_box.dart';
import 'product_info_form.dart';
import 'cubit.dart';

class ProductAndVariationManagerScreen extends StatelessWidget {
  const ProductAndVariationManagerScreen({
    super.key,
    required this.productRepository,
    required this.categoryRepository,
    required this.onCreateOffer,
    required this.onCreateVariation,
  });

  final ProductRepository productRepository;
  final CategoryRepository categoryRepository;

  final Function(String) onCreateOffer;
  final Function({required String productId, required String categoryId})
  onCreateVariation;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductAddVariationCubit(
        productRepository: productRepository,
        categoryRepository: categoryRepository,
      ),
      child: ProductAndVariationManagerView(
        onCreateOffer: onCreateOffer,
        onCreateVariation: onCreateVariation,
      ),
    );
  }
}

@visibleForTesting
class ProductAndVariationManagerView extends StatelessWidget {
  const ProductAndVariationManagerView({
    super.key,
    required this.onCreateOffer,
    required this.onCreateVariation,
  });
  final Function(String) onCreateOffer;
  final Function({required String productId, required String categoryId})
  onCreateVariation;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductAddVariationCubit>();

    return SafeArea(
      child: BlocConsumer<ProductAddVariationCubit, ProductAddVariationState>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          body: switch (state) {
            ProductAddVariationInitial() => Center(
              // No padding needed here, just centering the ImageUploadBox
              child: ImageUploadBox(onTap: () => cubit.search()),
            ),
            ProductAddVariationLoading() => const CenteredProgressIndicator(),

            ProductAddVariationSearchSuccess() => _ProductList(
              onCreateOffer: onCreateOffer,
              onCreateVariation: onCreateVariation,
            ),
          },
        ),
      ),
    );
  }
}

class _ProductList extends StatefulWidget {
  const _ProductList({
    required this.onCreateOffer,
    required this.onCreateVariation,
  });

  final Function(String) onCreateOffer;
  final Function({required String productId, required String categoryId})
  onCreateVariation;

  @override
  State<_ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<_ProductList> {
  int _selectedSegment = 0;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductAddVariationCubit>();

    return BlocBuilder<ProductAddVariationCubit, ProductAddVariationState>(
      builder: (context, state) {
        final searchState = state as ProductAddVariationSearchSuccess;
        final products = searchState.products;
        final categories = searchState.categories;

        final existingBody = products.isEmpty
            ? const Center(child: Text('No existing products found.'))
            : ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final p = products[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ProductInfoCard(
                      onCreateNewVariation: () => widget.onCreateVariation(
                        productId: p.productId!,
                        categoryId: p.categoryId!,
                      ),
                      subtitle: p.manufacturer ?? 'N/A',
                      title: p.productName ?? 'Product Name N/A',
                      variantSignature: p.variantSignature!,
                      imageUrls:
                          p.productMedia?.map((e) => e.url).toList() ?? [],
                      specs:
                          p.productSpecifications?.map(
                            (k, v) => MapEntry(k, v.toString()),
                          ) ??
                          {},
                      onTap: () => widget.onCreateOffer(p.variantId!),
                    ),
                  );
                },
              );

        return Scaffold(
          appBar: AppBar(
            title: Text(
              _selectedSegment == 0
                  ? 'Existing Listings'
                  : 'Create New Product',
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: cubit.search,
              ),
            ],
          ),
          body: Padding(
            // Use standard padding constant
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<int>(
                    segments: const [
                      ButtonSegment(value: 0, label: Text('Existing Listing')),
                      ButtonSegment(value: 1, label: Text('Create New')),
                    ],
                    selected: {_selectedSegment},
                    showSelectedIcon: false,
                    onSelectionChanged: (set) {
                      setState(() => _selectedSegment = set.first);
                    },
                  ),
                ),

                // Replace hardcoded SizedBox(height: 12) with standard 8.0
                const SizedBox(height: 8),

                Expanded(
                  child: _selectedSegment == 0
                      ? existingBody
                      : ProductInfoForm(
                          // Data Connection: Use actual categories
                          availableCategories: categories,
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
