// import 'dart:typed_data';
// import 'package:dataconnect/dataconnect.dart';
// import 'package:domain_models/domain_models.dart';
// import 'package:firebase_data_connect/firebase_data_connect.dart';

// import '../dataconnect_gen/default.dart';
// import '../functions/functions.dart';
// import 'storage_repository.dart';

// final class ProductRepository {
//   const ProductRepository();

//   static final _fn = Functions.instance;
//   static final _connector = DefaultConnector.instance;

//   Future<List<Product>> getProductForStore() async {
//     return [];
//     // try {
//     //   return await _connector
//     //       .getProductForStoreOwner(storeId: await _getStoreId)
//     //       .execute()
//     //       .then(
//     //         (result) => result.data.products
//     //             .map(
//     //               (p) {

//     //                 return Product(
//     //                 id: p.id,
//     //                 name: p.name,
//     //                 description: p.description,
//     //                 specifications:
//     //                     p.specifications.value as Map<String, dynamic>,
//     //                 variations: p.productVariations_on_product
//     //                     .map(
//     //                       (v) => ProductVariation(
//     //                         id: v.id,
//     //                         attributes: v.attributes.value,
//     //                         imageUrls: v.imageUrls,
//     //                         price: v.price,
//     //                         stockQuantity: v.availableStock,
//     //                       ),
//     //                     )
//     //                     .toList(),
//     //               );
//     //               },
//     //             )
//     //             .toList(),
//     //       );
//     // } catch (e) {
//     //   rethrow;
//     // }
//   }

//   Future<
//     ({Product? product, Map<String, List<String>>? attributeDefinationFields})
//   >
//   getProductDetailsForStore(String productId) async {
//     try {
//       return _connector
//           .getStoreProductDetailsForOwner(
//             storeId: await _getStoreId,
//             productId: productId,
//           )
//           .execute()
//           .then((result) {
//             final p = result.data.product;
//             if (p == null) {
//               return (product: null, attributeDefinationFields: null);
//             }
//             final variationDefination =
//                 p.category.variationAttributes?.value as Map<String, dynamic>;
//             final product = Product(
//               id: p.id,
//               name: p.name,
//               description: p.description,
//               specifications: p.specifications.value,
//               variations: p.variation
//                   .map(
//                     (v) => ProductVariation(
//                       id: v.id,
//                       attributes: v.attributes.value,
//                       imageUrls: v.imageUrls,
//                       price: v.price,
//                       stockQuantity: v.availableStock,
//                     ),
//                   )
//                   .toList(),
//             );

//             final attributeDefination = _extractProductAttributes(
//               variationDefination,
//             );

//             print(attributeDefination);

//             return (
//               product: product,
//               attributeDefinationFields: _extractProductAttributes(
//                 variationDefination,
//               ),
//               // attributeDefinationFields:
//               //     variationDefination as Map<String, List<String>>,
//             );
//           });
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<String> get _getStoreId async {
//     final id = await _connector.getUserStore().execute().then((r) {
//       return r.data.user?.store?.id;
//     });
//     if (id == null) throw ("No store found");
//     return id;
//   }

//   Future<void> createNewProduct({
//     required String name,
//     required String description,
//     required Map<String, dynamic> specs,
//     required Map<String, dynamic> attributes,
//     required String category,
//     required List<({Uint8List bytes, String mimeType})> imagesData,
//     required double price,
//     required int availableStock,
//   }) async {
//     final imageUrls = await StorageRepository.uploadImages(
//       imagesData: imagesData,
//       storeId: await _getStoreId,
//       folder: StorageFolder.products,
//     );

//     final embeddingText = description; // use gemini to generate better text:

//     await _connector
//         .createNewProduct(
//           name: name,
//           description: description,
//           category: category,
//           specs: AnyValue(specs),
//           storeId: await _getStoreId,
//           attributes: AnyValue(attributes),
//           imageUrls: imageUrls,
//           price: price,
//           availableStock: availableStock,
//           // embeddingText: embeddingText,
//         )
//         .execute();
//   }

//   Future<void> createNewProductVariation({
//     required String productId,
//     required List<({Uint8List bytes, String mimeType})> images,
//     required double price,
//     required int availableStock,
//     required Map<String, dynamic> attributes,
//   }) async {
//     final imageUrls = await StorageRepository.uploadImages(
//       imagesData: images,
//       storeId: await _getStoreId,
//       folder: StorageFolder.products,
//     );

//     await _connector
//         .createNewproductVariation(
//           storeId: await _getStoreId,
//           attributes: AnyValue(attributes),
//           productId: productId,
//           imageUrls: imageUrls,
//           price: price,
//           availableStock: availableStock,
//         )
//         .execute();
//   }

//   Future<List<Product>> getAllProducts({
//     String searchTerm = '',
//     String? categoryId,
//   }) async {
//     var query = _connector.getAllProducts();
//     if (categoryId != null) query = query.category(categoryId);

//     return await query.execute().then(
//       (result) => result.data.products
//           .map(
//             (p) => Product(
//               id: p.id,
//               name: p.name,
//               description: p.description,
//               specifications: p.specifications.value as Map<String, dynamic>,
//               variations: p.variations
//                   .map(
//                     (v) => ProductVariation(
//                       id: v.id,
//                       attributes: v.attributes.value,
//                       imageUrls: v.imageUrls,
//                       price: v.price,
//                       stockQuantity: v.availableStock,
//                     ),
//                   )
//                   .toList(),
//             ),
//           )
//           .toList(),
//     );
//   }

//   Future<Product> getProductById(String id) async {
//     return await _connector.getProductById(id: id).execute().then((result) {
//       final p = result.data.product;
//       if (p == null) throw ('No product found');
//       return Product(
//         id: p.id,
//         name: p.name,
//         description: p.description,
//         specifications: p.specifications.value as Map<String, dynamic>,
//         variations: p.variations
//             .map(
//               (v) => ProductVariation(
//                 id: v.id,
//                 attributes: v.attributes.value,
//                 imageUrls: v.imageUrls,
//                 price: v.price,
//                 stockQuantity: v.availableStock,
//               ),
//             )
//             .toList(),
//       );
//     });
//   }

//   Future<ExtractedProductInfo> productExtractionListing(
//     UserContent content,
//   ) async {
//     return _fn.productExtractionListing(content);
//   }

//   Future productSearch(UserContent userContentMedia) async {
//     return await _fn.productSearch(userContentMedia);
//   }

//   Map<String, List<String>> _extractProductAttributes(
//     Map<String, dynamic> rawData,
//   ) {
//     final Map<String, List<String>> attributes = {};
//     rawData.forEach((key, value) {
//       if (value is List) {
//         attributes[key] = List<String>.from(value);
//       } else {
//         throw (
//           'Warning: Attribute "$key" is not a list. Skipping. Type: ${value.runtimeType}',
//         );
//       }
//     });

//     return attributes;
//   }
// }
