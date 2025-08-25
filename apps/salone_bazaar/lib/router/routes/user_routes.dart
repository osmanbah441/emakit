// lib/router/routes/user_routes.dart

import 'package:complete_profile/complete_profile.dart';
import 'package:go_router/go_router.dart';
import 'package:profile/profile.dart';
import 'package:sign_in/sign_in.dart';
import '../route_paths.dart';

final userRoutes = [
  GoRoute(
    path: RoutePaths.signIn.path,
    name: RoutePaths.signIn.name,
    builder: (context, state) => SignInScreen(
      onSignInSucessful: () => context.goNamed(RoutePaths.home.name),
    ),
  ),
  GoRoute(
    path: RoutePaths.profile.path,
    name: RoutePaths.profile.name,
    builder: (context, state) => ProfileScreen(),
  ),
  GoRoute(
    path: RoutePaths.completeUserProfile.path,
    name: RoutePaths.completeUserProfile.name,
    builder: (context, state) => CompleteProfileScreen(
      onProfileComplete: () => context.goNamed(RoutePaths.home.name),
    ),
  ),
];
