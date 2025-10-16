part of 'category_management_cubit.dart';

enum CategoryManagementStatus { loading, success, failure }

class CategoryManagementState extends Equatable {
  const CategoryManagementState({
    this.status = CategoryManagementStatus.loading,
    this.categories = const [],
    this.attributes = const [],
    this.snackBarMessage,
  });

  final CategoryManagementStatus status;
  final List<Category> categories;
  final List<AttributeDefinition> attributes;
  final String? snackBarMessage;

  CategoryManagementState copyWith({
    CategoryManagementStatus? status,
    List<Category>? categories,
    List<AttributeDefinition>? attributes,
    String? snackBarMessage,
  }) {
    return CategoryManagementState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      attributes: attributes ?? this.attributes,
    );
  }

  @override
  List<Object?> get props => [status, categories, attributes, snackBarMessage];
}
