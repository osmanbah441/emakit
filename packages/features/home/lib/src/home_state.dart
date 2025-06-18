part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  const HomeState();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<Product> products;
  final String currentSearchTerm;
  final SearchInputMode searchInputMode;
  final Set<String> cartProductIds;
  final Set<String> wishlistProductIds;

  const HomeLoaded({
    required this.products,
    this.currentSearchTerm = '',
    this.searchInputMode = SearchInputMode.idle,
    this.cartProductIds = const {},
    this.wishlistProductIds = const {},
  });

  HomeLoaded copyWith({
    List<Product>? products,
    String? currentSearchTerm,
    SearchInputMode? searchInputMode,
    Set<String>? cartProductIds,
    Set<String>? wishlistProductIds,
  }) {
    return HomeLoaded(
      products: products ?? this.products,
      currentSearchTerm: currentSearchTerm ?? this.currentSearchTerm,
      searchInputMode: searchInputMode ?? this.searchInputMode,
      cartProductIds: cartProductIds ?? this.cartProductIds,
      wishlistProductIds: wishlistProductIds ?? this.wishlistProductIds,
    );
  }
}

class HomeError extends HomeState {
  final String message;
  final SearchInputMode searchInputMode;

  const HomeError({
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

// These states are emitted by HomeBloc to specifically handle search actions
class HomeIdleSearch extends HomeState {
  const HomeIdleSearch();
}

class HomeSearchProcessing extends HomeState {
  const HomeSearchProcessing();
}

class HomeSearchSuccess extends HomeState {
  final String result;
  final SearchInputMode searchInputMode;

  const HomeSearchSuccess({
    required this.result,
    this.searchInputMode = SearchInputMode.idle,
  });
}

class HomeSearchError extends HomeState {
  final String message;
  final SearchInputMode searchInputMode;

  const HomeSearchError({
    required this.message,
    this.searchInputMode = SearchInputMode.idle,
  });
}
