part of 'home_cubit.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.errorMessage = '',
    this.productCategories = const [],
    this.featuredStores = const [],
  });

  final HomeStatus status;
  final String errorMessage;
  final List<Category> productCategories;

  final List<Store> featuredStores;

  HomeState copyWith({
    HomeStatus? status,
    String? errorMessage,
    List<Category>? productCategories,
    List<Store>? featuredStores,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      productCategories: productCategories ?? this.productCategories,
      featuredStores: featuredStores ?? this.featuredStores,
    );
  }

  @override
  List<Object> get props => [
    status,
    errorMessage,
    productCategories,
    featuredStores,
  ];
}
