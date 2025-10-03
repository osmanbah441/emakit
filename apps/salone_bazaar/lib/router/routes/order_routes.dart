import 'package:go_router/go_router.dart';
import 'package:order_details/order_details.dart';
import 'package:order_list/order_list.dart';
import '../route_paths.dart';

final orderRoutes = [
  GoRoute(
    path: RoutePaths.orderList.path,
    name: RoutePaths.orderList.name,
    builder: (context, state) => OrderListScreen(
      onOrderTap: (orderId) => context.pushNamed(
        RoutePaths.orderDetails.name,
        pathParameters: {'orderId': orderId},
      ),
    ),
  ),
  GoRoute(
    path: RoutePaths.orderDetails.path,
    name: RoutePaths.orderDetails.name,
    builder: (context, state) {
      final orderId = state.pathParameters['orderId']!;
      return OrderDetailsScreen(id: orderId);
    },
  ),
];
