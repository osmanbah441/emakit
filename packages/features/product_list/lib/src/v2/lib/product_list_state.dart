part of 'product_list_cubit.dart';

abstract class ProductListState {}

class ProductInitial extends ProductListState {}

class ProductLoading extends ProductListState {}

class ProductLoaded extends ProductListState {
  final List<Product> allProducts;
  final List<ProductCategory> categories;
  final ProductCategory? activeCategory;

  ProductLoaded({
    required this.allProducts,
    required this.categories,
    this.activeCategory,
  });

  ProductLoaded copyWith({
    List<Product>? allProducts,
    ProductCategory? activeCategory,
  }) {
    return ProductLoaded(
      allProducts: allProducts ?? this.allProducts,
      categories: categories,
      activeCategory: activeCategory,
    );
  }
}

class ProductError extends ProductListState {
  final String message;
  ProductError(this.message);
}
