// product_list_state.dart

part of 'product_list_cubit.dart';

abstract class ProductListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductListState {}

class ProductLoading extends ProductListState {}

class ProductLoaded extends ProductListState {
  final List<Product> allProducts;
  final List<Category> categories;
  final Category? selectedSubCategory;
  final Category topLevelCategory;
  final bool isProductLoading;

  ProductLoaded({
    required this.allProducts,
    required this.categories,
    required this.topLevelCategory,
    this.selectedSubCategory,
    this.isProductLoading = false,
  });

  ProductLoaded copyWith({
    List<Product>? allProducts,
    List<Category>? categories,
    Category? selectedSubCategory,
    bool? isProductLoading,
    Object? clearSelectedSubCategory = const Object(),
  }) {
    return ProductLoaded(
      allProducts: allProducts ?? this.allProducts,
      categories: categories ?? this.categories,
      selectedSubCategory: clearSelectedSubCategory != const Object()
          ? null
          : selectedSubCategory ?? this.selectedSubCategory,
      topLevelCategory: topLevelCategory,
      isProductLoading: isProductLoading ?? this.isProductLoading,
    );
  }

  @override
  List<Object?> get props => [
    allProducts,
    categories,
    selectedSubCategory,
    topLevelCategory,
    isProductLoading,
  ];
}

class ProductError extends ProductListState {
  final String message;
  ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
