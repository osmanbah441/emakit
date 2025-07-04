import 'package:dataconnect/dataconnect.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class CategoryNotifier extends ChangeNotifier {
  CategoryNotifier() {
    _loadCategories();
  }

  final _db = DataconnectService.instance;

  List<Category> _categories = [];
  String? _errorMessage;
  bool _isLoading = true;

  List<Category> get allCategories => _categories;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  void _updateState({
    List<Category>? categories,
    String? errorMessage,
    bool? isLoading,
  }) {
    _categories = categories ?? _categories;
    _errorMessage = errorMessage;
    _isLoading = isLoading ?? _isLoading;
    notifyListeners();
  }

  Future<void> _loadCategories() async {
    _updateState(isLoading: true, errorMessage: null);
    try {
      final categories = await _db.categoryRepository.getAllCategories();
      _updateState(categories: categories, isLoading: false);
    } catch (e) {
      _updateState(errorMessage: e.toString(), isLoading: false);
    }
  }

  void refresh() => _loadCategories();

  Future<void> addCategory(Category category) async {
    try {
      await _db.categoryRepository.createNewCategory(
        name: category.name,
        description: category.description,
        parentId: category.parentId,
      );
      await _loadCategories();
    } catch (e) {
      _updateState(errorMessage: e.toString());
    }
  }

  Future<void> updateSubcategory(
    String id, {
    List<Map<String, dynamic>>? variationsFields,
  }) async {
    try {
      await _db.categoryRepository.setAttributesFields(
        id,
        variationFields: variationsFields,
      );
      await _loadCategories();
    } catch (e) {
      _updateState(errorMessage: e.toString());
    }
  }

  List<Category> get mainCategories =>
      _categories.where((c) => c.isMainCategory).toList();

  List<Category> getSubcategories(String parentId) =>
      _categories.where((c) => c.parentId == parentId).toList();
}
