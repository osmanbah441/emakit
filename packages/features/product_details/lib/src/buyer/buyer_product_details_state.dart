part of 'buyer_product_details_cubit.dart';

sealed class BuyerProductDetailsState extends Equatable {
  const BuyerProductDetailsState();

  @override
  List<Object?> get props => [];
}

final class BuyerProductDetailsLoading extends BuyerProductDetailsState {
  const BuyerProductDetailsLoading();
}

final class BuyerProductDetailsLoaded extends BuyerProductDetailsState {
  final BuyerProductDetails product;
  final ProductVariation? selectedVariant;

  const BuyerProductDetailsLoaded({
    required this.product,
    required this.selectedVariant,
  });

  BuyerProductDetailsLoaded copyWith({
    BuyerProductDetails? product,
    ProductVariation? selectedVariant,
  }) {
    return BuyerProductDetailsLoaded(
      product: product ?? this.product,
      selectedVariant: selectedVariant ?? this.selectedVariant,
    );
  }

  @override
  List<Object?> get props => [product, selectedVariant];
}

final class BuyerProductDetailsError extends BuyerProductDetailsState {
  final String message;
  const BuyerProductDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
