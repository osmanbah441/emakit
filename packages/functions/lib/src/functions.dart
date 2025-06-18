import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_functions/cloud_functions.dart';

import 'models/models.dart';

final class MooemartFunctions {
  const MooemartFunctions._();

  static const instance = MooemartFunctions._();
  static final _function = FirebaseFunctions.instance;

  static useEmulator(String host, int port) =>
      _function.useFunctionsEmulator(host, port);

  Future<String> productSearch({
    String? text,
    ({Uint8List bytes, String mimeType})? media,
  }) async {
    assert(
      (text != null && media == null) || (text == null && media != null),
      'You must provide either text or audio, but not both.',
    );

    final response = await _function.httpsCallable('productSearch').call({
      if (text != null) 'text': text,
      if (media != null)
        'media': {
          'url': 'data:${media.mimeType};base64,${base64Encode(media.bytes)}',
          'mimeType': media.mimeType,
        },
    });

    return response.data;
  }
}
