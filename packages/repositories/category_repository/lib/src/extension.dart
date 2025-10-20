import 'package:domain_models/domain_models.dart';

extension ProductCategoryToDomain on Map<String, dynamic> {
  Category get toDomainCategory {
    final rawAttributes = this['attributes'] as List<dynamic>? ?? const [];

    final attributes = [
      for (final c in rawAttributes)
        if (c case {
          'attribute_id': String id,
          'is_required': bool? required,
          'is_variant': bool? variant,
          'data_type': String? dataType,
          'attribute_name': String? name,
          'options': List<dynamic>? rawOptions,
        })
          LinkCategoryToAtrributes(
            attributeId: id,
            isRequired: required ?? false,
            isVariant: variant ?? false,
            dataType: AttributeDataType.fromString(dataType),
            attributeName: name ?? '',
            options: (rawOptions ?? [])
                .whereType<Map<String, dynamic>>()
                .map((optionMap) => optionMap['option_value'] as String?)
                .where((value) => value != null)
                .map((value) => value!)
                .toList(),
          ),
    ];
    return Category(
      id: this['id'] as String,
      name: this['name'] as String,

      description: this['description'] as String?,
      imageUrl:
          this['image_url'] as String? ??
          'https://placehold.co/600x337?text=New+Category',
      parentId: this['parent_id'] as String?,
      attributes: attributes,
    );
  }

  AttributeDefinition get toDomainAttribute {
    final options = (this['options'] as List? ?? [])
        .map((e) => e['value'] as String)
        .toList();

    return AttributeDefinition(
      id: this['id'],
      name: this['name'],
      dataType: AttributeDataType.fromString(this['data_type']),
      unit: this['unit'],
      options: options,
    );
  }
}

extension ProductCategoryFromDomain on Category {
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'image_url': imageUrl,
    'description': description,
    'parent_id': parentId,
  };
}

extension ProductAttributeFromDomain on AttributeDefinition {
  Map<String, dynamic> toMap() {
    return {
      'p_attr_name': name,
      'p_attr_data_type': dataType,
      'p_attr_unit': unit,
      'p_option_list': options,
    };
  }
}
