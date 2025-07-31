part of 'add_edit_product_cubit.dart';

enum AddEditProductStatus {
  initial,
  loading,
  success,
  error,
  submitting,
  potentailDuplicateDetected,
}

enum AddEditProductStep { guideLineImage, newProduct }

class AddEditProductState {
  const AddEditProductState({
    this.status = AddEditProductStatus.initial,
    this.currentStep = AddEditProductStep.guideLineImage,
    this.guidelineImage,
    this.similarProducts = const [],
    this.detectedSimilarProduct,
    this.errorMessage,
    this.extractedProductInfo,
    this.imagesData,
    this.price,
    this.availableStock,
    this.variationAttributes,
    this.isVariationValid = false,
    this.description,
    this.subcategoryId,
    this.specs,
  });

  final AddEditProductStatus status;
  final AddEditProductStep currentStep;
  final ({String mimeType, Uint8List bytes})? guidelineImage;
  final List<Product> similarProducts;
  final Product? detectedSimilarProduct;
  final String? errorMessage;
  final ExtractedProductInfo? extractedProductInfo;
  final bool? isVariationValid;
  final List<({Uint8List bytes, String mimeType})>? imagesData;
  final double? price;
  final int? availableStock;
  final Map<String, dynamic>? variationAttributes;
  final String? description;
  final String? subcategoryId;
  final Map<String, dynamic>? specs;

  AddEditProductState copyWith({
    AddEditProductStatus? status,
    AddEditProductStep? currentStep,
    ({String mimeType, Uint8List bytes})? guidelineImage,
    Product? detectedSimilarProduct,
    String? errorMessage,
    ExtractedProductInfo? extractedProductInfo,
    bool? isVariationValid,
    List<({Uint8List bytes, String mimeType})>? imagesData,
    double? price,
    int? availableStock,
    Map<String, dynamic>? variationAttributes,
    String? description,
    String? subcategoryId,
    Map<String, dynamic>? specs,
  }) {
    return AddEditProductState(
      status: status ?? this.status,
      currentStep: currentStep ?? this.currentStep,
      guidelineImage: guidelineImage ?? this.guidelineImage,
      detectedSimilarProduct:
          detectedSimilarProduct ?? this.detectedSimilarProduct,
      errorMessage: errorMessage ?? this.errorMessage,
      extractedProductInfo: extractedProductInfo ?? this.extractedProductInfo,
      imagesData: imagesData ?? this.imagesData,
      availableStock: availableStock ?? this.availableStock,
      variationAttributes: variationAttributes ?? this.variationAttributes,
      price: price ?? this.price,
      description: description ?? this.description,
      isVariationValid: isVariationValid ?? this.isVariationValid,
      specs: specs ?? this.specs,
      subcategoryId: subcategoryId ?? this.subcategoryId,
    );
  }
}
