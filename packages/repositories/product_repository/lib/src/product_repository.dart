import 'package:domain_models/domain_models.dart';

abstract class ProductRepository {
  Future<List<Product>> getBuyerProducts({
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

  Future<Product> getBuyerProductDetails({
    String? productId,
    String? variantId,
  });

  Future<List<StoreProduct>> getStoreProductWithOffer();

  Future<void> createProductWithVariationAndOffer({
    required String name,
    required String manufacturer,
    required String categoryId,
    required String description,
    required Map<String, String> specs,
    required double price,
    required int stock,
    required List<String> imageUrls,
    required Map<String, String> variationAttributes,
  });

  Future<void> createVariationAndOffer({
    required String productId,
    required String storeId,
    required double price,
    required int stock,
    required Map<String, String> attributes,
    required List<String> imageUrls,
  });

  Future<void> createOffer({
    required String variantId,
    required String storeId,
    required double price,
    required int stock,
  });

  Future<StoreProduct?>? getStoreProductVariantById(String id);

  Future<StoreProduct?>? getStoreProductById(String id);
}
