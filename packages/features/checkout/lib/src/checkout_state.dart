part of 'checkout_cubit.dart';

class CheckoutState {
  final bool isLoading;
  final List<CartItem> items;
  final double shipping;
  final double taxAmount;

  const CheckoutState({
    this.isLoading = true,
    this.items = const [],
    this.shipping = 0.0,
    this.taxAmount = 0.0,
  });

  double get subtotal => items.fold(0.0, (sum, item) => sum + item.lineTotal);

  double get total => subtotal + shipping + taxAmount;

  CheckoutState copyWith({
    bool? isLoading,
    List<CartItem>? items,
    double? shipping,
    double? taxAmount,
  }) {
    return CheckoutState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      shipping: shipping ?? this.shipping,
      taxAmount: taxAmount ?? this.taxAmount,
    );
  }
}
