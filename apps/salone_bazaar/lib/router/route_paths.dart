class RoutePaths {
  static final home = (name: 'home', path: '/');
  static final storeHome = (name: 'storeHome', path: '/store-home');

  static final addEditProduct = (
    name: 'addEditProduct',
    path: '/add-edit-product',
  );

  static final cart = (name: 'cart', path: '/cart');

  static final checkout = (name: 'checkout', path: '/checkout');

  static final filter = (name: 'filter', path: '/filter/:id/:mainCategoryName');

  static final manageCategories = (
    name: 'manageCategories',
    path: '/manage-categories',
  );

  static final productDetails = (
    name: 'productDetails',
    path: '/product-details/:productId',
  );

  static final productList = (name: 'productList', path: '/product-list');

  static final profile = (name: 'profile', path: '/profile');

  static final search = (name: 'search', path: '/search');

  static final signIn = (name: 'signIn', path: '/sign-in');

  static final orderList = (name: 'orderList', path: '/order-list');

  static final orderDetails = (
    name: 'orderDetails',
    path: '/order-details/:orderId',
  );

  static final sellerOnboarding = (
    name: 'sellerOnboarding',
    path: '/seller-onboarding',
  );

  static final storeDashboard = (
    name: 'storeDashboard',
    path: '/store-dashboard',
  );

  static final storeProducts = (name: 'storeProducts', path: '/store-products');

  static final storeOrders = (name: 'storeOrders', path: '/store-orders');

  static final storeProductsDetails = (
    name: 'store-products-details',
    path: '/store-products-details/:productId',
  );

  static final completeUserProfile = (
    name: 'completeUserProfile',
    path: '/complete-user-profile',
  );

  static final storeInfo = (name: 'storeInfo', path: '/store-info/:storeId');

  static final storeDiscovery = (
    name: 'storeDiscovery',
    path: '/store-discovery',
  );

  static final createOfferForVariant = (
    name: 'createOfferForVariant',
    path: '/create-offer/:variantId',
  );

  static final createVariationAndOffer = (
    name: 'createVariationAndOffer',
    path: '/create-variation-and-offer/:productId',
  );
}
