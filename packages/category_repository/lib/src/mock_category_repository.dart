import 'package:domain_models/domain_models.dart';
import 'category_repository.dart';

class MockCategoryRepository implements CategoryRepository {
  final List<ProductCategory> _categories = [
    // --- WOMEN'S CLOTHING ---
    ProductCategory(
      id: 'women',
      name: 'Women',
      imageUrl: 'https://picsum.photos/seed/women/200/200',
      parentId: null,
    ),
    ProductCategory(
      id: 'women-dresses',
      name: 'Dresses',
      imageUrl: 'https://picsum.photos/seed/women-dresses/200/200',
      parentId: 'women',
    ),
    ProductCategory(
      id: 'women-tops',
      name: 'Tops',
      imageUrl: 'https://picsum.photos/seed/women-tops/200/200',
      parentId: 'women',
    ),
    ProductCategory(
      id: 'women-tops-t-shirts',
      name: 'T-Shirts',
      imageUrl: 'https://picsum.photos/seed/women-tops-t-shirts/200/200',
      parentId: 'women',
    ),
    ProductCategory(
      id: 'women-tops-blouses',
      name: 'Blouses',
      imageUrl: 'https://picsum.photos/seed/women-tops-blouses/200/200',
      parentId: 'women',
    ),
    ProductCategory(
      id: 'women-outerwear',
      name: 'Outerwear',
      imageUrl: 'https://picsum.photos/seed/women-outerwear/200/200',
      parentId: 'women',
    ),
    ProductCategory(
      id: 'women-outerwear-jackets',
      name: 'Jackets',
      imageUrl: 'https://picsum.photos/seed/women-outerwear-jackets/200/200',
      parentId: 'women',
    ),
    ProductCategory(
      id: 'women-outerwear-coats',
      name: 'Coats',
      imageUrl: 'https://picsum.photos/seed/women-outerwear-coats/200/200',
      parentId: 'women',
    ),

    // --- MEN'S CLOTHING ---
    ProductCategory(
      id: 'men',
      name: 'Men',
      imageUrl: 'https://picsum.photos/seed/men/200/200',
      parentId: null,
    ),
    ProductCategory(
      id: 'men-shirts',
      name: 'Shirts',
      imageUrl: 'https://picsum.photos/seed/men-shirts/200/200',
      parentId: 'men',
    ),
    ProductCategory(
      id: 'men-shirts-casual',
      name: 'Casual Shirts',
      imageUrl: 'https://picsum.photos/seed/men-shirts-casual/200/200',
      parentId: 'men',
    ),
    ProductCategory(
      id: 'men-shirts-formal',
      name: 'Formal Shirts',
      imageUrl: 'https://picsum.photos/seed/men-shirts-formal/200/200',
      parentId: 'men',
    ),
    ProductCategory(
      id: 'men-trousers',
      name: 'Trousers',
      imageUrl: 'https://picsum.photos/seed/men-trousers/200/200',
      parentId: 'men',
    ),
    ProductCategory(
      id: 'men-trousers-chinos',
      name: 'Chinos',
      imageUrl: 'https://picsum.photos/seed/men-trousers-chinos/200/200',
      parentId: 'men',
    ),
    ProductCategory(
      id: 'men-trousers-jeans',
      name: 'Jeans',
      imageUrl: 'https://picsum.photos/seed/men-trousers-jeans/200/200',
      parentId: 'men',
    ),
    ProductCategory(
      id: 'men-outerwear',
      name: 'Outerwear',
      imageUrl: 'https://picsum.photos/seed/men-outerwear/200/200',
      parentId: 'men',
    ),
    ProductCategory(
      id: 'men-outerwear-blazers',
      name: 'Blazers',
      imageUrl: 'https://picsum.photos/seed/men-outerwear-blazers/200/200',
      parentId: 'men',
    ),
    ProductCategory(
      id: 'men-outerwear-jackets',
      name: 'Jackets',
      imageUrl: 'https://picsum.photos/seed/men-outerwear-jackets/200/200',
      parentId: 'men',
    ),

    // --- KIDS' CLOTHING ---
    ProductCategory(
      id: 'kids',
      name: 'Kids',
      imageUrl: 'https://picsum.photos/seed/kids/200/200',
      parentId: null,
    ),
    ProductCategory(
      id: 'kids-boys',
      name: 'Boys',
      imageUrl: 'https://picsum.photos/seed/kids-boys/200/200',
      parentId: 'kids',
    ),
    ProductCategory(
      id: 'kids-boys-shorts',
      name: 'Shorts',
      imageUrl: 'https://picsum.photos/seed/kids-boys-shorts/200/200',
      parentId: 'kids',
    ),
    ProductCategory(
      id: 'kids-boys-hoodies',
      name: 'Hoodies',
      imageUrl: 'https://picsum.photos/seed/kids-boys-hoodies/200/200',
      parentId: 'kids',
    ),
    ProductCategory(
      id: 'kids-girls',
      name: 'Girls',
      imageUrl: 'https://picsum.photos/seed/kids-girls/200/200',
      parentId: 'kids',
    ),
    ProductCategory(
      id: 'kids-girls-skirts',
      name: 'Skirts',
      imageUrl: 'https://picsum.photos/seed/kids-girls-skirts/200/200',
      parentId: 'kids',
    ),
    ProductCategory(
      id: 'kids-girls-dresses',
      name: 'Dresses',
      imageUrl: 'https://picsum.photos/seed/kids-girls-dresses/200/200',
      parentId: 'kids',
    ),
  ];
  Future<void> _simulateNetworkDelay() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  // --- ALL METHODS BELOW THIS LINE REMAIN UNCHANGED ---

  @override
  Future<List<ProductCategory>> getTopLevelCategories() async {
    await _simulateNetworkDelay();
    return _categories.where((cat) => cat.parentId == null).toList();
  }

  @override
  Future<List<ProductCategory>> getSubcategories(String parentId) async {
    await _simulateNetworkDelay();
    return _categories.where((cat) => cat.parentId == parentId).toList();
  }

  @override
  Future<ProductCategory?> getCategoryById(String id) async {
    await _simulateNetworkDelay();
    try {
      return _categories.firstWhere((cat) => cat.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> createCategory({
    required String name,
    required String imageUrl,
    String? description,
    String? parentId,
  }) async {
    await _simulateNetworkDelay();
    final newId = DateTime.now().millisecondsSinceEpoch.toString();
    _categories.add(
      ProductCategory(
        id: newId,
        name: name,
        imageUrl: imageUrl,
        description: description,
        parentId: parentId,
      ),
    );
  }

  @override
  Future<void> updateCategory({
    required String id,
    String? name,
    String? imageUrl,
    String? description,
    String? parentId,
  }) async {
    await _simulateNetworkDelay();
    final index = _categories.indexWhere((cat) => cat.id == id);
    if (index != -1) {
      final original = _categories[index];
      // A copyWith method on the model is perfect for this!
      _categories[index] = ProductCategory(
        id: id,
        name: name ?? original.name,
        imageUrl: imageUrl ?? original.imageUrl,
        description: description ?? original.description,
        parentId: parentId ?? original.parentId,
      );
    }
  }

  @override
  Future<void> deleteCategory(String id) async {
    await _simulateNetworkDelay();
    _categories.removeWhere((cat) => cat.id == id);
  }

  @override
  Future<List<String>> getAllSubCategoriesId(String parentId) async {
    await _simulateNetworkDelay();

    return _categories
        .where((c) => c.parentId == parentId)
        .map((categories) => categories.id)
        .toList();
  }
}
