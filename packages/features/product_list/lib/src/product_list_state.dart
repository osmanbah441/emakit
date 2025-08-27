part of 'product_list_cubit.dart';

abstract class ProductListState {}

class ProductInitial extends ProductListState {}

class ProductLoading extends ProductListState {}

class ProductLoaded extends ProductListState {
  final List<Product> allProducts;
  final List<ProductCategory> categories;
  final ProductCategory? selectedSubCategory;
  final ProductCategory? topLevelCategory;

  ProductLoaded({
    required this.allProducts,
    required this.categories,
    this.selectedSubCategory,
    this.topLevelCategory,
  });

  ProductLoaded copyWith({
    List<Product>? allProducts,
    ProductCategory? selectedSubCategory,
  }) {
    return ProductLoaded(
      allProducts: allProducts ?? this.allProducts,
      categories: categories,
      selectedSubCategory: selectedSubCategory,
    );
  }
}

class ProductError extends ProductListState {
  final String message;
  ProductError(this.message);
}
