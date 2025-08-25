class _AppRoute {
  final String name;
  final String path;

  const _AppRoute({required this.name, required this.path});
}

class RoutePaths {
  static const home = _AppRoute(name: 'home', path: '/');

  static const addEditProduct = _AppRoute(
    name: 'addEditProduct',
    path: '/add-edit-product',
  );

  static const cart = _AppRoute(name: 'cart', path: '/cart');

  static const checkout = _AppRoute(name: 'checkout', path: '/checkout');

  static const filter = _AppRoute(
    name: 'filter',
    path: '/filter/:id/:mainCategoryName',
  );

  static const manageCategories = _AppRoute(
    name: 'manageCategories',
    path: '/manage-categories',
  );

  static const productDetails = _AppRoute(
    name: 'productDetails',
    path: '/product-details/:productId',
  );

  static const productList = _AppRoute(
    name: 'productList',
    path: '/product-list',
  );

  static const profile = _AppRoute(name: 'profile', path: '/profile');

  static const signIn = _AppRoute(name: 'signIn', path: '/sign-in');

  static const orderList = _AppRoute(name: 'orderList', path: '/order-list');

  static const orderDetails = _AppRoute(
    name: 'orderDetails',
    path: '/order-details/:orderId',
  );

  static const sellerOnboarding = _AppRoute(
    name: 'sellerOnboarding',
    path: '/seller-onboarding',
  );

  static const storeDashboard = _AppRoute(
    name: 'storeDashboard',
    path: '/store-dashboard',
  );

  static const storeProducts = _AppRoute(
    name: 'storeProducts',
    path: '/store-products',
  );

  static const storeOrders = _AppRoute(
    name: 'storeOrders',
    path: '/store-orders',
  );

  static const storeProductsDetails = _AppRoute(
    name: 'store-products-details',
    path: '/store-products-details/:productId',
  );

  static const completeUserProfile = _AppRoute(
    name: 'completeUserProfile',
    path: '/complete-user-profile',
  );

  static const storeInfo = _AppRoute(
    name: 'storeInfo',
    path: '/store-info/:storeId',
  );

  static const storeDiscovery = _AppRoute(
    name: 'storeDiscovery',
    path: '/store-discovery',
  );
}
