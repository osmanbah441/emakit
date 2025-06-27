part of 'add_edit_product_cubit.dart';

class AddEditProductState {
  const AddEditProductState({
    this.currentStep = 0,
    this.guidelineImage,
    this.currentProgressIndicator = 0.0,
    this.similarProducts = const [],
    this.detectedSimilarProduct,
    this.selectedParentProduct,
    this.isCreatingFromExistingProduct = false,
    this.isPotentialDuplicateDetected = false,
    this.productVariationData = const {},
    this.productSpecificationData = const {},
    this.uploadedImages = const [],
  });

  final int currentStep;
  final double currentProgressIndicator;
  final ({String mimeType, Uint8List bytes})? guidelineImage;
  final List<Product> similarProducts;
  final Product? detectedSimilarProduct;
  final Product? selectedParentProduct;
  final bool isCreatingFromExistingProduct;
  final bool isPotentialDuplicateDetected;
  final Map<String, dynamic> productVariationData;
  final Map<String, dynamic> productSpecificationData;
  final List<(String mimeType, Uint8List bytes)> uploadedImages;

  AddEditProductState copyWith({
    int? currentStep,
    ({String mimeType, Uint8List bytes})? guidelineImage,
    List<Product>? similarProducts,
    Product? detectedSimilarProduct,
    Product? selectedParentProduct,
    bool? isCreatingFromExistingProduct,
    bool? isPotentialDuplicateDetected,
    Map<String, dynamic>? productVariationData,
    Map<String, dynamic>? productSpecificationData,
    List<(String mimeType, Uint8List bytes)>? uploadedImages,
    double? currentProgressIndicator,
  }) => AddEditProductState(
    currentStep: currentStep ?? this.currentStep,
    guidelineImage: guidelineImage ?? this.guidelineImage,
    similarProducts: similarProducts ?? this.similarProducts,
    detectedSimilarProduct:
        detectedSimilarProduct ?? this.detectedSimilarProduct,
    selectedParentProduct: selectedParentProduct ?? this.selectedParentProduct,
    isCreatingFromExistingProduct:
        isCreatingFromExistingProduct ?? this.isCreatingFromExistingProduct,
    isPotentialDuplicateDetected:
        isPotentialDuplicateDetected ?? this.isPotentialDuplicateDetected,
    productVariationData: productVariationData ?? this.productVariationData,
    productSpecificationData:
        productSpecificationData ?? this.productSpecificationData,
    uploadedImages: uploadedImages ?? this.uploadedImages,
    currentProgressIndicator:
        currentProgressIndicator ?? this.currentProgressIndicator,
  );
}

// TODO: replace with actual product model
final class Product {
  final String imageUrl;
  final String title;
  final String subtitle;

  const Product({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });
}
