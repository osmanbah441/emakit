import 'package:flutter/material.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_details/src/product_details_cubit.dart';
import 'package:component_library/component_library.dart';

class StoreProductDetailsScreen extends StatelessWidget {
  const StoreProductDetailsScreen({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsCubit(productId),
      child: const StoreProductDetailView(),
    );
  }
}

class SpecificationRow extends StatelessWidget {
  final String label;
  final String value;

  const SpecificationRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class StoreProductDetailView extends StatelessWidget {
  const StoreProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          switch (state.status) {
            case ActionStatus.initial:
            case ActionStatus.loading:
              return const Center(child: CenteredProgressIndicator());

            case ActionStatus.success:
              final product = state.product!;
              final specKeys = product.specifications.keys.toList();

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildImageSection(context, product),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            product.name,
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            product.description,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  height: 1.5,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color
                                      ?.withOpacity(0.7),
                                ),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            'Specifications',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          ...specKeys.map((key) {
                            return SpecificationRow(
                              label: key,
                              value: product.specifications[key].toString(),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              );

            case ActionStatus.failure:
              return Center(
                child: Text(state.error ?? 'Failed to load product.'),
              );
          }
        },
      ),
    );
  }

  Widget _buildImageSection(BuildContext context, Product product) {
    return AspectRatio(
      aspectRatio: 16 / 12,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              'assets/placeholder_product.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[200],
                child: Center(
                  child: Image.asset('image_f6ec47.jpg', fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            child: Row(
              children: List.generate(
                product.mainProductMedia.isNotEmpty
                    ? product.mainProductMedia.length
                    : 3,
                (index) => Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == 0
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
