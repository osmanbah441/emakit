import 'package:flutter/material.dart';
import 'package:domain_models/domain_models.dart';
import 'package:product_repository/product_repository.dart';
import 'package:product_variation/src/components/variation_list_item.dart';

class ProductVariationListScreen extends StatelessWidget {
  final String productId;
  final VoidCallback onAddVariation;
  final VoidCallback onProductTap;
  final ProductRepository productRepository;

  const ProductVariationListScreen({
    super.key,
    required this.productRepository,
    required this.productId,
    required this.onAddVariation,
    required this.onProductTap,
  });

  Future<Product> _fetchProductData() async {
    return await productRepository.getBuyerProductDetails(productId: productId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Product>(
      future: _fetchProductData(),
      builder: (context, snapshot) {
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;
        final textTheme = theme.textTheme;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error loading product data.',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.error,
                  ),
                ),
              ),
            ),
          );
        }

        final product = snapshot.data!;
        final activeVariations = product.variantsDepricated;
        final baseProductName = product.name;

        final Widget tabBarWidget = Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: theme.dividerColor, width: 1.0),
            ),
          ),
          child: TabBar(
            tabs: const [
              Tab(text: 'Active'),
              Tab(text: 'Needs Attention'),
            ],
            indicatorColor: colorScheme.primary,
            labelColor: colorScheme.primary,
            unselectedLabelColor: colorScheme.onSurfaceVariant,
            labelStyle: textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.normal,
            ),
          ),
        );

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: GestureDetector(
                onTap: onProductTap,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Base Product',
                      style: textTheme.labelSmall?.copyWith(),
                    ),
                    Text(
                      baseProductName,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              centerTitle: false,
              elevation: 0,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tabBarWidget,
                Expanded(
                  child: TabBarView(
                    children: [
                      activeVariations.isEmpty
                          ? Center(
                              child: Text(
                                'No active variations found.',
                                style: textTheme.bodyMedium,
                              ),
                            )
                          : ListView.separated(
                              itemCount: activeVariations.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(height: 1),
                              itemBuilder: (context, index) {
                                return VariationListItem(
                                  variation: activeVariations[index],
                                  imageUrl: product.mainProductMedia.first.url,
                                );
                              },
                            ),
                      Center(
                        child: Text(
                          'No variations needing attention.',
                          style: textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            floatingActionButton: FloatingActionButton(
              onPressed: onAddVariation,
              tooltip: 'Add New Variation',
              child: const Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }
}
