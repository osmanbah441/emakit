import 'package:api/api.dart';
import 'package:api/src/dataconnect_gen/default.dart';

import 'package:api/src/functions/models.dart';
import 'package:domain_models/domain_models.dart';

import '../firestore/product.dart';
import '../functions/functions.dart';

final class ProductRepository {
  const ProductRepository();

  static final _fn = Functions.instance;
  static final _connector = DefaultConnector.instance;

  // Ensure your Product, ProductVariation, and ProductStatus classes are defined in your Dart file.

  Future<String> createNewProduct({
    required String name,
    required String description,
    required String subcategoryId,
    required String imageUrl,
    required Map<String, dynamic> specs,
  }) async {
    // return await _connector
    //     .createNewProduct(
    //       name: name,
    //       description: description,
    //       category: subcategoryId,
    //       mainImage: imageUrl,
    //       specs: specs,
    //     )
    //     .execute()
    //     .then((result) {
    //       return result.data.listing_insert.id;
    //     });

    return "";
  }

  Future<void> createNewProductVariation({
    required String productId,
    required List<String> imageUrls,
    required double price,
    required int availabeStock,
    required Map<String, dynamic> attributes,
    required String storeId,
  }) async {
    // await _connector
    //     .createNewProductVariation(
    //       storeId: storeId,
    //       attributes: attributes,
    //       productId: productId,
    //       imageUrls: imageUrls,
    //       price: price,
    //       availabeStock: availabeStock,
    //     )
    //     .execute();
  }

  Future<List<Product>> getAllProducts({
    String searchTerm = '',
    String? categoryId,
  }) async {
    var query = _connector.getAllProducts();
    // if (categoryId != null) query = query.categoryId(categoryId);

    return await query.execute().then(
      (result) => result.data.products
          .map(
            (p) => Product(
              id: p.id,
              name: p.name,
              description: p.description,
              specifications: p.specifications.value as Map<String, dynamic>,
              variations: p.variations
                  .map(
                    (v) => ProductVariation(
                      id: v.id,
                      attributes: v.attributes.value,
                      imageUrls: v.imageUrls,
                      price: v.price,
                      stockQuantity: v.availableStock,
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }

  Future<Product> getProductById(String id) async {
    return await _connector.getProductById(id: id).execute().then((result) {
      final p = result.data.product;
      if (p == null) throw ('No product found');
      return Product(
        id: p.id,
        name: p.name,
        description: p.description,
        specifications: p.specifications.value as Map<String, dynamic>,
        variations: p.variations
            .map(
              (v) => ProductVariation(
                id: v.id,
                attributes: v.attributes.value,
                imageUrls: v.imageUrls,
                price: v.price,
                stockQuantity: v.availableStock,
              ),
            )
            .toList(),
      );
    });
  }

  Future<ProductExtractionListingData> productExtractionListing(
    UserContent content,
  ) async {
    return _fn.productExtractionListing(content);
  }

  Future productSearch(UserContent userContentMedia) async {
    return await _fn.productSearch(userContentMedia);
  }
}
