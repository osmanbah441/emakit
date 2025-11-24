/// Defines the possible data types for product attributes (variants and specifications).
enum AttributeDataType {
  dropdown,
  text,
  number,
  boolean,
  unknown; // A fallback for unexpected values

  /// Converts a string from the JSON/data source into an AttributeDataType enum value.
  static AttributeDataType fromString(String value) {
    return switch (value.toLowerCase()) {
      'dropdown' => AttributeDataType.dropdown,
      'text' => AttributeDataType.text,
      'number' => AttributeDataType.number,
      'boolean' => AttributeDataType.boolean,
      _ => AttributeDataType.unknown, // Handle unknown string values gracefully
    };
  }

  String get displayString {
    return name.replaceFirst(name[0], name[0].toUpperCase());
  }
}

class ProductAttributeField {
  final String name;
  final String? unit; // Nullable (e.g., 'kg', 'cm', or null)
  final List<String>? options; // Nullable (only used for 'dropdown' type)
  final AttributeDataType dataType;

  ProductAttributeField({
    required this.name,
    this.unit,
    this.options,
    required this.dataType,
  });

  factory ProductAttributeField.fromJson(Map<String, dynamic> json) {
    return ProductAttributeField(
      name: json['name'] as String,
      unit: json['unit'] as String?,
      // Check if options exists and map it, otherwise it is null
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      // Use the static helper method to safely convert the string to the enum
      dataType: AttributeDataType.fromString(json['data_type'] as String),
    );
  }
}

// --- 3. Main Class: ProductCategory ---

class ProductCategory {
  final String categoryId;
  final String fullPathName;
  final String categoryImageUrl;
  final List<ProductAttributeField> variantFields;
  final List<ProductAttributeField> specificationFields;

  ProductCategory({
    required this.categoryId,
    required this.fullPathName,
    required this.categoryImageUrl,
    required this.variantFields,
    required this.specificationFields,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    // Helper function to map a list of maps into a list of ProductAttributeField objects
    List<ProductAttributeField> mapFields(List<dynamic> list) {
      return list
          .map(
            (item) =>
                ProductAttributeField.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    }

    return ProductCategory(
      categoryId: json['category_id'] as String,
      fullPathName: json['full_path_name'] as String,
      categoryImageUrl: json['category_image_url'] as String,
      variantFields: mapFields(json['variant_fields'] as List<dynamic>),
      specificationFields: mapFields(
        json['specification_fields'] as List<dynamic>,
      ),
    );
  }
}
