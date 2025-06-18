import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_bloc.dart';
import 'package:component_library/component_library.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.onProductTap,
    required this.filterDialog,
    required this.onCategoryFilterTap,
  });

  final Function(BuildContext context, String productId) onProductTap;
  final Function(Category) onCategoryFilterTap;
  final Widget filterDialog;

  void _showFilterDialog(BuildContext context) async {
    final selectedCategory = await showDialog<Category>(
      context: context,
      builder: (BuildContext context) => filterDialog,
    );

    if (selectedCategory != null) {
      onCategoryFilterTap(selectedCategory);
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is HomeSearchError) {
                _showSnackBar(context, 'Search Failed: ${state.message}');
              }
            },
            builder: (context, state) {
              final bloc = context.read<HomeBloc>();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AudioTextInputField(
                    onFilterTap: () => _showFilterDialog(context),
                    isSearching: state is HomeSearchProcessing,
                    amplitudeStream: bloc.getAmplitudeStream,
                    onTextChanged: (value) =>
                        bloc.add(SearchTermChanged(value)),
                    onMicTap: () => bloc.add(StartRecordingSearch()),
                    onSendText: () {
                      if (state is HomeLoaded) {
                        bloc.add(SendTextSearch(state.currentSearchTerm));
                      }
                    },
                    onSendRecording: () =>
                        context.read<HomeBloc>().add(SendRecordingSearch()),
                    onCancelRecording: () =>
                        context.read<HomeBloc>().add(CancelRecordingSearch()),
                  ),
                  const SizedBox(height: 16),

                  // Product display with Bloc state management
                  Expanded(
                    child: BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
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
                                          context.read<HomeBloc>().add(
                                            ToggleCartStatus(
                                              product.variations.first,
                                            ),
                                          );
                                          _showSnackBar(
                                            context,
                                            'Added "${product.name}" to cart!',
                                          );
                                        },
                                        onWishlistToggle: () {
                                          context.read<HomeBloc>().add(
                                            ToggleWishlistStatus(product.id),
                                          );
                                          _showSnackBar(
                                            context,
                                            'Added "${product.name}" to wishlist!',
                                          );
                                        },
                                      );
                                    },
                                  ),
                          HomeError(message: final message) => Center(
                            child: Text('Error: $message'),
                          ),
                          HomeSearchProcessing() => const Column(
                            children: [
                              CenteredProgressIndicator(),
                              SizedBox(height: 8),
                              Text('Processing search...'),
                            ],
                          ),
                          HomeIdleSearch() => const SizedBox.shrink(),
                          HomeSearchSuccess(result: final result) => Card(
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Text('Search Result: $result'),
                            ),
                          ),
                          HomeSearchError() => const SizedBox.shrink(),
                        };
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
