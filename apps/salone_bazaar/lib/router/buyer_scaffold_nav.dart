import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'route_paths.dart';

class BuyerScaffoldNav extends StatelessWidget {
  const BuyerScaffoldNav({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: child,
        bottomNavigationBar: NavigationBar(
          animationDuration: const Duration(seconds: 2),
          elevation: 4,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: _calculateSelectedIndex(context),
          onDestinationSelected: (int idx) => _onItemTapped(idx, context),
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.search),
              icon: Icon(Icons.search_outlined),
              label: 'Search',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.shopping_cart),
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Cart',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person),
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  /// Determines the selected index of the BottomNavigationBar based on the current route.
  static int _calculateSelectedIndex(BuildContext context) {
    // Get the current location from the router state.
    final String location = GoRouterState.of(context).matchedLocation;

    // Compare the location with your defined route paths.
    if (location == RoutePaths.home.path) return 0;
    if (location == RoutePaths.search.path) return 1;
    if (location == RoutePaths.cart.path) return 2;
    if (location == RoutePaths.profile.path) return 3;

    // Default to the first index (Home) if no match is found.
    return 0;
  }

  /// Handles navigation when a bottom navigation bar item is tapped.
  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.goNamed(RoutePaths.home.name);
        break;
      case 1:
        context.goNamed(RoutePaths.search.name);
        break;
      case 2:
        context.goNamed(RoutePaths.cart.name);
        break;
      case 3:
        context.goNamed(RoutePaths.profile.name);
        break;
    }
  }
}
