import 'package:domain_models/domain_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl({required this.role});

  static final _client = Supabase.instance.client;
  static const _table = "catalog_product";
  final ApplicationRole role;

  @override
  Future<List<Product>> getAll(
    ApplicationRole role, {
    String? searchTerm,
    String? categoryId,
  }) async {
    switch (role) {
      case ApplicationRole.buyer:
        final req = await _client
            .from('v_list_buyer_products_in_stock')
            .select();

        return req.map((e) => BuyerProductsList.fromJson(e)).toList();

      case ApplicationRole.store:
      case ApplicationRole.admin:
        final res = await _client.from(_table).select();
        final products = res.map((e) => e.toDomainProduct).toList();
        return products;
    }
  }

  @override
  Future<Product?> getById(String productId) async {
    final res = await _client.from(_table).select().eq('id', productId);
    if (res.isEmpty) return null;
    if (res.length > 1) {
      throw Exception("More than one product with id $productId");
    }
    return res.first.toDomainProduct;
  }

  @override
  Future<void> upsert({
    String? id,
    required String name,
    required String description,
    required Map<String, dynamic>? specs,
    required String categoryId,
    required List<ProductMedia> imageUrls,
  }) async {
    final images = imageUrls
        .map((e) => {'url': e.url, 'alt_text': e.altText})
        .toList();

    final data = {
      "p_id": id, //
      "p_name": name,
      "p_description": description,
      "p_category_id": categoryId,
      "p_specs": specs,
      "p_media": images,
      "p_status": 'draft',
    };
    await _client.rpc('fn_upsert_catalog_product_with_media', params: data);
  }

  @override
  Future<Map<String, List<Product>>> getProductsForAllCateggeories() {
    // TODO: implement getProductsForAllCateggeories
    throw UnimplementedError();
  }

  @override
  Future<ProductWithAttributes> getProductWithAttributes(
    String productId,
  ) async => await _client
      .from('v_product_variant_form_attributes')
      .select()
      .eq('product_id', productId)
      .then((data) {
        if (data.isEmpty) {
          throw Exception('Product not found');
        }
        return data.first.toDomainProductWithAttributes;
      });

  @override
  Future<void> insertProductVariant({
    required String productId,
    required String storeId,
    required int price,
    required int stock,
    required Map<String, String> attributes,
    required List<String> imageUrls,
  }) async {
    final attributesList = attributes.entries
        .map((e) => {'attribute_id': e.key, 'option_value': e.value})
        .toList();

    final data = {
      'p_catalog_product_id': productId,
      'p_store_id': storeId,
      'p_price': price,
      'p_stock_quantity': stock,
      'p_attributes': attributesList,
      'p_media_urls': imageUrls,
    };

    return await _client.rpc(
      'fn_catalog_insert_variant_with_options',
      params: data,
    );
  }

  @override
  Future<Product> getProductDetails({
    String? productId,
    String? variantId,
  }) async {
    switch (role) {
      case ApplicationRole.buyer:
        final res = await _client.rpc(
          'fn_get_buyer_product_details',
          params: {'p_variant_id': variantId},
        );

        return BuyerProductDetails.fromJson(res);
      case ApplicationRole.admin:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ApplicationRole.store:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}

extension on Map<String, dynamic> {
  Product get toDomainProduct => Product(
    id: this['id'],
    name: this['name'],
    categoryId: this['category_id'],
    description: this['description'],
    specifications: this['specs'],
    status: ProductStatus.fromString(this['status']),
  );

  ProductVariantAttribute get toDomainVariantAttribute =>
      ProductVariantAttribute(
        attributeId: this['attribute_id'],
        attributeName: this['attribute_name'],
        options:
            (this['options'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
      );

  ProductWithAttributes get toDomainProductWithAttributes {
    final rawAttrsData = this['attributes'] as List<dynamic>? ?? [];
    final attrs = rawAttrsData
        .map((e) => (e as Map<String, dynamic>).toDomainVariantAttribute)
        .toList();

    return ProductWithAttributes(
      productId: this['product_id'] as String? ?? '',
      productName: this['product_name'] as String? ?? '',
      attributes: attrs,
    );
  }
}
