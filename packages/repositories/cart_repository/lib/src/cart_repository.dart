import 'package:domain_models/domain_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'cart_repository_impl.dart';

abstract class CartRepository {
  static final CartRepository instance = CartRepositoryImpl();

  Future<List<CartItem>> getItems({bool onlySelected = false});
  Future<void> update(String id, {int? quantity, bool? isSelected});
  Future<void> removeItem(String id);
  Future<void> addItem({required String variantId, required String offerId});
}
