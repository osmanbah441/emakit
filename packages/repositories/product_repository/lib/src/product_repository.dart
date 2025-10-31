import 'package:domain_models/domain_models.dart';

abstract class ProductRepository {
  // static const ProductRepository instance = ProductRepositoryImpl();

  Future<List<Product>> getAll(
    ApplicationRole role, {
    String? searchTerm,
    String? categoryId,
  });

  Future<Product?> getById(String productId);

  Future<Map<String, List<Product>>> getProductsForAllCateggeories();

  Future<void> upsert({
    String? id,
    required String name,
    required String description,
    required Map<String, dynamic>? specs,
    required String categoryId,
    required List<ProductMedia> imageUrls,
  });

  Future<ProductWithAttributes> getProductWithAttributes(String productId);

  Future<void> insertProductVariant({
    required String productId,
    required String storeId,
    required int price,
    required int stock,
    required Map<String, String> attributes,
    required List<String> imageUrls,
  });

  Future<Product> getProductDetails({String? productId, String? variantId});
}
