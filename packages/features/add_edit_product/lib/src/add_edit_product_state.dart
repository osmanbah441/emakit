part of 'add_edit_product_cubit.dart';

enum AddEditProductStatus {
  initial,
  loading,
  success,
  error,
  submitting,
  potentailDuplicateDetected,
}

enum AddEditProductStep {
  guideLineImage,
  similarProducts,
  newProduct,
  newVariation,
}

class AddEditProductState {
  const AddEditProductState({
    this.status = AddEditProductStatus.initial,
    this.currentStep = AddEditProductStep.guideLineImage,
    this.guidelineImage,
    this.currentProgressIndicator = 0.0,
    this.newProduct,
    this.newProductVariation,
    this.similarProducts = const [],
    this.detectedSimilarProduct,
    this.creatingFromExistingProduct,
    this.errorMessage,
    this.isFlaggedAsDuplicate = false,
    this.variationFields = const [], // NEW
  });

  final AddEditProductStatus status;
  final AddEditProductStep currentStep;
  final double currentProgressIndicator;
  final ({String mimeType, Uint8List bytes})? guidelineImage;
  final List<Product> similarProducts;
  final Product? newProduct;
  final ProductVariation? newProductVariation;
  final Product? detectedSimilarProduct;
  final Product? creatingFromExistingProduct;
  final bool isFlaggedAsDuplicate;
  final String? errorMessage;

  final List<Map<String, dynamic>> variationFields; // NEW

  AddEditProductState copyWith({
    AddEditProductStatus? status,
    AddEditProductStep? currentStep,
    ({String mimeType, Uint8List bytes})? guidelineImage,
    List<Product>? similarProducts,
    Product? newProduct,
    ProductVariation? newProductVariation,
    Product? detectedSimilarProduct,
    Product? creatingFromExistingProduct,
    double? currentProgressIndicator,
    String? errorMessage,
    bool? isFlaggedAsDuplicate,
    List<Map<String, dynamic>>? variationFields, // NEW
  }) {
    return AddEditProductState(
      status: status ?? this.status,
      currentStep: currentStep ?? this.currentStep,
      guidelineImage: guidelineImage ?? this.guidelineImage,
      similarProducts: similarProducts ?? this.similarProducts,
      detectedSimilarProduct:
          detectedSimilarProduct ?? this.detectedSimilarProduct,
      newProduct: newProduct ?? this.newProduct,
      newProductVariation: newProductVariation ?? this.newProductVariation,
      creatingFromExistingProduct:
          creatingFromExistingProduct ?? this.creatingFromExistingProduct,
      currentProgressIndicator:
          currentProgressIndicator ?? this.currentProgressIndicator,
      errorMessage: errorMessage ?? this.errorMessage,
      isFlaggedAsDuplicate: isFlaggedAsDuplicate ?? this.isFlaggedAsDuplicate,
      variationFields: variationFields ?? this.variationFields, // NEW
    );
  }
}
