part of 'product_details_cubit.dart';

enum ActionStatus { initial, loading, success, failure }

class ProductDetailsState extends Equatable {
  final Product? product;
  final MeasurementUnit measurementUnit;
  final ActionStatus status;
  final String? error;

  const ProductDetailsState({
    this.product,
    this.measurementUnit = MeasurementUnit.inches,
    this.status = ActionStatus.initial,
    this.error,
  });

  ProductDetailsState copyWith({
    Product? product,
    MeasurementUnit? measurementUnit,
    ActionStatus? status,
    String? error,
  }) {
    return ProductDetailsState(
      product: product ?? this.product,
      measurementUnit: measurementUnit ?? this.measurementUnit,
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  List<Object?> get props => [product, measurementUnit, status, error];
}
