import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:category_repository/category_repository.dart';
import 'package:product_repository/product_repository.dart';
import 'package:domain_models/domain_models.dart';

part 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit(this._parentCategoryId)
    : _productRepository = ProductRepository.instance,
      _categoryRepository = CategoryRepository.instance,
      super(ProductInitial()) {
    _loadInitialData();
  }

  final ProductRepository _productRepository;
  final CategoryRepository _categoryRepository;
  final String _parentCategoryId;

  Future<void> _loadInitialData() async {
    try {
      emit(ProductLoading());
      final subCategories = await _categoryRepository.getSubcategories(
        _parentCategoryId,
      );
      final listOfProductLists = await _productRepository.getAllProducts();
      final allProducts = listOfProductLists.toList();
      allProducts.shuffle();
      emit(ProductLoaded(allProducts: allProducts, categories: subCategories));
    } catch (e) {
      emit(ProductError("Failed to load products: ${e.toString()}"));
    }
  }

  void selectCategory(ProductCategory category) async {
    final currentState = state;
    if (currentState is ProductLoaded) {
      if (currentState.activeCategory?.id == category.id) {
        return; // don't refetch
      }

      final listOfProduct = await _productRepository.getAllProducts(
        category: category.id,
      );

      emit(
        currentState.copyWith(
          allProducts: listOfProduct,
          activeCategory: category,
        ),
      );
    }
  }
}
