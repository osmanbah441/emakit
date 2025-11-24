import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_repository/product_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'category_manager.dart';

part 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit(
    this.role, {
    required String parentCategoryId,
    required ProductRepository productRepository,
  }) : _productRepository = productRepository,
       _categoryManager = CategoryManager.instance,
       _parentCategoryId = parentCategoryId,
       super(ProductInitial()) {
    _loadInitialData();
  }

  final ApplicationRole role;
  final ProductRepository _productRepository;
  final CategoryManager _categoryManager;
  final String _parentCategoryId;

  void _loadInitialData() async {
    try {
      emit(ProductLoading());

      await _categoryManager.loadAllCategories();

      final topLevelCategory = _categoryManager.getById(_parentCategoryId);

      final initialSubcategories = _categoryManager.getSubcategories(
        _parentCategoryId,
      );

      final listOfProductLists = await _productRepository.getBuyerProducts();

      final allProducts = listOfProductLists.toList();

      emit(
        ProductLoaded(
          allProducts: allProducts,
          topLevelCategory: topLevelCategory,
          categories: initialSubcategories,
          selectedSubCategory: topLevelCategory,
        ),
      );
    } catch (e, trac) {
      print(trac);
      emit(ProductError("Failed to load products: ${e.toString()}"));
    }
  }

  void selectCategory(Category category) async {
    final currentState = state;
    if (currentState is ProductLoaded) {
      if (currentState.selectedSubCategory?.id == category.id) {
        if (category.id != _parentCategoryId) {
          _loadInitialData();
        }
        return;
      }

      emit(
        currentState.copyWith(
          isProductLoading: true,
          selectedSubCategory: category,
        ),
      );

      List<Category> newCategoriesForDisplay;
      final subcategories = _categoryManager.getSubcategories(category.id!);

      if (subcategories.isEmpty) {
        newCategoriesForDisplay = currentState.categories;
      } else {
        newCategoriesForDisplay = subcategories;
      }

      final listOfProducts = await _productRepository.getBuyerProducts(
        categoryId: category.id,
      );

      emit(
        ProductLoaded(
          allProducts: listOfProducts,
          topLevelCategory: currentState.topLevelCategory,
          categories: newCategoriesForDisplay,
          selectedSubCategory: category,
          isProductLoading: false,
        ),
      );
    }
  }

  void refresh() {
    _loadInitialData();
  }
}
