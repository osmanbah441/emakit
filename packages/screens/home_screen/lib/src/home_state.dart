part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Product> products;
  final String currentSearchTerm;

  HomeLoaded(this.products, {this.currentSearchTerm = ''});

  HomeLoaded copyWith({
    List<Product>? products,
    String? currentSearchTerm,
    Set<String>? cartProductIds,
    Set<String>? wishlistProductIds,
  }) {
    return HomeLoaded(
      products ?? this.products,
      currentSearchTerm: currentSearchTerm ?? this.currentSearchTerm,
    );
  }
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
