import 'package:domain_models/domain_models.dart';

class Category {
  final String? id;
  final String name;
  final String imageUrl;
  final String? description;
  final String? parentId;
  final List<LinkCategoryToAtrributes> attributes;

  const Category({
    this.id,
    required this.name,
    required this.imageUrl,
    this.description,
    this.parentId,
    this.attributes = const [],
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'ProductCategory(id: $id, name: $name)';
}
