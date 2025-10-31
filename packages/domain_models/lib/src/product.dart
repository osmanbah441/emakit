import 'package:domain_models/domain_models.dart';

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
  final String description;
  final Store? store;
  final ProductStatus status;
  final Map<String, dynamic> specifications;
  final List<StoreVariation> variantsDepricated;
  final List<ProductMedia> mainProductMedia;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    this.status = ProductStatus.draft,
    this.specifications = const {},
    this.categoryId = '',
    this.store,
    this.variantsDepricated = const [],
    this.mainProductMedia = const [],
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
