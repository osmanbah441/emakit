import "product.dart";

class ExtractedProductInfo {
  final List<Product> similarProducts;
  final Map<String, List<String>> variationDefinationData;
  final Product generatedProduct;

  ExtractedProductInfo({
    required this.similarProducts,
    required this.variationDefinationData,
    required this.generatedProduct,
  });
}
