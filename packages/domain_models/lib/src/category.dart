class Category {
  final String? id;
  final String name;
  final String? parentId;
  final String description;
  final String? imageUrl;
  final List<Map<String, dynamic>>? variationFields;
  final List<String> specificationFields;

  const Category({
    this.id,
    required this.name,
    this.parentId,
    this.description = '',
    this.imageUrl,
    this.variationFields,
    this.specificationFields = const [],
  });

  bool get isMainCategory => parentId == null;
}
