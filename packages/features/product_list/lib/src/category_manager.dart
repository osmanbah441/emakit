// category_manager.dart

import 'dart:collection';
import 'package:domain_models/domain_models.dart';
import 'package:category_repository/category_repository.dart';

class CategoryManager {
  static final CategoryManager instance = CategoryManager._internal();
  factory CategoryManager() => instance;
  CategoryManager._internal();

  final CategoryRepository _repository = CategoryRepositoryImpl(
    role: ApplicationRole.buyer,
  );

  Map<String, Category> _allCategoriesMap = {};
  bool _isLoaded = false;

  Future<void> loadAllCategories() async {
    if (_isLoaded) return;

    final allCategoriesList = await _repository.getAll();
    _allCategoriesMap = {
      for (var category in allCategoriesList) category.id!: category,
    };
    _isLoaded = true;
  }

  Category getById(String categoryId) {
    if (!_isLoaded) throw StateError("CategoryManager not loaded.");
    return _allCategoriesMap[categoryId]!;
  }

  List<Category> getSubcategories(String parentId) {
    if (!_isLoaded) throw StateError("CategoryManager not loaded.");
    return _allCategoriesMap.values
        .where((c) => c.parentId == parentId)
        .toList();
  }

  // Finds all descendant IDs, including the parent
  List<String> getAllDescendantIds(String parentId) {
    if (!_isLoaded) throw StateError("CategoryManager not loaded.");

    final List<String> descendantIds = [parentId];
    final Queue<String> queue = Queue.from(
      getSubcategories(parentId).map((c) => c.id!),
    );

    while (queue.isNotEmpty) {
      final currentId = queue.removeFirst();
      descendantIds.add(currentId);

      for (var child in getSubcategories(currentId)) {
        queue.addLast(child.id!);
      }
    }
    return descendantIds;
  }
}
