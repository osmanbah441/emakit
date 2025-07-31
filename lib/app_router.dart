import 'package:add_edit_product/add_edit_product.dart';
import 'package:api/api.dart';
import 'package:cart/cart.dart';
import 'package:checkout/checkout.dart';
import 'package:emakit/home.dart';
import 'package:emakit/store_scaffold.dart';
import 'package:filter/filter.dart';
import 'package:go_router/go_router.dart';
import 'package:home/home.dart';
import 'package:manage_categories/manage_categories.dart';
import 'package:order_details/order_details.dart';
import 'package:order_list/order_list.dart';
import 'package:product_details/product_details.dart';
import 'package:product_list/product_list.dart';
import 'package:profile/profile.dart';
import 'package:seller_dashboard/seller_dashboard.dart';
import 'package:seller_onboarding/seller_onboarding.dart';
import 'package:sign_in/sign_in.dart';
import 'package:store_product_details/store_product_details.dart';
import 'package:store_product_list/store_product_list.dart';

/// A class that centralizes all GoRouter configurations and path constants.
class AppRouter {
  /// Named routes for consistent navigation.
  static const String homeRouteName = 'home';
  static const String addEditProductRouteName = 'addEditProduct';
  static const String cartRouteName = 'cart';
  static const String checkoutRouteName = 'checkout';
  static const String filterRouteName = 'filter';
  static const String manageCategoriesRouteName = 'manageCategories';
  static const String productDetailsRouteName = 'productDetails';
  static const String productListRouteName = 'productList';
  static const String profileRouteName = 'profile';
  static const String signInRouteName = 'signIn';
  static const String orderListRouteName = 'orderList';
  static const String orderDetailsRouteName = 'orderDetails';
  static const String sellerOnboardingRouteName = 'sellerOnboarding';

  static const String storeDashboardRouteName = 'storeDashboard';
  static const String storeProductsRouteName = 'storeProducts';
  static const String storeOrdersRouteName = 'storeOrders';
  static const String storeProductsDetailsRouteName = "store-products-details";

  final GoRouter router = GoRouter(
    initialLocation: "/",
    routes: [
      ShellRoute(
        redirect: (context, state) async {
          final store = await Api.instance.userRepository.getStore;
          if (store == null || !store.status.isActive) {
            return "/";
          }
          return null;
        },
        builder: (context, state, child) {
          return StoreScaffold(child: child);
        },
        routes: [
          GoRoute(
            path: '/$storeDashboardRouteName',
            name: storeDashboardRouteName,

            builder: (context, state) => StoreDashboardScreen(),
          ),
          GoRoute(
            path: '/$storeProductsRouteName',
            name: storeProductsRouteName,
            builder: (context, state) => StoreProductListScreen(
              onProductTap: (context, productId) => context.goNamed(
                storeProductsDetailsRouteName,
                pathParameters: {'productId': productId},
              ),
              onCategoryFilterTap: (category) => context.goNamed(
                filterRouteName,
                pathParameters: {
                  'id': category.id!,
                  'mainCategoryName': category.name,
                },
              ),
              filterDialog: CategorySelectionAlertDialog(),
              onAddNewProductTap: (context) =>
                  context.goNamed(addEditProductRouteName),
            ),
          ),
          GoRoute(
            path: '/$storeOrdersRouteName',
            name: storeOrdersRouteName,
            builder: (context, state) => const StoreOrdersScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/',
        name: homeRouteName,
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        path: '/$addEditProductRouteName',
        name: addEditProductRouteName,
        builder: (context, state) => const AddEditProductScreen(),
      ),
      GoRoute(
        path: '/$cartRouteName',
        name: cartRouteName,
        builder: (context, state) => CartScreen(
          onCheckoutTap: (context) => context.goNamed(checkoutRouteName),
        ),
      ),
      GoRoute(
        path: '/$checkoutRouteName',
        name: checkoutRouteName,
        builder: (context, state) => const CheckoutScreen(),
      ),
      GoRoute(
        path: '/$filterRouteName/:id/:mainCategoryName',
        name: filterRouteName,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final mainCategoryName = state.pathParameters['mainCategoryName']!;
          return FilterScreen(id: id, mainCategoryName: mainCategoryName);
        },
      ),
      GoRoute(
        path: '/$manageCategoriesRouteName',
        name: manageCategoriesRouteName,
        builder: (context, state) => const ManageCategoryScreen(),
      ),
      GoRoute(
        path: '/$productDetailsRouteName/:productId',
        name: productDetailsRouteName,
        builder: (context, state) {
          final productId = state.pathParameters['productId']!;
          return ProductDetailsScreen(productId: productId);
        },
      ),
      GoRoute(
        path: '/$productListRouteName',
        name: productListRouteName,
        builder: (context, state) => ProductListScreen(
          filterDialog: CategorySelectionAlertDialog(),
          onAddNewProductTap: (context) =>
              context.goNamed(addEditProductRouteName),

          onCategoryFilterTap: (category) => context.goNamed(
            filterRouteName,
            pathParameters: {
              'id': category.id!,
              'mainCategoryName': category.name,
            },
          ),
          onProductTap: (context, productId) {
            print('go to id: $productId');
            //   context.goNamed(
            //   productDetailsRouteName,
            //   pathParameters: {'productId': productId},
            // );
          },
        ),
      ),
      GoRoute(
        path: '/$profileRouteName',
        name: profileRouteName,
        builder: (context, state) => ProfileScreen(
          onPaymentMethodsTap: () {
            // TODO: Implement navigation to payment methods
          },
          onDeliveryAddressesTap: () {
            // TODO: Implement navigation to delivery addresses
          },
          onUserAuthenticationRequired: (context) {
            context.goNamed(signInRouteName);
          },
          onBecomeSellerTap: (context) {
            context.goNamed(sellerOnboardingRouteName);
          },
        ),
      ),
      GoRoute(
        path: '/$signInRouteName',
        name: signInRouteName,
        builder: (context, state) => SignInScreen(
          onSignInSucessful: (context) {
            context.goNamed(homeRouteName);
          },
        ),
      ),
      GoRoute(
        path: '/$orderListRouteName',
        name: orderListRouteName,
        builder: (context, state) => MyOrdersScreen(
          // onOrderDetailsTap: (orderId) {
          //   context.goNamed(
          //     orderDetailsRouteName,
          //     pathParameters: {'orderId': orderId},
          //   );
          // },
        ),
      ),
      GoRoute(
        path: '/$orderDetailsRouteName/:orderId',
        name: orderDetailsRouteName,
        builder: (context, state) {
          final orderId = state.pathParameters['orderId']!;
          return OrderDetailsScreen();
        },
      ),
      GoRoute(
        path: '/$sellerOnboardingRouteName',
        name: sellerOnboardingRouteName,
        builder: (context, state) {
          return const BecomeSellerScreen();
        },
      ),
      GoRoute(
        path: '/$storeProductsDetailsRouteName/:productId',
        name: storeProductsDetailsRouteName,
        builder: (context, state) {
          final productId = state.pathParameters['productId']!;
          return StoreProductDetailsScreen(productId: productId);
        },
      ),
    ],
    redirect: (context, state) {
      final bool isLoggedIn = Api.instance.userRepository.currentUser != null;
      if (!isLoggedIn) return '/$signInRouteName';

      return null;
    },
  );
}
