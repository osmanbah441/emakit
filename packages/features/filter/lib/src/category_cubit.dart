import 'package:api/api.dart';

import 'package:domain_models/domain_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_state.dart';

class CategoryDetailsCubit extends Cubit<CategoryDetailsState> {
  CategoryDetailsCubit({required this.id, required String mainCategoryName})
    : super(CategoryDetailsInitial()) {
    _initializeFilters(mainCategoryName);
  }

  final String id; // parent category id

  static const availableBrands = [
    'Samsung',
    'Apple',
    'Sony',
    'HP',
    'Dell',
    'LG',
    'Google',
  ];

  final _service = Api.instance;

  void _initializeFilters(String categoryName) async {
    final fetchSubcategory = await _service.categoryRepository
        .getChildrenCategories(id);

    final initialFilters = FilterData(
      maxPriceBound: 2000,
      priceRange: (min: 0, max: 2000),
    );

    emit(
      CategoryDetailsLoaded(
        mainCategoryName: categoryName,
        priceRange: (min: 0, max: 2000),
        availableBrands: availableBrands,
        subCategories: fetchSubcategory,
        appliedFilters: initialFilters,
        tempFilters: initialFilters,
        showFilters: false,
        fiteredProducts: await _fetchFilteredProduct(initialFilters),
      ),
    );
  }

  Future<List<Product>> _fetchFilteredProduct(FilterData filters) async {
    return await _service.productRepository.getAllProducts(
      categoryId: filters.selectedSubCategory?.id,
    );
  }

  void toggleFiltersVisibility() {
    final currentState = state as CategoryDetailsLoaded;

    if (!currentState.showFilters) {
      // Opening filters - sync temp with applied
      emit(
        currentState.copyWith(
          showFilters: true,
          tempFilters: currentState.appliedFilters.copyWith(),
        ),
      );
    } else {
      // Closing filters
      emit(currentState.copyWith(showFilters: false));
    }
  }

  void updateTempSubCategory(Category? category) {
    final currentState = state as CategoryDetailsLoaded;
    final updatedTempFilters = currentState.tempFilters.copyWith();
    updatedTempFilters.selectedSubCategory = category;

    emit(currentState.copyWith(tempFilters: updatedTempFilters));
  }

  void filterBySubCategory(Category? category) async {
    final currentState = state as CategoryDetailsLoaded;
    final updatedTempFilters = currentState.tempFilters.copyWith();
    updatedTempFilters.selectedSubCategory = category;

    emit(
      currentState.copyWith(
        tempFilters: updatedTempFilters,
        appliedFilters: updatedTempFilters,
        fiteredProducts: await _fetchFilteredProduct(updatedTempFilters),
      ),
    );
  }

  void updateTempBrand(String? brand) {
    final currentState = state as CategoryDetailsLoaded;
    final updatedTempFilters = currentState.tempFilters.copyWith();
    updatedTempFilters.selectedBrand = brand;

    emit(currentState.copyWith(tempFilters: updatedTempFilters));
  }

  void updateTempPriceRange(({double min, double max})? newRange) {
    final currentState = state as CategoryDetailsLoaded;
    final updatedTempFilters = currentState.tempFilters.copyWith();
    updatedTempFilters.priceRange = newRange;

    emit(currentState.copyWith(tempFilters: updatedTempFilters));
  }

  void applyFilters() {
    final currentState = state as CategoryDetailsLoaded;

    emit(
      currentState.copyWith(
        appliedFilters: currentState.tempFilters.copyWith(),
        showFilters: false,
      ),
    );

    // Trigger product fetch/filter logic here
    _onFiltersApplied(currentState.tempFilters);
  }

  void resetFilters() {
    final resetFilters = FilterData();

    emit(
      CategoryDetailsLoaded(
        appliedFilters: resetFilters,
        tempFilters: resetFilters,
        showFilters: false,
      ),
    );

    _onFiltersReset();
  }

  void _onFiltersApplied(FilterData filters) async {
    print('Filters applied: $filters');
    // Add your product filtering logic here
    final products = await _fetchFilteredProduct(filters);
    final currentState = state as CategoryDetailsLoaded;

    emit(currentState.copyWith(fiteredProducts: products));
  }

  void _onFiltersReset() {
    print('Filters reset and applied');
    // Add your product reset logic here
  }

  void toggleCartStatus(String id) {}

  void toggleWishlistStatus(String id) {}
}
