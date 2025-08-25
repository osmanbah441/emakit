import 'package:domain_models/domain_models.dart';

class ProductCategory {
  final String id;
  final String name;
  final String imageUrl;
  final String? description;
  final String? parentId;

  const ProductCategory({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.description,
    this.parentId,
  });
}

class Product {
  final String? id;
  final String name;
  final String description;
  final String? category;
  final String? imageUrl;
  final ProductStatus? status;
  final Map<String, dynamic> specifications;
  final List<ProductVariation> variations;
  final double? price;
  final String storeName;
  final List<String> images;
  final List<ProductMeasurement> measurements;
  final double storeRating;
  final int storeReviewCount;

  const Product({
    this.id,
    required this.name,
    this.description = '',
    this.category,
    this.variations = const [],
    this.status,
    this.specifications = const {},
    this.imageUrl,
    this.price,
    this.storeName = '',
    this.images = const [],
    this.measurements = const [],
    this.storeRating = 0.0,
    this.storeReviewCount = 0,
  });
}

class ProductVariation {
  final String id;
  final String? productId;
  final ProductStatus? status;
  final Map<String, dynamic> attributes;
  final List<String> imageUrls;
  final double price;
  final int stockQuantity;
  final String? storeId;
  final String storeName;

  const ProductVariation({
    required this.id,
    required this.attributes,
    required this.imageUrls,
    required this.price,
    this.productId,
    this.status,
    required this.stockQuantity,
    this.storeId,
    this.storeName = '',
  });
}

enum ProductStatus {
  active,
  inactive,
  draft,
  archived,
  outOfStock,
  unavailable;

  static ProductStatus fromString(String statusString) {
    return ProductStatus.values.firstWhere(
      (e) => e.name == statusString,
      orElse: () => ProductStatus.unavailable,
    );
  }
}
