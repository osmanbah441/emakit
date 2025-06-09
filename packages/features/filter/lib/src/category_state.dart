part of 'category_cubit.dart';

abstract class CategoryDetailsState {}

class CategoryDetailsInitial extends CategoryDetailsState {}

class CategoryDetailsLoaded extends CategoryDetailsState {
  final FilterData appliedFilters;
  final FilterData tempFilters;
  final bool showFilters;
  final String mainCategoryName;
  final List<Category> subCategories;
  final List<String> availableBrands;
  final ({double min, double max}) priceRange;
  final List<Product> fiteredProducts;

  CategoryDetailsLoaded({
    required this.appliedFilters,
    required this.tempFilters,
    this.mainCategoryName = '',
    required this.showFilters,
    this.availableBrands = const [],
    this.subCategories = const [],
    this.priceRange = (min: 0, max: 0),
    this.fiteredProducts = const [],
  });

  CategoryDetailsLoaded copyWith({
    FilterData? appliedFilters,
    FilterData? tempFilters,
    bool? showFilters,
    List<Category>? subCategories,
    List<String>? availableBrands,
    ({double min, double max})? priceRange,
    List<Product>? fiteredProducts,
  }) {
    return CategoryDetailsLoaded(
      appliedFilters: appliedFilters ?? this.appliedFilters,
      tempFilters: tempFilters ?? this.tempFilters,
      showFilters: showFilters ?? this.showFilters,
      subCategories: subCategories ?? this.subCategories,
      availableBrands: availableBrands ?? this.availableBrands,
      priceRange: priceRange ?? this.priceRange,
      fiteredProducts: fiteredProducts ?? this.fiteredProducts,
      mainCategoryName: mainCategoryName,
    );
  }
}

class FilterData {
  Category? selectedSubCategory;
  String? selectedBrand;
  ({double min, double max})? priceRange;
  // RangeValues? priceRange;
  final double maxPriceBound;

  FilterData({
    this.selectedSubCategory,
    this.selectedBrand,
    this.priceRange,
    this.maxPriceBound = 2000.0,
  });

  FilterData copyWith({
    Category? selectedSubCategory,
    String? selectedBrand,
    ({double min, double max})? priceRange,
  }) {
    return FilterData(
      selectedSubCategory: selectedSubCategory ?? this.selectedSubCategory,
      selectedBrand: selectedBrand ?? this.selectedBrand,
      priceRange: priceRange ?? this.priceRange,
      maxPriceBound: maxPriceBound,
    );
  }

  FilterData reset() => FilterData();

  @override
  String toString() {
    return 'FilterData(selectedSubCategory: $selectedSubCategory, selectedBrand: $selectedBrand, priceRange: $priceRange)';
  }
}
