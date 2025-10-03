enum ProductStatus { active, inactive, draft }

enum MeasurementUnit { inches, centimeters }

enum MeasurementType {
  bust,
  waist,
  hip,
  length,
  shoulder,
  sleeveLength,
  neck,
  inseam,
  thigh,
}

class Measurement {
  final double inches;

  const Measurement({required this.inches});

  double get centimeters => inches * 2.54;

  String display(MeasurementUnit unit) {
    if (unit == MeasurementUnit.centimeters) {
      return '${centimeters.toStringAsFixed(1)} cm';
    }
    return '${inches.toStringAsFixed(1)}"';
  }
}

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

class ClothingDetails {
  final bool isTailored;
  final bool allowsPersonalization;
  final List<MeasurementType> requiredMeasurements;

  const ClothingDetails({
    required this.isTailored,
    this.allowsPersonalization = false,
    this.requiredMeasurements = const [],
  });
}

class ShoeDetails {
  final String style;
  final String material;
  final Map<String, String> sizeChart;

  const ShoeDetails({
    required this.style,
    required this.material,
    this.sizeChart = const {},
  });
}

class ProductVariation {
  final String id;
  final String productId;
  final double price;
  final int stockQuantity;
  final Map<String, String> attributes;
  final List<String> imageUrls;
  final double? listPrice;
  const ProductVariation({
    required this.id,
    required this.productId,
    required this.price,
    required this.stockQuantity,
    required this.attributes,
    this.listPrice,
    this.imageUrls = const [],
  });

  /*
 Formula for a Good Variation Name:

[Product Name] - [Attribute 1 Value], [Attribute 2 Value], ...

Examples (using the products above):

For Nike Dri-FIT T-shirt:

Nike Dri-FIT T-shirt - Red, Medium

Nike Dri-FIT T-shirt - Blue, Large

For Apple iPhone 15 Pro:

Apple iPhone 15 Pro - 256GB, Blue Titanium

Apple iPhone 15 Pro - 512GB, Natural Titanium

For IKEA HEMNES 3-Drawer Chest:

IKEA HEMNES 3-Drawer Chest - White Stain

IKEA HEMNES 3-Drawer Chest - Black-brown
 */

  String getDisplayName(String productName) {
    // Check if the attributes map is not empty
    if (attributes.isNotEmpty) {
      final attributesString = attributes.entries
          .map((e) => e.value)
          .join(', ');
      return '$productName - $attributesString';
    } else {
      // If there are no attributes, just return the product name
      return productName;
    }
  }
}

class Product {
  final String id;
  /*
  Formula for a Good Product Name:

[Brand Name] + [Product Type] + [Key Differentiator]

Examples:

Nike Dri-FIT T-shirt

Apple iPhone 15 Pro

L'Oréal Paris Hyaluronic Acid Serum

IKEA HEMNES 3-Drawer Chest

 */
  final String name;
  final String categoryId;
  final ProductStatus status;
  final List<ProductVariation> variations;
  final String storeId;

  /// Holds the category-specific object (e.g., an instance of `ClothingDetails`).
  final dynamic details;

  const Product({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.storeId,
    this.status = ProductStatus.draft,
    this.variations = const [],
    this.details,
  });

  String? get primaryImageUrl =>
      variations.isNotEmpty && variations.first.imageUrls.isNotEmpty
      ? variations.first.imageUrls.first
      : null;

  double get displayPrice =>
      variations.isNotEmpty ? variations.first.price : 0.0;

  ProductVariation getVariationById({String? id}) {
    if (variations.isEmpty) throw Exception('No variations available');
    if (id == null) return variations.first;
    return variations.firstWhere((v) => v.id == id);
  }
}
