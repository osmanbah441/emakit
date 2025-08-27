import 'package:category_repository/src/mock_category_repository.dart';
import 'package:domain_models/domain_models.dart';

abstract class CategoryRepository {
  const CategoryRepository._();

  static CategoryRepository instance = MockCategoryRepository();
  Future<List<ProductCategory>> getTopLevelCategories();

  Future<List<ProductCategory>> getSubcategories(String parentId);

  Future<ProductCategory?> getCategoryById(String id);

  Future<List<String>> getAllSubCategoriesId(String parentId);

  Future<void> createCategory({
    required String name,
    required String imageUrl,
    String? description,
    String? parentId,
  });

  Future<void> updateCategory({
    required String id,
    String? name,
    String? imageUrl,
    String? description,
    String? parentId,
  });

  Future<void> deleteCategory(String id);
}
