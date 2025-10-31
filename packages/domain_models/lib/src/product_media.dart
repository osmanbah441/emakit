class ProductMedia {
  final String url;
  final String altText;

  ProductMedia({required this.url, required this.altText});

  factory ProductMedia.fromJson(Map<String, dynamic> json) {
    final String altValue =
        (json['alt_text'] as String?) ?? (json['alt'] as String?) ?? '';
    return ProductMedia(url: json['url'] as String, altText: altValue);
  }
}
