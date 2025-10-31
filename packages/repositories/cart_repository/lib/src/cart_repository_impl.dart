part of 'cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  static const userId = '2a08ff78-1f4a-490c-8014-dcb8f6b83367'; // TODO: remove

  final _client = Supabase.instance.client;
  final _table = 'cart_item';

  @override
  Future<List<CartItem>> getItems() async {
    final res = await _client
        .from('v_user_cart_details')
        .select()
        .filter('user_id', 'eq', userId);

    return res.map((e) => CartItem.fromJson(e)).toList();
  }

  @override
  Future<void> update(String id, {int? quantity, bool? isSelected}) async {
    final data = {
      if (quantity != null) 'quantity': quantity,
      if (isSelected != null) 'is_selected': isSelected,
    };

    await _client.from(_table).update(data).eq('id', id);
  }

  @override
  Future<void> removeItem(String id) async {
    print('removing');
    try {
      await _client.from(_table).delete().eq('id', id);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> addItem({
    required String variantId,
    required String offerId,
  }) async {
    final data = {
      'offer_id': offerId,
      'user_id': userId,
      'variant_id': variantId,
    };
    await _client.from(_table).upsert(data, ignoreDuplicates: true);
  }
}
