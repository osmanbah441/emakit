import 'category_repository_impl.dart';
import 'package:domain_models/domain_models.dart';

abstract class CategoryRepository {
  const CategoryRepository._();

  static CategoryRepository instance = CategoryRepositoryImpl();

  Future<List<Category>> getTopLevelCategories();

  Future<List<Category>> getSubcategories(String parentId);

  Future<Category?> getById(String id);

  Future<List<String>> getAllSubCategoriesId(String parentId);

  Future<List<Category>> getAll();

  Future<void> upsert({
    String? id,
    String? parentId,

    required String name,
    required String imageUrl,
    required String description,
  });

  Future<void> upsertAttribute({
    required String name,
    required String dataType,
    String? unit,
    List<String>? options,
    String? id,
  });

  Future<void> linkCategoryToAttributes(
    String catId,
    List<LinkCategoryToAtrributes> items,
  );

  Future<List<Category>> getCategoryWithAttributes();

  Future<List<AttributeDefinition>> getAllAttributes();
}
