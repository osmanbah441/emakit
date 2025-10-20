import 'package:go_router/go_router.dart';
import 'package:product_details/product_details.dart';
import 'package:product_list/product_list.dart';
import 'package:store_product_details/store_product_details.dart';
import '../route_paths.dart';

final productRoutes = [
  GoRoute(
    path: RoutePaths.productList.path,
    name: RoutePaths.productList.name,
    builder: (context, state) {
      final categoryId = state.uri.queryParameters['categoryId']!;
      return BuyerProductListScreen(
        parentCategoryId: categoryId,
        onProductSelected: (productId) => context.pushNamed(
          RoutePaths.productDetails.name,

          pathParameters: {'productId': productId},
        ),
      );
    },
  ),
  GoRoute(
    path: RoutePaths.productDetails.path,
    name: RoutePaths.productDetails.name,
    builder: (context, state) {
      final productId = state.pathParameters['productId']!;
      return ProductDetailsScreen(
        productId: productId,
        onVisitStoreTap: (storeId) => context.pushNamed(
          RoutePaths.storeInfo.name,
          pathParameters: {'storeId': storeId},
        ),
      );
    },
  ),
  GoRoute(
    path: RoutePaths.storeProductsDetails.path,
    name: RoutePaths.storeProductsDetails.name,
    builder: (context, state) {
      final productId = state.pathParameters['productId']!;
      return StoreProductDetailsScreen(productId: productId);
    },
  ),
];
