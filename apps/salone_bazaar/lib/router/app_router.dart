import 'package:checkout/checkout.dart';
import 'package:go_router/go_router.dart';
import 'package:salone_bazaar/router/route_paths.dart';
import 'package:domain_models/domain_models.dart';

import 'routes/core_routes.dart';
import 'routes/order_routes.dart';
import 'routes/user_routes.dart';

import 'package:product_repository/product_repository.dart';
import 'package:cart_repository/cart_repository.dart';
import 'package:user_repository/user_repository.dart';

import 'package:product_list/product_list.dart';
import 'package:product_details/product_details.dart';

class AppRouter {
  late final GoRouter router;

  static const _role = ApplicationRole.buyer;
  final productRepositoryImpl = ProductRepositoryImpl(role: _role);
  final cartRepository = CartRepositoryImpl();
  final userRepository = UserRepositoryImpl();

  AppRouter() {
    router = GoRouter(
      initialLocation: RoutePaths.home.path,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: RoutePaths.productList.path,
          name: RoutePaths.productList.name,
          builder: (context, state) {
            final categoryId = state.uri.queryParameters['categoryId']!;
            return BuyerProductListScreen(
              productRepository: productRepositoryImpl,
              parentCategoryId: categoryId,
              onProductTap: (productId, variantId) => context.pushNamed(
                RoutePaths.productDetails.name,
                queryParameters: {'variantId': variantId},
                pathParameters: {'productId': productId},
              ),
            );
          },
        ),
        GoRoute(
          path: RoutePaths.productDetails.path,
          name: RoutePaths.productDetails.name,
          builder: (context, state) {
            final variantId = state.uri.queryParameters['variantId']!;

            return BuyerProductDetailsScreen(
              productRepository: productRepositoryImpl,
              cartRepository: cartRepository,
              userRepository: userRepository,
              variantId: variantId,
              onVisitStoreTap: (storeId) => context.pushNamed(
                RoutePaths.storeInfo.name,
                pathParameters: {'storeId': storeId},
              ),
            );
          },
        ),
        GoRoute(
          path: RoutePaths.checkout.path,
          name: RoutePaths.checkout.name,
          builder: (context, state) =>
              CheckoutScreen(cartRepository: cartRepository),
        ),
        // ...storeRoutes,
        ...coreRoutes,
        ...orderRoutes,
        ...userRoutes,
      ],
    );
  }
}
