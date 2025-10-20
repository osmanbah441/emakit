import 'package:domain_models/domain_models.dart';

sealed class ProductAddOrEditState {}

class ProductAddOrEditLoading extends ProductAddOrEditState {}

class ProductAddOrEditError extends ProductAddOrEditState {
  ProductAddOrEditError(this.message);
  final String message;
}

class ProductAddOrEditSuccess extends ProductAddOrEditState {
  ProductAddOrEditSuccess({
    this.productToEdit,
    required this.allCategories,
    this.selectedCategory,
    this.isLoading = false,
    this.errorMessage,
    this.saveCompleted = false,
  });

  final Product? productToEdit;
  final List<Category> allCategories;
  final Category? selectedCategory;
  final bool isLoading;
  final String? errorMessage;
  final bool saveCompleted;

  bool get isEditMode => productToEdit?.id != null;

  ProductAddOrEditSuccess copyWith({
    Product? productToEdit,
    List<Category>? allCategories,
    Category? selectedCategory,
    bool? isLoading,
    String? errorMessage,
    bool? saveCompleted,
  }) {
    return ProductAddOrEditSuccess(
      productToEdit: productToEdit ?? this.productToEdit,
      allCategories: allCategories ?? this.allCategories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      saveCompleted: saveCompleted ?? false,
    );
  }
}
