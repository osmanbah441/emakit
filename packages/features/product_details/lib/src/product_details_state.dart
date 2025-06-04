part of 'product_details_cubit.dart';

enum ProductDetailsStatus { initial, loading, success, failure }

class ProductDetailsState {
  final ProductDetailsStatus status;
  final Product? product;
  final ProductVariation? selectedVariation;
  final List<ProductVariation> allVariations;
  final LinkedHashMap<String, LinkedHashSet<dynamic>> availableAttributes;
  final Map<String, dynamic> currentSelectedAttributes;
  final String? error;

  ProductDetailsState({
    this.status = ProductDetailsStatus.initial,
    this.product,
    this.selectedVariation,
    this.allVariations = const [],
    LinkedHashMap<String, LinkedHashSet<dynamic>>? availableAttributes,
    this.currentSelectedAttributes = const {},
    this.error,
  }) : availableAttributes = availableAttributes ?? LinkedHashMap.identity();

  ProductDetailsState copyWith({
    ProductDetailsStatus? status,
    Product? product,
    ProductVariation? selectedVariation,
    List<ProductVariation>? allVariations,
    LinkedHashMap<String, LinkedHashSet<dynamic>>? availableAttributes,
    Map<String, dynamic>? currentSelectedAttributes,
    String? error,
    bool clearSelectedVariation = false,
  }) {
    return ProductDetailsState(
      status: status ?? this.status,
      product: product ?? this.product,
      selectedVariation: clearSelectedVariation
          ? null
          : (selectedVariation ?? this.selectedVariation),
      allVariations: allVariations ?? this.allVariations,
      availableAttributes: availableAttributes ?? this.availableAttributes,
      currentSelectedAttributes:
          currentSelectedAttributes ?? this.currentSelectedAttributes,
      error: error ?? this.error,
    );
  }
}
