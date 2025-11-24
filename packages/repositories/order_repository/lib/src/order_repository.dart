import 'package:domain_models/domain_models.dart';

abstract class OrderRepository {
  const OrderRepository._();

  Future<Order> getOrderById(String orderId);
  Future<List<BuyerOrder>> getBuyerOrder();
  Future<List<StoreOrderItemFulfillment>> getStoreOrders();
  Future<void> updateOrderItemStatus(String id, OrderItemStatus status);
}
