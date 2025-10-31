import 'package:flutter/material.dart';
import 'package:domain_models/domain_models.dart';
import 'package:product_repository/product_repository.dart';
import 'components/product_list_card.dart';

class StoreProductListScreen extends StatelessWidget {
  final VoidCallback onAddProduct;
  final ValueChanged<String> onProductTap;
  final ProductRepository productRepository;

  const StoreProductListScreen({
    super.key,
    required this.onAddProduct,
    required this.onProductTap,
    required this.productRepository,
  });

  @override
  Widget build(BuildContext context) {
    return StoreProductListView(
      onAddProduct: onAddProduct,
      onProductTap: onProductTap,
      productRepository: productRepository,
    );
  }
}

class StoreProductListView extends StatefulWidget {
  final VoidCallback onAddProduct;
  final ValueChanged<String> onProductTap;
  final ProductRepository productRepository;

  const StoreProductListView({
    super.key,
    required this.onAddProduct,
    required this.onProductTap,
    required this.productRepository,
  });

  @override
  State<StoreProductListView> createState() => _StoreProductListViewState();
}

class _StoreProductListViewState extends State<StoreProductListView> {
  final TextEditingController _searchController = TextEditingController();

  List<Product> _allProducts = [];
  String _listTitle = 'All Products';
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_handleSearchInput);
    _loadInitialData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadInitialData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final allProducts = await widget.productRepository.getAll(
        ApplicationRole.store,
      );

      if (allProducts.isNotEmpty) {
        allProducts.shuffle();
      }

      setState(() {
        _allProducts = allProducts;
        _listTitle = 'All Products';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to load products: ${e.toString()}";
        _isLoading = false;
      });
    }
  }

  void _handleSearchInput() {
    setState(() {});
  }

  List<Product> get _filteredProducts {
    final query = _searchController.text.toLowerCase().trim();
    if (query.isEmpty) {
      return _allProducts;
    }
    return _allProducts
        .where((product) => product.name.toLowerCase().contains(query))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        title: Text(
          _listTitle,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search product names...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
        ),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onAddProduct,
        tooltip: 'Discover New Product',
        child: const Icon(Icons.explore),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(child: Text(_errorMessage!));
    }

    if (_filteredProducts.isEmpty) {
      return const Center(child: Text('No products found.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _filteredProducts.length,
      itemBuilder: (context, index) {
        final product = _filteredProducts[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: StoreProductListCard(
            product: product,
            onTap: () => widget.onProductTap.call(product.id),
          ),
        );
      },
    );
  }
}
