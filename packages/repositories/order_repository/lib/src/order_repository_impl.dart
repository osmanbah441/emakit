import 'package:domain_models/domain_models.dart';
import 'package:order_repository/src/order_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderRepositoryImpl implements OrderRepository {
  final _client = Supabase.instance.client;

  @override
  Future<Order> getOrderById(String orderId) async {
    return await _client
        .from('v_orders_full_detail')
        .select()
        .eq('order_id', orderId)
        .single()
        .then((res) {
          return BuyerOrder.fromJson(res);
        });
  }

  @override
  Future<List<BuyerOrder>> getBuyerOrder() async {
    return await _client.from('v_orders_full_detail').select().then((res) {
      print(res);
      return res.map((o) => BuyerOrder.fromJson(o)).toList();
    });
  }

  @override
  Future<void> updateOrderItemStatus(String id, OrderItemStatus status) async {
    if (status == OrderItemStatus.approved) {
      await _client.functions.invoke(
        '/baz-wallet/checkout/confirm',
        body: {"orderItemId": id},
      );
    }

    if (status == OrderItemStatus.rejected) {
      await _client.functions.invoke(
        '/baz-wallet/checkout/cancel',
        body: {"orderItemId": id},
      );
    }

    if (status == OrderItemStatus.outForDelivery) {
      await _client
          .from('order_item')
          .update({'order_item_status': 'preparing_delivery'})
          .eq('id', id);
    }
  }

  @override
  Future<List<StoreOrderItemFulfillment>> getStoreOrders() async {
    try {
      return await _client
          .from('v_store_order_fulfillment')
          .select()
          .then(
            (res) => res
                .map((json) => StoreOrderItemFulfillment.fromJson(json))
                .toList(),
          );
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
