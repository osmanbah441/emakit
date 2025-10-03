import 'package:domain_models/domain_models.dart';

part 'cart_repository_impl.dart';

abstract class CartRepository {
  static final CartRepository instance = CartRepositoryImpl();

  List<CartItem> getItems();
  void incrementQuantity(String productId);
  void decrementQuantity(String productId);
  void removeItem(String productId);
  void toggleItemSelection(String productId);

  Future<void> addItem({required String productId, int? quantity}) async {}
}
