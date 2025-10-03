import 'package:cart/cart.dart';
import 'package:checkout/checkout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home/home.dart';
import 'package:product_search/product_search.dart';
import 'package:profile/profile.dart';
import 'package:salone_bazaar/router/buyer_scaffold_nav.dart';

import '../route_paths.dart';

final coreRoutes = [
  ShellRoute(
    builder: (context, state, child) {
      return BuyerScaffoldNav(child: child);
    },
    routes: [
      // home
      GoRoute(
        path: RoutePaths.home.path,
        name: RoutePaths.home.name,
        builder: (context, state) => HomeScreen(
          onSeeAllStoreTap: () =>
              context.pushNamed(RoutePaths.storeDiscovery.name),
          onDealsTap: () => ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('Deals Feature coming soon!')),
            ),
          onFeaturedProductTap: () => ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('Featured Product Feature coming soon!')),
            ),
          onNewArrivalsTap: () => ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(' New Arrivals Feature coming soon!')),
            ),
          onTrendingTap: () => ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('Trending Products Feature coming soon!')),
            ),

          onStoreCardTap: (storeId) => context.pushNamed(
            RoutePaths.storeInfo.name,
            pathParameters: {'storeId': storeId},
          ),
          onCategoryCardTap: (id) => context.pushNamed(
            RoutePaths.productList.name,
            queryParameters: {'categoryId': id},
          ),
        ),
      ),

      // search
      GoRoute(
        path: RoutePaths.search.path,
        name: RoutePaths.search.name,
        builder: (context, state) => ProductSearchScreen(),
      ),

      // cart
      GoRoute(
        path: RoutePaths.cart.path,
        name: RoutePaths.cart.name,
        builder: (context, state) => CartScreen(
          onCheckoutTap: () => context.pushNamed(RoutePaths.checkout.name),
          onLoginTapped: () => context.pushNamed(RoutePaths.signIn.name),
        ),
      ),

      // profile
      GoRoute(
        path: RoutePaths.profile.path,
        name: RoutePaths.profile.name,
        builder: (context, state) => ProfileScreen(
          onAuthenticationRequired: () =>
              context.pushNamed(RoutePaths.signIn.name),
          onOrdersTapped: () => context.pushNamed(RoutePaths.orderList.name),
          onHelpTapped: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Help Feature coming soon!')),
            );
          },
          onAboutTapped: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('About Feature coming soon!')),
            );
          },
          onNotificationTapped: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Notification Feature coming soon!')),
            );
          },

          onPaymentMethodsTapped: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Payment Methods Feature coming soon!')),
            );
          },
          onSavedAddressesTapped: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Saved Addresses Feature coming soon!')),
            );
          },
          onStartSellingTapped: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Start Selling Feature coming soon!')),
            );
          },
        ),
      ),
    ],
  ),
  GoRoute(
    path: RoutePaths.checkout.path,
    name: RoutePaths.checkout.name,
    builder: (context, state) => const CheckoutScreen(),
  ),
];
