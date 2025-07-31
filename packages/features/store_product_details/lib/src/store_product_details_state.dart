part of 'store_product_details_cubit.dart';

enum StoreProductDetailsStatus {
  initial,
  loading,
  success,
  error;

  bool get isInitial => this == StoreProductDetailsStatus.initial;
  bool get isLoading => this == StoreProductDetailsStatus.loading;
  bool get isSuccess => this == StoreProductDetailsStatus.success;
  bool get isError => this == StoreProductDetailsStatus.error;
}

class StoreProductDetailsState extends Equatable {
  const StoreProductDetailsState({
    this.product,
    this.status = StoreProductDetailsStatus.initial, // used for first page load
    this.variationDefinationFields,
    this.error,
  });

  final Product? product;
  final Map<String, List<String>>? variationDefinationFields;
  final StoreProductDetailsStatus status;
  final dynamic error;

  StoreProductDetailsState copyWith({
    Product? product,
    Map<String, List<String>>? variationDefinationFields,
    dynamic error,
    StoreProductDetailsStatus? status,
  }) {
    return StoreProductDetailsState(
      product: product ?? this.product,
      status: status ?? this.status,
      error: error ?? this.error,
      variationDefinationFields:
          variationDefinationFields ?? this.variationDefinationFields,
    );
  }

  @override
  List<Object?> get props => [product, error, status];
}
