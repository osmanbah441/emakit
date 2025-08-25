import 'package:domain_models/domain_models.dart';

import 'order_repository_impl.dart';

abstract class OrderRepository {
  const OrderRepository._();

  static const OrderRepository instance = OrderRepositoryImpl();
  Future<Order> getOrderById(String orderId);

  Future<void> createOrder(Order order);

  Future<void> addItem({required String productId, int quantity = 1});
}
