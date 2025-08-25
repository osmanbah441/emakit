import 'package:domain_models/domain_models.dart';

import 'dart:math';
import 'dart:typed_data';

import 'product_repository.dart';

const _categories = [
  'women-dresses',
  'women-tops',
  'women-tops-t-shirts',
  'women-tops-blouses',
  'women-outerwear',
  'women-outerwear-jackets',
  'women-outerwear-coats',
  'men-shirts',
  'men-shirts-casual',
  'men-shirts-formal',
  'men-trousers',
  'men-trousers-chinos',
  'men-trousers-jeans',
  'men-outerwear',
  'men-outerwear-blazers',
  'men-outerwear-jackets',
  'kids-boys',
  'kids-boys-shorts',
  'kids-boys-hoodies',
  'kids-girls',
  'kids-girls-skirts',
  'kids-girls-dresses',
];

final List<Product> _allProducts = List.generate(
  100, // Generate 100 sample products in total
  (index) {
    final random = Random();
    final productId = 'product_$index';

    // Assign a category from the list in a cycle to ensure all are used
    final category = _categories[index % _categories.length];

    return Product(
      id: productId,
      name: '${category.split('-').last.capitalize()} #${random.nextInt(100)}',
      category: category,
      price: (random.nextInt(5) != 0) ? 20.0 + random.nextDouble() * 150 : null,
      imageUrl:
          'https://picsum.photos/seed/$productId/400/${400 + (index % 100)}',
    );
  },
);

// Helper extension to capitalize strings for product names
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl();

  /// Fetches products grouped by specific home screen sections.
  @override
  Future<Map<String, List<Product>>> getProductsForAllCateggeories() async {
    await Future.delayed(const Duration(milliseconds: 800));

    // Shuffle the database to get different "Trending" items each time.
    final shuffledProducts = List<Product>.from(_allProducts)..shuffle();

    return {
      'Trending': shuffledProducts.take(8).toList(),
      'For Women': _allProducts
          .where((p) => _categories.contains(p.category))
          .take(8)
          .toList(),
      'For Men': _allProducts
          .where((p) => _categories.contains(p.category))
          .take(8)
          .toList(),
      'For Kids': _allProducts
          .where((p) => _categories.contains(p.category))
          .take(8)
          .toList(),
    };
  }

  @override
  Future<List<Product>> getAllProducts({
    String? searchTerm,
    String? category,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    List<Product> results = List.from(_allProducts);

    if (category != null && category.toLowerCase() != 'all') {
      results = results
          .where((p) => p.category!.toLowerCase() == category.toLowerCase())
          .toList();
    }

    if (searchTerm != null && searchTerm.isNotEmpty) {
      results = results
          .where(
            (p) =>
                p.name.toLowerCase().contains(searchTerm.toLowerCase()) ||
                p.category!.toLowerCase().contains(searchTerm.toLowerCase()),
          )
          .toList();
    }
    return results;
  }

  @override
  Future<Product?> getProductById(String productId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      final Product sampleProduct = Product(
        storeName: 'SheKiss',
        name:
            'Womens African Attir Bohemian Dashiki Traditional Tribal Vintage Ethnic Midi Dresses',
        price: 24.88,
        images: [
          'https://picsum.photos/seed/picsum/800/800',
          'https://picsum.photos/seed/flutter/800/800',
          'https://picsum.photos/seed/dart/800/800',
          'https://picsum.photos/seed/widget/800/800',
        ],
        measurements: [
          ProductMeasurement(
            type: MeasurementType.bust,
            value: Measurement(inches: 36.6),
          ),
          ProductMeasurement(
            type: MeasurementType.waist,
            value: Measurement(inches: 31.9),
          ),
          ProductMeasurement(
            type: MeasurementType.hip,
            value: Measurement(inches: 42.9),
          ),
          ProductMeasurement(
            type: MeasurementType.length,
            value: Measurement(inches: 38.2),
          ),
          ProductMeasurement(
            type: MeasurementType.shoulder,
            value: Measurement(inches: 15.5),
          ),
          ProductMeasurement(
            type: MeasurementType.sleeveLength,
            value: Measurement(inches: 23.0),
          ),
        ],
        storeRating: 4.8,
        storeReviewCount: 12530,
      );

      return sampleProduct;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> createNewProduct({
    required String name,
    required String description,
    required Map<String, dynamic> specs,
    required Map<String, dynamic> attributes,
    required String category,
    required List<({Uint8List bytes, String mimeType})> imagesData,
    required double price,
    required int availableStock,
  }) {
    throw UnimplementedError(
      'createNewProduct is not implemented in this fake repository.',
    );
  }

  @override
  Future<void> deleteProduct(String productId) {
    throw UnimplementedError(
      'deleteProduct is not implemented in this fake repository.',
    );
  }

  @override
  Future<void> updateProduct(Product product) {
    throw UnimplementedError(
      'updateProduct is not implemented in this fake repository.',
    );
  }
}
