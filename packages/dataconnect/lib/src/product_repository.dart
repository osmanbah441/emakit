import 'package:domain_models/domain_models.dart';

import 'default_connector/default.dart';

final class ProductRepository {
  const ProductRepository();
  static final _connector = DefaultConnector.instance;

  Future<String> addProduct({
    required String name,
    required String description,
    required String subcategoryId,
    required String brand,
    required List<String> imageUrls,
    required double price,
    required int stockQuantity,
  }) async => await _connector
      .insertProduct(
        name: name,
        description: description,
        category: subcategoryId,
        brand: brand,
      )
      .execute()
      .then((result) {
        return result.data.product_insert.id;
      });

  Future<void> addVariationForProduct({
    required String productId,
    required List<String> imageUrls,
    required double price,
    required int stockQuantity,
  }) async {
    await _connector
        .insertProductVariation(
          productId: productId,
          imageUrls: imageUrls,
          price: price,
          stockQuantity: stockQuantity,
        )
        .execute();
  }

  Future<List<Product>> fetchProducts({
    String searchTerm = '',
    String? categoryId,
  }) async {
    var query = _connector.listProducts();
    if (categoryId != null) query = query.categoryId(categoryId);

    return await query.execute().then(
      (result) => result.data.products
          .map(
            (p) => Product(
              id: p.id,
              name: p.name,
              mainCategory: '',
              description: p.description,
              specifications: p.specifications.value as Map<String, dynamic>,
              variations: p.variations
                  .map(
                    (v) => ProductVariation(
                      id: v.id,
                      attributes: v.attributes.value,
                      imageUrls: v.imageUrls,
                      price: v.price,
                      stockQuantity: v.stockQuantity,
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }

  Future<Product> fetchProductById(String id) async =>
      await _connector.getProductById(id: id).execute().then((result) {
        final p = result.data.product;
        if (p == null) throw ('No product found');
        return Product(
          id: p.id,
          name: p.name,
          mainCategory: '',

          description: p.description,
          specifications: p.specifications.value as Map<String, dynamic>,
          variations: p.variations
              .map(
                (v) => ProductVariation(
                  id: v.id,
                  attributes: v.attributes.value,
                  imageUrls: v.imageUrls,
                  price: v.price,
                  stockQuantity: v.stockQuantity,
                ),
              )
              .toList(),
        );
      });
}
