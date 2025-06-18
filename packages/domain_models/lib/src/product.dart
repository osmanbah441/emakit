class Product {
  final String id;
  final String name;
  final String description;
  final Map<String, dynamic> specifications;
  final List<ProductVariation> variations;
  final String mainCategory;
  final String storeName;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.variations,
    required this.specifications,
    required this.mainCategory,

    this.storeName = '',
  });
}

class ProductVariation {
  final String id;
  final Map<String, dynamic> attributes;
  final List<String> imageUrls;
  final double price;
  final int stockQuantity;

  const ProductVariation({
    required this.id,
    required this.attributes,
    required this.imageUrls,
    required this.price,
    required this.stockQuantity,
  });
}
