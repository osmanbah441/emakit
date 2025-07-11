class ProductExtractionException implements Exception {
  final String message;

  ProductExtractionException(this.message);

  @override
  String toString() {
    return 'ProductExtractionException: $message';
  }
}

class ProductExtractionListingData {
  final String productName;
  final String productDescription;
  final Map<String, String> categorySpecificationFields;
  final Map<String, List<String>> variationAttributes;
  final String selectedChildCategoryId;

  ProductExtractionListingData({
    required this.productName,
    required this.productDescription,
    required this.categorySpecificationFields,
    required this.variationAttributes,
    required this.selectedChildCategoryId,
  });

  factory ProductExtractionListingData.fromJson(Map<String, dynamic> json) {
    return ProductExtractionListingData(
      productName: json['productName'] as String,
      productDescription: json['productDescription'] as String,
      categorySpecificationFields: Map<String, String>.from(
        json['categorySpecificationFields'] as Map,
      ),
      variationAttributes: (json['variationAttributes'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, List<String>.from(value as List))),
      selectedChildCategoryId: json['selectedChildCategoryId'] as String,
    );
  }
}
