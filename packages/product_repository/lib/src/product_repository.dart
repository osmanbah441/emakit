import 'dart:typed_data';

import 'package:domain_models/domain_models.dart';
import 'package:product_repository/src/product_repository_impl.dart';

abstract class ProductRepository {
  static const ProductRepository instance = ProductRepositoryImpl();

  Future<List<Product>> getAllProductsFromSubCategories(List<String> ids);

  Future<List<Product>> getAllProducts({
    String? searchTerm,
    String? categoryId,
  });

  Future<Product?> getProductById(String productId);

  // TODO: remove
  Future<Map<String, List<Product>>> getProductsForAllCateggeories();

  Future<void> createNewProduct({
    required String name,
    required String description,
    required Map<String, dynamic> specs,
    required Map<String, dynamic> attributes,
    required String category,
    required List<({Uint8List bytes, String mimeType})> imagesData,
    required double price,
    required int availableStock,
  });

  Future<void> updateProduct(Product product);

  Future<void> deleteProduct(String productId);
}
