import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_screen/src/home_cubit.dart';
import 'package:component_library/component_library.dart'; // Assuming this is correctly imported

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onProductTap});

  final Function(BuildContext context, String productId) onProductTap;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16,
            children: [
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return AppSearchBar(
                    onSearchchanged: (term) {
                      context.read<HomeCubit>().onSearchTermChanged(term);
                    },
                  );
                },
              ),
              Expanded(
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    // Using 'switch' with a sealed class to ensure all states are handled.
                    return switch (state) {
                      HomeLoading() => const CenteredProgressIndicator(),
                      HomeLoaded(
                        products: final products,
                        currentSearchTerm: final searchTerm,
                      ) =>
                        products.isEmpty
                            ? Center(
                                child: Text(
                                  searchTerm.isNotEmpty
                                      ? 'No products found for "$searchTerm".'
                                      : 'No products available.',
                                ),
                              )
                            : GridView.builder(
                                scrollDirection: Axis.vertical,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                      childAspectRatio: 300 / 380,
                                    ),
                                itemCount: products.length,
                                itemBuilder: (context, indx) {
                                  final product = products[indx];

                                  return ProductCard(
                                    imageUrl: product
                                        .variations
                                        .first
                                        .imageUrls
                                        .first,
                                    title: product.name,
                                    price: product.variations.first.price,
                                    onTap: () =>
                                        onProductTap(context, product.id),
                                    onAddToCart: () {
                                      context
                                          .read<HomeCubit>()
                                          .toggleCartStatus(product.id);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Added "${product.name}" to cart!',
                                          ),
                                          duration: const Duration(
                                            milliseconds: 700,
                                          ),
                                        ),
                                      );
                                    },
                                    onWishlistToggle: () {
                                      context
                                          .read<HomeCubit>()
                                          .toggleWishlistStatus(product.id);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Added "${product.name}" to wishlist!',
                                          ),
                                          duration: const Duration(
                                            milliseconds: 700,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                      HomeError(message: final message) => Center(
                        child: Text('Error: $message'),
                      ),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
