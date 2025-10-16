// lib/router/routes/user_routes.dart

import 'package:go_router/go_router.dart';
import 'package:sign_in/sign_in.dart';
import '../route_paths.dart';

final userRoutes = [
  GoRoute(
    path: RoutePaths.signIn.path,
    name: RoutePaths.signIn.name,
    builder: (context, _) =>
        SignInScreen(onSignInSucessful: () => context.pop()),
  ),
];
