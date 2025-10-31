import 'package:flutter/material.dart';
import 'package:domain_models/domain_models.dart';
import 'package:product_repository/product_repository.dart';

class AdminProductListScreen extends StatefulWidget {
  final VoidCallback onAddProduct;
  final Function(String) onEditProduct;
  final ProductRepository productRepository;
  const AdminProductListScreen({
    super.key,
    required this.onAddProduct,
    required this.onEditProduct,
    required this.productRepository,
  });

  @override
  State<AdminProductListScreen> createState() => _AdminProductListScreenState();
}

class _AdminProductListScreenState extends State<AdminProductListScreen> {
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() async {
    _productsFuture = widget.productRepository.getAll(ApplicationRole.admin);
  }

  void _refreshProducts() {
    setState(() {
      _fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: _refreshProducts,
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh List'),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: widget.onAddProduct,
                icon: const Icon(Icons.add),
                label: const Text('Add New Product'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        Expanded(
          child: Card(
            child: FutureBuilder<List<Product>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Text('Error loading products: ${snapshot.error}'),
                    ),
                  );
                }

                final products = snapshot.data ?? [];

                if (products.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Text(
                        'No products added yet.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF757575),
                        ),
                      ),
                    ),
                  );
                }

                return PaginatedDataTable(
                  header: const Text('All Products'),
                  columns: const [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Category')),
                    DataColumn(label: Text('Attributes')),
                    DataColumn(label: Text('Actions')),
                  ],
                  source: _ProductDataSource(
                    products: products,
                    onEdit: widget.onEditProduct,
                  ),
                  rowsPerPage: 5,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _ProductDataSource extends DataTableSource {
  final List<Product> products;
  final ValueChanged<String> onEdit;

  _ProductDataSource({required this.products, required this.onEdit});

  @override
  DataRow? getRow(int index) {
    if (index >= products.length) return null;
    final product = products[index];

    final String category = product.categoryId;
    final String attributesDisplay = 'N/A';

    return DataRow(
      cells: [
        DataCell(Text(product.id)),
        DataCell(Text(product.name)),
        DataCell(Text(category)),
        DataCell(
          Text(
            attributesDisplay,
            style: const TextStyle(
              color: Color(0xFF757575),
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        DataCell(
          TextButton(
            onPressed: () => onEdit(product.id),
            child: const Text('Edit'),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => products.length;

  @override
  int get selectedRowCount => 0;
}
