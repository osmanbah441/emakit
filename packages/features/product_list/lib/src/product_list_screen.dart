import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list/src/product_grid_view.dart';
import 'product_list_bloc.dart';
import 'package:component_library/component_library.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({
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
      create: (context) => ProductListBloc(),
      child: ProductListScreenView(
        onProductTap: onProductTap,
        filterDialog: filterDialog,
        onCategoryFilterTap: onCategoryFilterTap,
        onAddNewProductTap: onAddNewProductTap,
      ),
    );
  }
}

@visibleForTesting
class ProductListScreenView extends StatelessWidget {
  const ProductListScreenView({
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

  // Removed _showErrorDialog method as it's no longer needed

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductListBloc, ProductListState>(
      listener: (context, state) {
        // The listener is now empty because the error is displayed inline.
        // ProductListSearchError state is now only used internally by the Bloc
        // to immediately transition to ProductListLoaded with an error message.
      },
      builder: (context, state) {
        final bloc = context.read<ProductListBloc>();

        return Scaffold(
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
                  child: BlocBuilder<ProductListBloc, ProductListState>(
                    builder: (context, state) {
                      return switch (state) {
                        ProductListLoading() =>
                          const CenteredProgressIndicator(),
                        ProductListLoaded(
                          products: final products,
                          currentSearchTerm: final searchTerm,
                          searchErrorMessage: final searchErrorMessage, // Get the error message from state
                        ) =>
                          Column(
                            children: [
                              // Display the inline error message if present
                              if (searchErrorMessage != null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    'search failed: $searchErrorMessage',
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                              Expanded(
                                child: products.isEmpty
                                    ? Center(
                                        child: Text(
                                          searchTerm.isNotEmpty
                                              ? 'No products found for "$searchTerm".'
                                              : 'No products available.',
                                        ),
                                      )
                                    : ProductGridView(
                                        products: products,
                                        onProductTap: onProductTap,
                                      ),
                              ),
                            ],
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
                        // These states are now less critical for UI rendering,
                        // as the bloc will quickly transition to ProductListLoaded
                        // even on error. ProductListSearchError is no longer handled
                        // directly by the builder, only by the previous state transition.
                        ProductListIdleSearch() => const SizedBox.shrink(),
                        ProductListSearchSuccess(result: final result) => Card(
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Text('Search Result: $result'),
                          ),
                        ),
                        // This state should now ideally never be directly built by the widget,
                        // as the Bloc immediately transitions from it to ProductListLoaded.
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
