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

  const ProductVariation({
    required this.id,
    required this.productId,
    required this.price,
    required this.stockQuantity,
    required this.attributes,
    this.imageUrls = const [],
  });
}

class Product {
  final String id;
  final String name;
  final double basePrice;
  final String categoryId;
  final List<String> images;
  final ProductStatus status;
  final List<ProductVariation> variations;
  final String storeId;

  /// Holds the category-specific object (e.g., an instance of `ClothingDetails`).
  final dynamic details;

  const Product({
    required this.id,
    required this.name,
    required this.basePrice,
    required this.categoryId,
    required this.storeId,
    this.images = const [],
    this.status = ProductStatus.draft,
    this.variations = const [],
    this.details,
  });
}
