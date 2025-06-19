import 'dart:convert';
import 'dart:typed_data';

/// Abstract base class for a GenKit Part.
/// Each concrete Part type will implement a toJson method.
sealed class MooemartPart {
  Map<String, dynamic> toJson();
}

class MooemartTextPart implements MooemartPart {
  const MooemartTextPart(this.text);

  final String text;

  @override
  Map<String, dynamic> toJson() {
    return {'text': text};
  }
}

class MooemartMediaPart implements MooemartPart {
  const MooemartMediaPart(this.bytes, this.mimeType);

  final Uint8List bytes;
  final String mimeType;

  @override
  Map<String, dynamic> toJson() => {
    'media': {
      'url': 'data:$mimeType;base64,${base64Encode(bytes)}',
      'mimeType': mimeType,
    },
  };
}
