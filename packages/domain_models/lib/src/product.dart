class Product {
  final String? id;
  final String name;
  final String description;
  final String? imageUrl;
  final Map<String, dynamic> specifications;
  final List<ProductVariation> variations;

  const Product({
    this.id,
    required this.name,
    this.description = '',
    this.variations = const [],
    this.specifications = const {},
    this.imageUrl,
  });
}

class ProductVariation {
  final String id;
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
    required this.stockQuantity,
    this.storeId,
    this.storeName,
  });
}
