import 'package:api/api.dart';
import 'package:component_library/component_library.dart';
import 'package:emakit/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
  const StoreScaffold({super.key, required this.child});

  /// The widget to display in the body of the Scaffold.
  final Widget child;

  void _logout() async {
    await Api.instance.userRepository.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Management'),
        actions: [
          ProfileAvatarPopupMenu(
            storeState: UserStoreState.managing,
            onProfileSettingsTap: () {},
            onSwitchToBuyerTap: () => context.goNamed(AppRouter.homeRouteName),
            onLogOutTap: () {
              _logout();
              context.goNamed(AppRouter.signInRouteName);
            },
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
            label: 'shop',
          ),
          NavigationDestination(
            icon: Icon(Icons.storefront_sharp),
            label: 'products',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            label: 'orders',
          ),
        ],
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (int idx) => _onItemTapped(idx, context),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location == "/${AppRouter.sellerOnboardingRouteName}") return 0;
    if (location == "/${AppRouter.storeProductsRouteName}") return 1;
    if (location == "/${AppRouter.storeOrdersRouteName}") return 2;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    if (index == 0) context.goNamed(AppRouter.storeDashboardRouteName);
    if (index == 1) context.goNamed(AppRouter.storeProductsRouteName);
    if (index == 2) context.goNamed(AppRouter.storeOrdersRouteName);
  }
}
