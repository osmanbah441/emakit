class Product {
  final String? id;
  final String name;
  final String description;
  final String? categoryId;
  final String? imageUrl;
  final ProductStatus? status;
  final Map<String, dynamic> specifications;
  final List<ProductVariation> variations;

  const Product({
    this.id,
    required this.name,
    this.description = '',
    this.categoryId,
    this.variations = const [],
    this.status,
    this.specifications = const {},
    this.imageUrl,
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
  final String? storeName;

  const ProductVariation({
    required this.id,
    required this.attributes,
    required this.imageUrls,
    required this.price,
    this.productId,
    this.status,
    required this.stockQuantity,
    this.storeId,
    this.storeName,
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
