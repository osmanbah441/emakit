part of 'product_details_cubit.dart';

enum ActionStatus { initial, loading, success, failure }

class ProductDetailsState extends Equatable {
  final Product? product;
  final Store? store;
  final MeasurementUnit measurementUnit;
  final ActionStatus status;
  final String? error;

  final ProductVariation? selectedVariation;

  const ProductDetailsState({
    this.product,
    this.store,
    this.measurementUnit = MeasurementUnit.inches,
    this.status = ActionStatus.initial,
    this.error,
    this.selectedVariation,
  });

  ProductDetailsState copyWith({
    Product? product,
    MeasurementUnit? measurementUnit,
    ActionStatus? status,
    String? error,
    Store? store,
    ProductVariation? selectedVariation,
  }) {
    return ProductDetailsState(
      product: product ?? this.product,
      measurementUnit: measurementUnit ?? this.measurementUnit,
      status: status ?? this.status,
      error: error,
      store: store ?? this.store,
      selectedVariation: selectedVariation ?? this.selectedVariation,
    );
  }

  @override
  List<Object?> get props => [
    product,
    measurementUnit,
    status,
    error,
    store,
    selectedVariation,
  ];
}
