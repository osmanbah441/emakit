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

enum ProductStatus {
  draft,
  active,
  archived;

  static ProductStatus fromString(String? status) {
    if (status != null && status.isNotEmpty) {
      try {
        return ProductStatus.values.byName(status.toLowerCase());
      } catch (_) {
        return ProductStatus.draft;
      }
    }
    return ProductStatus.draft;
  }
}

class Product {
  final String id;
  final String name;
  final String categoryId;
  final String? description;
  final ProductStatus status;
  final Map<String, dynamic>? specifications;
  final String? imageUrl;

  const Product({
    required this.id,
    required this.name,
    required this.categoryId,
    this.description,
    this.status = ProductStatus.archived,
    this.specifications,
    this.imageUrl,
  });
}

class ProductMedia {
  final String? id;
  final String? productId;
  final String url;
  final String? altText;
  final String? role;

  ProductMedia({
    this.id,
    this.productId,
    required this.url,
    this.altText,
    this.role,
  });
}

class ProductWithAttributes {
  final String productId;
  final String productName;
  final List<ProductVariantAttribute> attributes;

  const ProductWithAttributes({
    required this.productId,
    required this.productName,
    required this.attributes,
  });
}

class ProductVariantAttribute {
  final String attributeId;
  final String attributeName;
  final List<String> options;

  const ProductVariantAttribute({
    required this.attributeId,
    required this.attributeName,
    required this.options,
  });
}
