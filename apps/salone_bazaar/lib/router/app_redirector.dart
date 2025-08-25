import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salone_bazaar/router/route_paths.dart';
import 'package:store_repository/store_repository.dart';
import 'package:user_repository/user_repository.dart';

class AppRedirector {
  const AppRedirector();

  final UserRepository userRepository = UserRepository.instance;
  final StoreRepository storeRepository = StoreRepository.instance;

  String? handleAuthRedirect(GoRouterState state) {
    final isLoggedIn = userRepository.currentUser != null;
    final isLoggingIn = state.path == RoutePaths.signIn.path;

    if (!isLoggedIn && !isLoggingIn) {
      return RoutePaths.signIn.path;
    }
    if (isLoggedIn && isLoggingIn) {
      return RoutePaths.home.path;
    }
    return null;
  }

  Future<String?> handleSellerRedirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    final user = userRepository.currentUser;
    if (user == null) return RoutePaths.signIn.path;

    try {
      final store = await storeRepository.getOwnedStore();
      if (store == null || !store.status.isApproved) {
        return RoutePaths.home.path;
      }
    } catch (e) {
      return RoutePaths.home.path;
    }

    return null;
  }
}
