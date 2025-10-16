import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:component_library/component_library.dart';
import 'package:product_details/src/components/clothing_size_details.dart';
import 'package:product_details/src/components/product_variation_selector.dart';
import 'product_details_cubit.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    super.key,
    required this.onVisitStoreTap,
    required this.productId,
  });

  final Function(String) onVisitStoreTap;
  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductDetailsCubit(productId),
      child: ProductDetailsView(onVisitStoreTap: onVisitStoreTap),
    );
  }
}

@visibleForTesting
class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.onVisitStoreTap});

  final Function(String) onVisitStoreTap;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
      listener: (context, state) {
        if (state.status == ActionStatus.failure && state.error != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.error!)));
        }
      },
      builder: (context, state) {
        // loading states
        if (state.status == ActionStatus.initial ||
            (state.status == ActionStatus.loading && state.product == null)) {
          return const Scaffold(body: CenteredProgressIndicator());
        }
        // error states
        if (state.status == ActionStatus.failure && state.product == null) {
          return Scaffold(
            body: Center(child: Text(state.error ?? 'Failed to load product.')),
          );
        }
        if (state.product == null) {
          return const Scaffold(
            body: Center(child: Text('Product not found.')),
          );
        }

        final product = state.product!;
        final selectedVariation = state.selectedVariation;
        final textTheme = Theme.of(context).textTheme;
        final isClothingDetails = product.specifications is ClothingDetails;
        final canInteract = state.product != null && selectedVariation != null;

        final colorScheme = Theme.of(context).colorScheme;

        final cubit = context.read<ProductDetailsCubit>();

        final cartAndBuyButtonRow = Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: canInteract ? cubit.addToCart : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                ),
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: canInteract ? cubit.buyNow : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.secondary,
                  foregroundColor: colorScheme.onSecondary,
                ),
                child: const Text('Buy Now', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        );
        final header = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () => onVisitStoreTap(state.store!.id),

                child: Text(state.store!.name),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: Text(product.name, style: textTheme.titleMedium),
            ),
          ],
        );

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header,
                  ProductImageCarousel(imageUrls: selectedVariation!.imageUrls),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.favorite_border),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.share),
                            ),
                          ],
                        ),
                        const ProductVariationSelector(),
                        const Divider(height: 8),
                        const SizedBox(height: 8),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'NLE ',
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              TextSpan(
                                text: (selectedVariation.price).toStringAsFixed(
                                  2,
                                ),
                                style: textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('NLE 30 for delivery', style: textTheme.bodySmall),
                        const SizedBox(height: 16),

                        cartAndBuyButtonRow,
                        const SizedBox(height: 24),
                        StoreRating(
                          storeName: state.store?.name ?? '',
                          rating: state.store?.rating ?? 0,
                          reviewCount: state.store?.reviewCount ?? 0,
                        ),
                        const Divider(height: 32),
                        if (isClothingDetails) const ClothingSizeDetails(),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
