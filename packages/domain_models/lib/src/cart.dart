import 'package:domain_models/domain_models.dart';

final class Cart {
  final String id;
  final List<CartItem> items;
  final double shipping;
  final double taxes;

  const Cart({
    required this.id,
    required this.items,
    this.shipping = 0.0,
    this.taxes = 0.0,
  });

  double get total => subTotal + shipping + taxes;

  double get subTotal =>
      items.fold<double>(0, (total, item) => total + item.totalPrice);
}

final class CartItem {
  final String id;
  final ProductVariation product;
  final int quantity;
  final String title;

  const CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.title,
  });

  double get totalPrice => product.price * quantity;
}
