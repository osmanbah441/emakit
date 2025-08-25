import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:component_library/component_library.dart';
import 'package:component_library/src/measurement_table.dart';
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
      create: (context) => ProductDetailsCubit(productId),
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
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            return TextButton(
              onPressed: state.product?.storeName != null
                  ? () => onVisitStoreTap(state.product!.storeName)
                  : null,
              child: Text(state.product?.storeName ?? 'Loading...'),
            );
          },
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
        ],
      ),
      body: BlocListener<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {
          if (state.status == ActionStatus.failure && state.error != null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.error!)));
          }
        },
        child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state.status == ActionStatus.initial ||
                (state.status == ActionStatus.loading &&
                    state.product == null)) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == ActionStatus.failure && state.product == null) {
              return Center(
                child: Text(state.error ?? 'Failed to load product.'),
              );
            }
            if (state.product == null) {
              return const Center(child: Text('Product not found.'));
            }

            final product = state.product!;
            final textTheme = Theme.of(context).textTheme;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductImageCarousel(imageUrls: product.images),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name, style: textTheme.titleLarge),
                        const SizedBox(height: 16),
                        const Divider(height: 8),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '\$',
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              TextSpan(
                                text: product.price?.toStringAsFixed(2) ?? "",
                                style: textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$23.98 Shipping & Import Charges to Sierra Leone',
                          style: textTheme.bodySmall,
                        ),
                        const SizedBox(height: 24),
                        const ActionButtonsLayout(),
                        const Divider(height: 32),
                        StoreRating(
                          storeName: product.storeName,
                          rating: product.storeRating,
                          reviewCount: product.storeReviewCount,
                        ),
                        const Divider(height: 32),
                        MeasurementTable(
                          measurements: product.measurements,
                          unit: state.measurementUnit,
                          onUnitChanged: (unit) {
                            context
                                .read<ProductDetailsCubit>()
                                .setMeasurementUnit(unit);
                          },
                        ),
                      ],
                    ),
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

class ActionButtonsLayout extends StatelessWidget {
  const ActionButtonsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => context.read<ProductDetailsCubit>().addToCart(),
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
            ),
            child: const Text('Add to Cart', style: TextStyle(fontSize: 16)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () => context.read<ProductDetailsCubit>().buyNow(),
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.secondary,
              foregroundColor: colorScheme.onSecondary,
            ),
            child: const Text('Buy Now', style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }
}
