import 'package:api/api.dart';
import 'package:api/src/functions/models.dart';
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

  Future<ProductExtractionListingData> productExtractionListing(
    UserContent content,
  ) async => await _fn
      .httpsCallable('ProductExtractionListing')
      .call(content.toJson())
      .then((res) {
        final jsonMap = res.data as Map<String, dynamic>;
        final status = jsonMap['status'] as String;
        final message = jsonMap['message'] as String;
        final data = jsonMap['data'] as Map<String, dynamic>?;

        return (status == 'success' && data != null)
            ? ProductExtractionListingData.fromJson(data)
            : throw ProductExtractionException(message);
      });
}
