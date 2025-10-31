import 'package:domain_models/src/attribute_data_type.dart';

class LinkCategoryToAtrributes {
  final String attributeId;
  final bool isRequired;
  final bool isVariant;
  final AttributeDataType dataType;
  final String attributeName;
  final List<String> options;

  LinkCategoryToAtrributes({
    required this.attributeId,
    this.isRequired = false,
    this.isVariant = false,
    this.dataType = AttributeDataType.text,
    required this.attributeName,
    this.options = const [],
  });
}
