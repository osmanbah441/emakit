import 'dart:math';

import 'package:order_repository/order_repository.dart';
import 'package:domain_models/domain_models.dart';

final class OrderRepositoryImpl implements OrderRepository {
  const OrderRepositoryImpl();

  @override
  Future<Order> getOrderById(String orderId) {
    // TODO: implement getOrderById
    throw UnimplementedError();
  }

  @override
  Future<void> createOrder(Order order) async {
    await Future.delayed(const Duration(seconds: 2));
    if (Random().nextBool()) {
      print('Processing purchase for: ${order.id}');
    } else {
      throw Exception('Failed to process purchase. Please try again.');
    }
  }

  @override
  Future<void> addItem({required String productId, int quantity = 1}) async {
    await Future.delayed(const Duration(seconds: 2));
    if (Random().nextBool()) {
      print('Added item to cart: $productId, quantity: $quantity');
    } else {
      throw Exception('Failed to add item to cart. Please try again.');
    }
  }
}
