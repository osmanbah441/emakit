import 'package:domain_models/domain_models.dart';

extension ProductCategoryToDomain on Map<String, dynamic> {
  Category get toDomainCategory {
    // Safely get the raw list, defaulting to an empty list.
    final rawAttributes = this['attributes'] as List<dynamic>? ?? const [];

    final attributes = [
      for (final c in rawAttributes)
        // Use a pattern to ensure 'c' is a Map and that 'attribute_id' exists as a non-null String.
        if (c case {
          'attribute_id': String id,
          'is_required': bool? required,
          'is_variant': bool? variant,
        })
          LinkCategoryToAtrributes(
            attributeId: id,
            isRequired: required ?? false,
            isVariant: variant ?? false,
          ),
    ];

    return Category(
      // Simple, non-null fields
      id: this['id'] as String,
      name: this['name'] as String,

      // Nullable fields with safe defaults
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
