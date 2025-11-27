import 'package:checkout/checkout.dart';
import 'package:go_router/go_router.dart';
import 'package:order_details/order_details.dart';
import 'package:order_list/order_list.dart';
import 'package:salone_bazaar/router/route_paths.dart';
import 'package:domain_models/domain_models.dart';
import 'package:sign_in/sign_in.dart';
import 'package:cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';
import 'package:product_search/product_search.dart';
import 'package:profile/profile.dart';
import 'package:salone_bazaar/router/buyer_scaffold_nav.dart';
import 'package:category_repository/category_repository.dart';
import 'package:store_repository/store_repository.dart';
import 'package:order_list/order_list.dart';
import 'package:product_repository/product_repository.dart';
import 'package:cart_repository/cart_repository.dart';
import 'package:order_repository/order_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:product_add_or_edit/product_add_or_edit.dart';
import 'package:product_and_variation_manager/product_and_variation_manager.dart';

import 'package:product_list/product_list.dart';
import 'package:product_details/product_details.dart';

class AppRouter {
  late final GoRouter router;

  final productRepository = ProductRepositoryImpl();
  final cartRepository = CartRepositoryImpl();
  final userRepository = UserRepositoryImpl();
  final orderRepository = OrderRepositoryImpl();
  final storeRepository = StoreRepositoryImpl();
  final categoryRepository = CategoryRepositoryImpl();

  AppRouter() {
    router = GoRouter(
      initialLocation: RoutePaths.home.path,
      debugLogDiagnostics: true,
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            return BuyerScaffoldNav(child: child);
          },
          routes: [
            GoRoute(
              path: RoutePaths.home.path,
              name: RoutePaths.home.name,
              builder: (context, state) => BuyerHomeScreen(
                onStoreTap: () => context.pushNamed(RoutePaths.storeHome.name),
                categoryRepository: CategoryRepositoryImpl(),
                storeRepository: StoreRepository.instance,
                onCategoryTap: (id) => context.pushNamed(
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
                onCheckoutTap: () =>
                    context.pushNamed(RoutePaths.checkout.name),
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
                onOrdersTapped: () =>
                    context.pushNamed(RoutePaths.orderList.name),
                onHelpTapped: () {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(content: Text('Help Feature coming soon!')),
                    );
                },
                onAboutTapped: () {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(content: Text('About Feature coming soon!')),
                    );
                },
                onNotificationTapped: () {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text('Notification Feature coming soon!'),
                      ),
                    );
                },

                onMessageTapped: () {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(content: Text('Message Feature coming soon!')),
                    );
                },
                onSavedAddressesTapped: () {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text('Saved Addresses Feature coming soon!'),
                      ),
                    );
                },
                onStartSellingTapped: () =>
                    context.pushNamed(RoutePaths.sellerOnboarding.name),
              ),
            ),
          ],
        ),

        GoRoute(
          path: RoutePaths.productList.path,
          name: RoutePaths.productList.name,
          builder: (context, state) {
            final categoryId = state.uri.queryParameters['categoryId']!;
            return BuyerProductListScreen(
              productRepository: productRepository,
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
              productRepository: productRepository,
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
        GoRoute(
          path: RoutePaths.orderList.path,
          name: RoutePaths.orderList.name,
          builder: (context, state) => OrderListScreen(
            orderRepository: orderRepository,
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
            return OrderDetailsScreen(
              id: orderId,
              orderRepository: orderRepository,
            );
          },
        ),

        GoRoute(
          path: RoutePaths.signIn.path,
          name: RoutePaths.signIn.name,
          builder: (context, _) =>
              SignInScreen(onSignInSucessful: () => context.pop()),
        ),

        // Store routes
        GoRoute(
          path: RoutePaths.storeHome.path,
          name: RoutePaths.storeHome.name,
          builder: (context, state) => StoreHomeScreen(
            storeRepository: storeRepository,
            onManageProductsTap: () =>
                context.pushNamed(RoutePaths.storeProducts.name),
            onViewOrderTap: () =>
                context.pushNamed(RoutePaths.storeOrders.name),
          ),
        ),

        GoRoute(
          path: RoutePaths.storeProducts.path,
          name: RoutePaths.storeProducts.name,
          builder: (context, state) => OfferListScreen(
            onProductTap: (productId) => context.pushNamed(
              RoutePaths.storeProductsDetails.name,
              pathParameters: {'productId': productId},
            ),
            onAddProduct: () =>
                context.pushNamed(RoutePaths.addEditProduct.name),
            productRepository: productRepository,
          ),
        ),

        GoRoute(
          path: RoutePaths.storeOrders.path,
          name: RoutePaths.storeOrders.name,
          builder: (context, state) => StoreOrderListScreen(
            orderRepository: orderRepository,
            onOrderTap: (id) {},
          ),
        ),

        GoRoute(
          path: RoutePaths.addEditProduct.path,
          name: RoutePaths.addEditProduct.name,
          builder: (context, state) => ProductAndVariationManagerScreen(
            productRepository: productRepository,
            categoryRepository: categoryRepository,
            onCreateProduct: (p) => context.pushNamed(
              RoutePaths.createProductWithVariationAndOffer.name,
              extra: p,
            ),
            onCreateOffer: (id) {
              context.pushNamed(
                RoutePaths.createOfferForVariant.name,
                pathParameters: {'variantId': id},
              );
            },
            onCreateVariation:
                ({required String productId, required String categoryId}) {
                  context.pushNamed(
                    RoutePaths.createVariationAndOffer.name,
                    pathParameters: {'productId': productId},
                    queryParameters: {'categoryId': categoryId},
                  );
                },
          ),
        ),

        GoRoute(
          path: RoutePaths.createOfferForVariant.path,
          name: RoutePaths.createOfferForVariant.name,
          builder: (context, state) {
            final variantId = state.pathParameters['variantId']!;
            return CreateOfferScreen(
              onManageOffers: () => context.push(RoutePaths.storeProducts.path),
              variantId: variantId,
              productRepository: productRepository,
            );
          },
        ),

        GoRoute(
          path: RoutePaths.createVariationAndOffer.path,
          name: RoutePaths.createVariationAndOffer.name,
          builder: (context, state) {
            final productId = state.pathParameters['productId']!;
            final categoryId = state.uri.queryParameters['categoryId']!;
            return CreateVariationAndOfferScreen(
              productId: productId,
              categoryId: categoryId,
               onManageOffer: () => context.push(RoutePaths.storeProducts.path),
              productRepository: productRepository,
              categoryRepository: categoryRepository,
            );
          },
        ),

        GoRoute(
          path: RoutePaths.createProductWithVariationAndOffer.path,
          name: RoutePaths.createProductWithVariationAndOffer.name,
          builder: (context, state) {
            final data = state.extra as ProductFormData;
            return CreateNewProductWithVariationAndOffer(productFormData: data, productRepository: productRepository,
               onManageOffer: () => context.push(RoutePaths.storeProducts.path),
            
            );
          },
        ),
      ],
    );
  }
}
