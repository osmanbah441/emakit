final class Category {
  final String id;
  final String name;
  final String? imageUrl;

  const Category({required this.id, required this.name, this.imageUrl});

  @override
  String toString() => name;
}
