import 'package:dataconnect/dataconnect.dart';
import 'package:dataconnect/src/functions/models.dart';
import 'package:domain_models/domain_models.dart';
import 'package:cloud_functions/cloud_functions.dart';

final class Functions {
  const Functions._();
  static const instance = Functions._();

  static final _fn = FirebaseFunctions.instance;

  Future<String> productSearch(UserContent content) async {
    var res = await _fn
        .httpsCallable('MultimodalProductSearch')
        .call(content.toJson());
    print(res.data);
    return res.data.toString();
  }

  Future<ExtractedProductInfo> productExtractionListing(
    UserContent content,
  ) async => await _fn
      .httpsCallable('ProductExtractionListing')
      .call(content.toJson())
      .then((res) {
        final jsonMap = res.data as Map<String, dynamic>;
        final status = jsonMap['status'] as String;
        final message = jsonMap['message'] as String;
        final data = jsonMap['data'] as Map<String, dynamic>?;

        if (status == 'success' && data != null) {
          final p = ProductExtractionListingData.fromJson(data);

          return ExtractedProductInfo(
            similarProducts: [],
            variationDefinationData: p.variationAttributes,
            generatedProduct: Product(
              id: '',
              categoryId: 'category id',
              name: p.productName,
              storeId: '',
            ),
          );
        } else {
          throw ProductExtractionException(message);
        }
      });
}
