import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_repository/product_repository.dart';

enum OfferFilter { active, paused, outOfStock, all }

// Extension to map the enum to the displayed text
extension OfferFilterExtension on OfferFilter {
  String get displayName {
    switch (this) {
      case OfferFilter.active:
        return 'Active';
      case OfferFilter.paused:
        return 'Paused';
      case OfferFilter.outOfStock:
        return 'Out of Stock';
      case OfferFilter.all:
        return 'All Offers';
    }
  }
}

// State class
class ManageOffersState {
  final List<StoreProduct> products;
  final bool isLoading;
  final OfferFilter currentFilter;
  final String searchQuery;

  ManageOffersState({
    required this.products,
    this.isLoading = true,
    this.currentFilter = OfferFilter.active,
    this.searchQuery = '',
  });

  ManageOffersState copyWith({
    List<StoreProduct>? products,
    bool? isLoading,
    OfferFilter? currentFilter,
    String? searchQuery,
  }) {
    return ManageOffersState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      currentFilter: currentFilter ?? this.currentFilter,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  // The main logic for filtering and searching the products
  List<StoreProduct> get filteredProducts {
    List<StoreProduct> list = products;

    // 1. Filter by status
    if (currentFilter != OfferFilter.all) {
      list = list.where((product) {
        switch (currentFilter) {
          case OfferFilter.active:
            return product.offerIsActive!;
          case OfferFilter.paused:
            return !product.offerIsActive!;
          case OfferFilter.outOfStock:
            return product.offerStockQuantity == 0;
          default:
            return true;
        }
      }).toList();
    }

    // 2. Filter by search query
    if (searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      list = list.where((product) {
        return (product.productName?.toLowerCase().contains(query) ?? false) ||
            (product.productName!.toLowerCase().contains(query));
      }).toList();
    }

    return list;
  }
}

// Cubit
class ManageOffersCubit extends Cubit<ManageOffersState> {
  final ProductRepository _repository;
  // A cache for all products fetched initially
  List<StoreProduct> _allProductsCache = [];

  ManageOffersCubit(this._repository) : super(ManageOffersState(products: [])) {
    loadProducts();
  }

  Future<void> loadProducts() async {
    emit(state.copyWith(isLoading: true));
    try {
      _allProductsCache = await _repository.getStoreProductWithOffer();
      // Initially, we pass the full list to the state, and let the getter filter it.
      emit(state.copyWith(products: _allProductsCache, isLoading: false));
    } catch (e) {
      // Handle error state here in a real app
      debugPrint('Error loading products: $e');
      emit(state.copyWith(isLoading: false, products: []));
    }
  }

  void filterProducts(OfferFilter filter) {
    emit(state.copyWith(currentFilter: filter));
  }

  void searchProducts(String query) {
    emit(state.copyWith(searchQuery: query));
  }
}

/// --- WIDGETS (COMPONENTS) ---

// 1. Reusable Chip Component for Filtering
class FilterChipComponent extends StatelessWidget {
  final OfferFilter filter;
  final OfferFilter selectedFilter;
  final Function(OfferFilter) onSelected;

  const FilterChipComponent({
    super.key,
    required this.filter,
    required this.selectedFilter,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = filter == selectedFilter;
    final Color selectedColor = Colors.green; // Active color

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: () => onSelected(filter),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? selectedColor : Colors.transparent,
            border: Border.all(
              color: isSelected ? selectedColor : Colors.white54,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            filter.displayName,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

// 2. Reusable Product Card Component
class ProductCardComponent extends StatelessWidget {
  final StoreProduct product;

  const ProductCardComponent({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final status = product.offerIsActive!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image (Mocked)
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              // Using an icon as a placeholder for the image
              Icons.headset,
              color: Colors.white70,
            ),
          ),
          const SizedBox(width: 12),
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.productName ?? 'N/A',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  product.productName!,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '\$${product.offerPrice?.toStringAsFixed(2) ?? '0.00'}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Stock/Status
                    Text(
                      'Stock: ${product.offerStockQuantity ?? 0}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 3. Reusable Search Bar Component (simplified for the list)
class SearchBarComponent extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const SearchBarComponent({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search offers...',
          hintStyle: const TextStyle(color: Colors.white54),
          prefixIcon: const Icon(Icons.search, color: Colors.white54),
          filled: true,
          fillColor: Colors.grey[800],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
      ),
    );
  }
}

/// --- SCREEN WIDGET ---

class OfferListScreen extends StatefulWidget {
  const OfferListScreen({
    super.key,
    required this. productRepository,
    required this. onAddProduct,
    required this. onProductTap,
  });

  final ProductRepository productRepository;
  final VoidCallback onAddProduct;
  final Function(String) onProductTap;


  @override
  State<OfferListScreen> createState() => _OfferListScreenState();
}

class _OfferListScreenState extends State<OfferListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Inject the Cubit using BlocProvider
    return BlocProvider(
      create: (_) => ManageOffersCubit(ProductRepositoryImpl()),
      child: Scaffold(
        backgroundColor: const Color(0xFF121212), // Dark background color
        appBar: AppBar(
          backgroundColor: const Color(0xFF121212),
          foregroundColor: Colors.white,
          title: const Text(
            'Manage Offers',
            style: TextStyle(color: Colors.white),
          ),
       
        ),
        body: Column(
          children: [
            // Search Bar Component
            BlocBuilder<ManageOffersCubit, ManageOffersState>(
              buildWhen: (previous, current) =>
                  previous.searchQuery != current.searchQuery,
              builder: (context, state) {
                return SearchBarComponent(
                  controller: _searchController,
                  onChanged: (query) {
                    context.read<ManageOffersCubit>().searchProducts(query);
                  },
                );
              },
            ),

            // Filter Chips (Horizontal List)
            BlocBuilder<ManageOffersCubit, ManageOffersState>(
              buildWhen: (previous, current) =>
                  previous.currentFilter != current.currentFilter,
              builder: (context, state) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children:
                        OfferFilter.values.map((filter) {
                          // Skip 'All Offers' for this UI, as it uses the custom '+ Custom' button for alternatives
                          if (filter == OfferFilter.all)
                            return const SizedBox.shrink();

                          return FilterChipComponent(
                            filter: filter,
                            selectedFilter: state.currentFilter,
                            onSelected: (newFilter) {
                              context.read<ManageOffersCubit>().filterProducts(
                                newFilter,
                              );
                            },
                          );
                        }).toList()..add(
                          // Simulate the "+ Custom" button from the image
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white54),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                '+ Custom',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                  ),
                );
              },
            ),
            const Divider(color: Colors.white12, height: 20),

            // Product List
            Expanded(
              child: BlocBuilder<ManageOffersCubit, ManageOffersState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    );
                  }

                  final productsToDisplay = state.filteredProducts;

                  if (productsToDisplay.isEmpty) {
                    return const Center(
                      child: Text(
                        'No offers found.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    itemCount: productsToDisplay.length,
                    itemBuilder: (context, index) {
                      return ProductCardComponent(
                        product: productsToDisplay[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: widget.onAddProduct,
          backgroundColor: Colors.green,
          child: const Icon(Icons.add, color: Colors.black),
        ),
      ),
    );
  }
}
