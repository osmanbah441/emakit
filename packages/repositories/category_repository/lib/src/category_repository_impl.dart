import 'package:domain_models/domain_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'category_repository.dart';
import 'extension.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  const CategoryRepositoryImpl({required this.role});

  final ApplicationRole role;
  static final _supabase = Supabase.instance.client;
  static const _table = 'category';

  @override
  Future<Category?> getById(String id) async {
    return null;
  }

  @override
  Future<void> upsert({
    String? id,
    String? parentId,
    required String name,
    required String imageUrl,
    required String description,
  }) async {
    try {
      await _supabase.from(_table).upsert({
        if (id != null) 'id': id,
        'name': name,
        'image_url': imageUrl,
        'description': description,
        'parent_id': parentId,
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Category>> getAll() async {
    final res = await _supabase.from(_table).select();
    return res.map((e) => (e).toDomainCategory).toList();
  }

  @override
  Future<void> upsertAttribute({
    required String name,
    required String dataType,
    String? unit,
    List<String>? options,
    String? id,
  }) async {
    try {
      await _supabase.rpc(
        'fn_upsert_attribute_with_options',
        params: {
          if (id != null) 'p_attr_id': id,
          'p_attr_name': name,
          'p_attr_data_type': dataType,
          if (unit != null && unit.isNotEmpty) 'p_attr_unit': unit,
          if (options != null && options.isNotEmpty) 'p_option_list': options,
        },
      );
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<AttributeDefinition>> getAllAttributes() async {
    final res = await _supabase.from('v_attribute_with_options').select();

    final attrs = res.map((e) => (e).toDomainAttribute).toList();

    for (final attr in attrs) {
      if (attr.options != null && attr.options!.isNotEmpty) {
        print(' found');
      }
    }

    return attrs;
  }

  @override
  Future<List<Category>> getCategoryWithAttributes() async {
    final res = await _supabase.from('v_category_with_attributes').select();
    final cats = res.map((e) => e.toDomainCategory).toList();

    return cats;
  }

  @override
  Future<void> linkCategoryToAttributes(
    String catId,
    List<LinkCategoryToAtrributes> items,
  ) async {
    try {
      await _supabase.rpc(
        'fn_replace_category_attributes',
        params: {
          'p_category_id': catId,
          'p_attributes': items
              .map(
                (e) => {
                  'attribute_id': e.attributeId,
                  'is_required': e.isRequired,
                  'is_variant': e.isVariant,
                },
              )
              .toList(),
        },
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
