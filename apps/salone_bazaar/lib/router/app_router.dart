import 'package:go_router/go_router.dart';
import 'package:salone_bazaar/router/route_paths.dart';

import 'routes/core_routes.dart';
import 'routes/order_routes.dart';
import 'routes/product_routes.dart';
import 'routes/store_routes.dart';
import 'routes/user_routes.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      initialLocation: RoutePaths.home.path,
      routes: [
        ...storeRoutes,
        ...coreRoutes,
        ...productRoutes,
        ...orderRoutes,
        ...userRoutes,
      ],
    );
  }
}
