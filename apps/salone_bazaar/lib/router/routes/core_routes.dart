import 'package:cart/cart.dart';
import 'package:checkout/checkout.dart';
import 'package:go_router/go_router.dart';
import 'package:home/home.dart';
import '../route_paths.dart';

final coreRoutes = [
  GoRoute(
    path: RoutePaths.home.path,
    name: RoutePaths.home.name,
    builder: (context, state) => HomeScreen(
      onDiscoverStoreTap: () => context.goNamed(RoutePaths.storeDiscovery.name),
      onSeeMoreTap: () => context.goNamed(RoutePaths.productList.name),
      onLogInTap: () {},
      onProfileSettingsTap: () => context.goNamed(RoutePaths.profile.name),
      onApplyToSellTap: () => context.goNamed(RoutePaths.sellerOnboarding.name),
      onManageStoreTap: () => context.goNamed(RoutePaths.storeDashboard.name),
      onMyOrdersTap: () => context.goNamed(RoutePaths.orderList.name),
      onLogOutTap: () {},
      onCategoryCardTap: (id) => context.goNamed(
        RoutePaths.productList.name,
        queryParameters: {'categoryId': id},
      ),
    ),
  ),
  GoRoute(
    path: RoutePaths.cart.path,
    name: RoutePaths.cart.name,
    builder: (context, state) => CartScreen(
      onCheckoutTap: (context) => context.goNamed(RoutePaths.checkout.name),
    ),
  ),
  GoRoute(
    path: RoutePaths.checkout.path,
    name: RoutePaths.checkout.name,
    builder: (context, state) => const CheckoutScreen(),
  ),
];
