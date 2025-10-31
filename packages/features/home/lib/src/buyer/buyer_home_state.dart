import 'package:domain_models/domain_models.dart';

class BuyerHomeState {
  final Map<String, List<Category>> parentCategories;
  final List<Store> featuredStores;
  final bool isLoading;
  final String? error;

  const BuyerHomeState({
    this.parentCategories = const {},
    this.featuredStores = const [],
    this.isLoading = true,
    this.error,
  });

  BuyerHomeState copyWith({
    Map<String, List<Category>>? parentCategories,
    List<Store>? featuredStores,
    bool? isLoading,
    String? error,
  }) {
    return BuyerHomeState(
      parentCategories: parentCategories ?? this.parentCategories,
      featuredStores: featuredStores ?? this.featuredStores,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
