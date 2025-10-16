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
  final String name;
  final String categoryId;
  final ProductStatus status;
  final List<ProductVariation> variations;
  final String storeId;
  final dynamic specifications;

  const Product({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.storeId,
    this.status = ProductStatus.draft,
    this.variations = const [],
    this.specifications,
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
