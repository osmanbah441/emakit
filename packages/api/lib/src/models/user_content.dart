import 'dart:convert';
import 'dart:typed_data';

sealed class UserContent {
  Map<String, dynamic> toJson();
}

class UserContentText implements UserContent {
  const UserContentText(this.text);
  final String text;
  @override
  Map<String, dynamic> toJson() => {"text": text};
}

class UserContentMedia implements UserContent {
  const UserContentMedia(this.bytes, this.mimeType);
  final Uint8List bytes;
  final String mimeType;

  @override
  Map<String, dynamic> toJson() => {
    'media': {'url': urlString(bytes, mimeType), 'mimeType': mimeType},
  };

  String urlString(Uint8List bytes, String mimeType) =>
      'data:$mimeType;base64,${base64Encode(bytes)}';
}
