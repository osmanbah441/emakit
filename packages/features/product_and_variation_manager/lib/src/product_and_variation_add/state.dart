part of 'cubit.dart';

sealed class ProductAddVariationState {}

class ProductAddVariationInitial extends ProductAddVariationState {}

class ProductAddVariationLoading extends ProductAddVariationState {}

class ProductAddVariationSearchSuccess extends ProductAddVariationState {
  ProductAddVariationSearchSuccess({
    this.name,
    this.manufacturer,
    this.categoryId,
    this.description,
    this.specs,
    this.products = const [],
    this.categories = const [],
    this.isNewVariation,
    this.selectedProduct,
  });

  final String? name;
  final String? manufacturer;
  final String? categoryId;
  final String? description;
  final Map<String, String>? specs;
  final List<StoreProduct> products;
  final List<ProductCategory> categories;
  final StoreProduct? selectedProduct;
  final bool? isNewVariation;

  ProductAddVariationSearchSuccess copyWith({
    String? name,
    String? manufacturer,
    String? categoryId,
    String? description,
    Map<String, String>? specs,
    List<StoreProduct>? products,
    List<ProductCategory>? categories,
    bool? isNewVariation,
    StoreProduct? selectedProduct,
  }) {
    return ProductAddVariationSearchSuccess(
      name: name ?? this.name,
      manufacturer: manufacturer ?? this.manufacturer,
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      specs: specs ?? this.specs,
      products: products ?? this.products,
      categories: categories ?? this.categories,
      isNewVariation: isNewVariation ?? this.isNewVariation,
      selectedProduct: selectedProduct ?? this.selectedProduct,
    );
  }
}
