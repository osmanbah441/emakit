// map_extensions.dart

import 'package:domain_models/domain_models.dart';

extension ProductDetailsMapToDomain on Map<String, dynamic> {
  Product get toDomainProductDetails {
    return Product(
      id: this['product_id'] as String,
      name: this['product_name'] as String,
      description: this['description'] as String,
      specifications: this['specifications'] as Map<String, dynamic>,
      categoryId: this['category_id'] as String,

      mainProductMedia: (this['media'] as List<dynamic>)
          .map((item) => (item as Map<String, dynamic>)._toMedia())
          .toList(),
    );
  }

  // AttributeValue _toAttributeValue() {
  //   return AttributeValue(
  //     attributeId: this['attribute_id'] as String,
  //     attributeName: this['attribute_name'] as String,
  //     attributeValue: this['attribute_value'] as String,
  //   );
  // }

  ProductMedia _toMedia() {
    return ProductMedia(
      url: this['url'] as String,
      altText: this['alt_text'] as String,
    );
  }
}
