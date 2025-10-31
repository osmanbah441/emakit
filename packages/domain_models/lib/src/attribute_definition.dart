import 'package:domain_models/src/attribute_data_type.dart';

class AttributeDefinition {
  final String? id;
  final String name;
  final AttributeDataType dataType;
  final String? unit;
  final List<String>? options;

  AttributeDefinition({
    this.id,
    required this.name,
    this.dataType = AttributeDataType.text,
    this.unit,
    this.options,
  });
}
