import 'package:domain_models/domain_models.dart';

class ProductFormData {
  final String name;
  final String manufacturer;
  final String description;
  final String categoryId;
  final Map<String, String> specifications;
  final List<ProductAttributeField> variationAttributes;

  ProductFormData({
    required this.name,
    required this.manufacturer,
    required this.description,
    required this.categoryId,
    required this.specifications,
    required this.variationAttributes,
  });
}
