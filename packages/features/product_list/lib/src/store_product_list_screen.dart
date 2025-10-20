import 'package:flutter/material.dart';
import 'package:domain_models/domain_models.dart';
import 'package:product_repository/product_repository.dart';
import 'components/product_list_card.dart';

class StoreProductListScreen extends StatelessWidget {
  final VoidCallback? onProductRequest;
  final ValueChanged<String> onProductTap;

  const StoreProductListScreen({
    super.key,
    this.onProductRequest,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return StoreProductListView(
      onAddProduct: onProductRequest,
      onProductTap: onProductTap,
    );
  }
}

class StoreProductListView extends StatefulWidget {
  final VoidCallback? onAddProduct;
  final ValueChanged<String> onProductTap;

  const StoreProductListView({
    super.key,
    this.onAddProduct,
    required this.onProductTap,
  });

  @override
  State<StoreProductListView> createState() => _StoreProductListViewState();
}

class _StoreProductListViewState extends State<StoreProductListView> {
  final TextEditingController _searchController = TextEditingController();
  final ProductRepository _productRepository = ProductRepository.instance;

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
      final allProducts = await _productRepository.getAll();

      allProducts.shuffle();

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
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          _listTitle,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: widget.onAddProduct,
          ),
        ],
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
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xFFEBEFF4),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
        ),
      ),
      body: _buildBody(),
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
      return Center(child: Text('No products found.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _filteredProducts.length,
      itemBuilder: (context, index) {
        final product = _filteredProducts[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: ProductListCard(
            product: product,
            onTap: () => widget.onProductTap.call(product.id),
          ),
        );
      },
    );
  }
}
