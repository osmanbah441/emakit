import 'package:domain_models/domain_models.dart';

abstract class CategoryRepository {
  const CategoryRepository._();

  Future<Category?> getById(String id);

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

  Future<List<ProductCategory>> productCategory({String? id});

  Future<List<AttributeDefinition>> getAllAttributes();
}
