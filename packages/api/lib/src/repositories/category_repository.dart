import 'dart:typed_data';

import 'package:api/src/dataconnect_gen/default.dart';
import 'package:domain_models/domain_models.dart';

final class CategoryRepository {
  const CategoryRepository();

  static final _connector = DefaultConnector.instance;

  Future<void> createNewCategory({
    required String name,
    ({Uint8List? bytes, String? mimeType})? imageUrl,
    String? parentId,
    required String description,
  }) async {
    // TODO: upload the image to server and get the url string

    // final c = _connector.createNewCategory(
    //   name: name,
    //   description: description,
    //   imageUrl: 'imageUrl',
    // );
    // if (parentId != null) c.parentId(parentId);
    // await c.execute();
  }

  Future<List<Category>> getAllCategories() async {
    // return await _connector.getAllCategories().execute().then((results) {
    //   return results.data.categories.map((result) {
    //     return Category(
    //       name: result.name,
    //       id: result.id,
    //       description: result.description,
    //       parentId: result.parentCategoryId,
    //       imageUrl: result.imageUrl,
    //       variationFields: _extractListOfMaps(result.variationAttributes),
    //     );
    //   }).toList();
    // });
    return [];
  }

  Future<List<Map<String, dynamic>>> getCategoryById(String id) async {
    // return await _connector.getCategoryById(id: id).execute().then((c) {
    //   final a = c.data.category?.variationAttributes;
    //   return _extractListOfMaps(a);
    // });

    return [];
  }

  Future<void> setAttributesFields(
    String id, {
    List<Map<String, dynamic>>? variationFields,
    List<String>? specs,
  }) async {
    //   final c = _connector.updateCategoryAttributes(id: id);
    //   if (variationFields != null) c.varition(AnyValue(variationFields));
    //   if (specs != null) c.specification(specs);
    //   await c.execute();
    // }

    // List<Map<String, dynamic>> _extractListOfMaps(AnyValue? anyValue) {
    //   if (anyValue == null || anyValue.value == null) return [];
    //   final rawList = anyValue.value;
    //   if (rawList is! List) return [];

    //   return rawList
    //       .whereType<Map>() // skip invalid entries
    //       .map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e))
    //       .toList();
  }
}
