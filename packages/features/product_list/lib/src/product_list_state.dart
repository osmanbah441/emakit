part of 'product_list_bloc.dart';

@immutable
sealed class ProductListState {
  const ProductListState();
}

class ProductListLoading extends ProductListState {
  const ProductListLoading();
}

class ProductListLoaded extends ProductListState {
  final List<Product> products;
  final String currentSearchTerm;
  final SearchInputMode searchInputMode;
  final UserRole? userRole;
  final Set<String> cartProductIds;
  final Set<String> wishlistProductIds;

  const ProductListLoaded({
    required this.products,
    this.userRole,
    this.currentSearchTerm = '',
    this.searchInputMode = SearchInputMode.idle,
    this.cartProductIds = const {},
    this.wishlistProductIds = const {},
  });

  ProductListLoaded copyWith({
    List<Product>? products,
    String? currentSearchTerm,
    SearchInputMode? searchInputMode,
    Set<String>? cartProductIds,
    Set<String>? wishlistProductIds,
  }) {
    return ProductListLoaded(
      products: products ?? this.products,
      currentSearchTerm: currentSearchTerm ?? this.currentSearchTerm,
      searchInputMode: searchInputMode ?? this.searchInputMode,
      cartProductIds: cartProductIds ?? this.cartProductIds,
      wishlistProductIds: wishlistProductIds ?? this.wishlistProductIds,
    );
  }
}

class ProductListError extends ProductListState {
  final String message;
  final SearchInputMode searchInputMode;

  const ProductListError({
    required this.message,
    this.searchInputMode = SearchInputMode.idle,
  });
}

enum SearchInputMode {
  idle, // Default state, ready for input
  typing, // User is actively typing
  recording, // Audio recording is active
  processing, // AI is processing text or audio
}

// These states are emitted by ProductListBloc to specifically handle search actions
class ProductListIdleSearch extends ProductListState {
  const ProductListIdleSearch();
}

class ProductListSearchProcessing extends ProductListState {
  const ProductListSearchProcessing();
}

class ProductListSearchSuccess extends ProductListState {
  final String result;
  final SearchInputMode searchInputMode;

  const ProductListSearchSuccess({
    required this.result,
    this.searchInputMode = SearchInputMode.idle,
  });
}

class ProductListSearchError extends ProductListState {
  final String message;
  final SearchInputMode searchInputMode;

  const ProductListSearchError({
    required this.message,
    this.searchInputMode = SearchInputMode.idle,
  });
}
