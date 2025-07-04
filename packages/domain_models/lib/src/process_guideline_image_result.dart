import "product.dart";

class ProcessGuidelineImageResult {
  final List<Product> similarProducts;
  final Map<String, dynamic> productSpecificationData;
  final List<Map<String, dynamic>> variationDefinationData;
  final Product generatedProduct;
  final ProductVariation generatedProductVariation;

  ProcessGuidelineImageResult({
    required this.similarProducts,
    required this.productSpecificationData,
    required this.variationDefinationData,
    required this.generatedProduct,
    required this.generatedProductVariation,
  });
}
