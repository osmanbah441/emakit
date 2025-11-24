import 'package:domain_models/domain_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl();

  static final _client = Supabase.instance.client;
  static const _table = "catalog_product";
  // final ApplicationRole role;

  @override
  Future<List<Product>> getBuyerProducts({
    String? searchTerm,
    String? categoryId,
  }) async {
    final req = await _client.from('v_list_buyer_products_in_stock').select();

    return req.map((e) => BuyerProductsList.fromJson(e)).toList();
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
  Future<Product> getBuyerProductDetails({
    String? productId,
    String? variantId,
  }) async {
    final res = await _client.rpc(
      'fn_get_buyer_product_details',
      params: {'p_variant_id': variantId},
    );

    return BuyerProductDetails.fromJson(res);
  }

  @override
  Future<List<StoreProduct>> getStoreProductWithOffer() async {
    final res = await _client.from('v_product_variant_with_offer').select();
    return res.map((e) => StoreProduct.fromJson(e)).toList();
  }

  @override
  Future<void> createOffer({
    required String variantId,
    required String storeId,
    required double price,
    required int stock,
  }) async {
    print('''
productId: $variantId
storeId: $storeId
price: $price
stock: $stock
    ''');
  }

  @override
  Future<void> createProductWithVariationAndOffer({
    required String name,
    required String manufacturer,
    required String categoryId,
    required String description,
    required Map<String, String> specs,
    required double price,
    required int stock,
    required List<String> imageUrls,
    required Map<String, String> variationAttributes,
  }) async {
    print('''
name: $name
manufacturer: $manufacturer
categoryId: $categoryId
description: $description
specs: $specs
price: $price''');
  }

  @override
  Future<void> createVariationAndOffer({
    required String productId,
    required String storeId,
    required double price,
    required int stock,
    required Map<String, String> attributes,
    required List<String> imageUrls,
  }) async {
    print('''
productId: $productId
storeId: $storeId
attriibutes: $attributes''');
  }

  @override
  Future<StoreProduct?>? getStoreProductVariantById(String id) => _client
      .from('v_product_variant_with_offer')
      .select()
      .eq('variant_id', id)
      .single()
      .then((data) {
        if (data.isEmpty) {
          return null;
        }
        return StoreProduct.fromJson(data);
      });

  @override
  Future<StoreProduct?>? getStoreProductById(String id) => _client
      .from('v_product_variant_with_offer')
      .select()
      .eq('product_id', id)
      .limit(1)
      .single()
      .then((data) {
        if (data.isEmpty) {
          return null;
        }
        return StoreProduct.fromJson(data);
      });
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
