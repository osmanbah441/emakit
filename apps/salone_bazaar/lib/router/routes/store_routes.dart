import 'package:go_router/go_router.dart';
import 'package:salone_bazaar/router/route_paths.dart';
import 'package:salone_bazaar/router/store_scaffold_nav.dart';
import 'package:seller_dashboard/seller_dashboard.dart';
import 'package:seller_onboarding/seller_onboarding.dart';
import 'package:store_discovery/store_discovery.dart';
import 'package:store_info/store_info.dart';
import 'package:store_product_list/store_product_list.dart';

final storeRoutes = <RouteBase>[
  ShellRoute(
    // redirect: (context, state) =>
    //     AppRedirector().handleSellerRedirect(context, state),
    builder: (context, state, child) {
      return StoreScaffold(child: child, onUserLogoutTap: (c) {});
    },
    routes: [
      GoRoute(
        path: RoutePaths.storeDashboard.path,
        name: RoutePaths.storeDashboard.name,
        builder: (context, state) => StoreDashboardScreen(),
      ),
      GoRoute(
        path: RoutePaths.storeProducts.path,
        name: RoutePaths.storeProducts.name,
        builder: (context, state) => StoreProductListScreen(
          onProductTap: (context, productId) => context.pushNamed(
            RoutePaths.storeProductsDetails.name,
            pathParameters: {'productId': productId},
          ),
        ),
      ),
      GoRoute(
        path: RoutePaths.storeOrders.path,
        name: RoutePaths.storeOrders.name,
        builder: (context, state) => const StoreOrdersScreen(),
      ),
    ],
  ),
  GoRoute(
    path: RoutePaths.sellerOnboarding.path,
    name: RoutePaths.sellerOnboarding.name,
    builder: (context, state) => const SellerSignUpScreen(),
  ),
  GoRoute(
    path: RoutePaths.storeInfo.path,
    name: RoutePaths.storeInfo.name,
    builder: (context, _) => StoreInfoScreen(),
  ),
  GoRoute(
    path: RoutePaths.storeDiscovery.path,
    name: RoutePaths.storeDiscovery.name,
    builder: (context, state) => StoreDiscoveryScreen(
      onStoreTapped: (storeId) => context.pushNamed(
        RoutePaths.storeInfo.name,
        pathParameters: {'storeId': storeId},
      ),
    ),
  ),
];
