import 'package:cloud_functions/cloud_functions.dart';

import 'models/models.dart';

final class MooemartFunctions {
  const MooemartFunctions._();

  static const instance = MooemartFunctions._();
  static final _function = FirebaseFunctions.instance;

  static useEmulator(String host, int port) =>
      _function.useFunctionsEmulator(host, port);

  Future<String> productSearch(MooemartPart part) async {
    final response = await _function
        .httpsCallable('productSearch')
        .call(part.toJson());

    return response.data;
  }

  Future<String> productImageUnderstand(List<MooemartMediaPart> parts) async {
    final response = await _function
        .httpsCallable('productImageUnderstand')
        .call(parts.map((part) => part.toJson()).toList());

    return response.data;
  }
}
