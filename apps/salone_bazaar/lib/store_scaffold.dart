import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salone_bazaar/router/route_paths.dart';

class StoreOrdersScreen extends StatelessWidget {
  const StoreOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '📦 Orders List',
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
      ),
    );
  }
}

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class StoreScaffold extends StatelessWidget {
  const StoreScaffold({
    super.key,
    required this.child,
    required this.onUserLogoutTap,
  });

  final Function(BuildContext context) onUserLogoutTap;

  /// The widget to display in the body of the Scaffold.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Management'),
        actions: [
          ProfileAvatarPopupMenu(
            isSignedIn: true,
            storeState: UserStoreState.managing,
            onProfileSettingsTap: () {},
            onSwitchToBuyerTap: () => context.goNamed(RoutePaths.home.name),
            onLogOutTap: () => onUserLogoutTap(context),
          ),
        ],
      ),
      body: child,
      bottomNavigationBar: NavigationBar(
        animationDuration: const Duration(seconds: 2),
        elevation: 4,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.storefront_sharp),
            label: 'Products',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            label: 'Orders',
          ),
        ],
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (int idx) => _onItemTapped(idx, context),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    if (location == RoutePaths.storeDashboard.path) return 0;
    if (location == RoutePaths.storeProducts.path) return 1;
    if (location == RoutePaths.storeOrders.path) return 2;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.goNamed(RoutePaths.storeDashboard.name);
        break;
      case 1:
        context.goNamed(RoutePaths.storeProducts.name);
        break;
      case 2:
        context.goNamed(RoutePaths.storeOrders.name);
        break;
    }
  }
}
