enum AttributeDataType {
  dropdown,
  text,
  number;

  String get displayString {
    return name.replaceFirst(name[0], name[0].toUpperCase());
  }

  static AttributeDataType fromString(String? type) {
    if (type != null && type.isNotEmpty) {
      try {
        return AttributeDataType.values.byName(type.toLowerCase());
      } catch (_) {
        return AttributeDataType.text;
      }
    }
    return AttributeDataType.text;
  }
}

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

class Category {
  final String? id;
  final String name;
  final String imageUrl;
  final String? description;
  final String? parentId;
  final List<LinkCategoryToAtrributes> attributes;

  const Category({
    this.id,
    required this.name,
    required this.imageUrl,
    this.description,
    this.parentId,
    this.attributes = const [],
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'ProductCategory(id: $id, name: $name)';
}
