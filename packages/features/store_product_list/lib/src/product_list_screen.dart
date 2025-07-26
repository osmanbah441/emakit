import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_list_bloc.dart';
import 'package:component_library/component_library.dart';

import 'product_list_view.dart';

class StoreProductListScreen extends StatelessWidget {
  const StoreProductListScreen({
    super.key,
    required this.onProductTap,
    required this.onCategoryFilterTap,
    required this.filterDialog,
    this.onAddNewProductTap,
  });

  final Function(BuildContext context, String productId) onProductTap;
  final Function(BuildContext context)? onAddNewProductTap;

  final Function(Category) onCategoryFilterTap;
  final Widget filterDialog;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreProductListBloc(),
      child: StoreProductListScreenView(
        onProductTap: onProductTap,
        filterDialog: filterDialog,
        onCategoryFilterTap: onCategoryFilterTap,
        onAddNewProductTap: onAddNewProductTap,
      ),
    );
  }
}

@visibleForTesting
class StoreProductListScreenView extends StatelessWidget {
  const StoreProductListScreenView({
    super.key,
    required this.onProductTap,
    required this.filterDialog,
    required this.onCategoryFilterTap,
    this.onAddNewProductTap,
  });

  final Function(BuildContext context, String productId) onProductTap;
  final Function(BuildContext context)? onAddNewProductTap;
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
    return BlocConsumer<StoreProductListBloc, StoreProductListState>(
      listener: (context, state) {
        if (state is ProductListSearchError) {
          _showSnackBar(context, 'Search Failed: ${state.message}');
        }
      },
      builder: (context, state) {
        final bloc = context.read<StoreProductListBloc>();

        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: onAddNewProductTap != null
                ? () => onAddNewProductTap!(context)
                : null,
            tooltip: 'Add New Product',
            label: Text('Add Product'),
            icon: const Icon(Icons.add),
          ),

          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AudioTextInputField(
                  onFilterTap: () => _showFilterDialog(context),
                  isSearching: state is ProductListSearchProcessing,
                  onSendText: (text) => bloc.add(SendTextSearch(text)),
                  onSendRecording: (mimeType, bytes) => bloc.add(
                    SendRecordingSearch(bytes: bytes, mimeType: mimeType),
                  ),
                ),
                const SizedBox(height: 16),

                // Product display with Bloc state management
                Expanded(
                  child: BlocBuilder<StoreProductListBloc, StoreProductListState>(
                    builder: (context, state) {
                      return switch (state) {
                        ProductListLoading() =>
                          const CenteredProgressIndicator(),
                        ProductListLoaded(
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
                              : ProductListView(
                                  products: products,
                                  onProductTap: onProductTap,
                                ),

                        ProductListError(message: final message) => Center(
                          child: Text('Error: $message'),
                        ),
                        ProductListSearchProcessing() => const Column(
                          children: [
                            CenteredProgressIndicator(),
                            SizedBox(height: 8),
                            Text('Processing search...'),
                          ],
                        ),
                        ProductListIdleSearch() => const SizedBox.shrink(),
                        ProductListSearchSuccess(result: final result) => Card(
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Text('Search Result: $result'),
                          ),
                        ),
                        ProductListSearchError() => const SizedBox.shrink(),
                      };
                    },
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
