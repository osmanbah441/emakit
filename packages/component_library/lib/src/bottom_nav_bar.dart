import 'package:flutter/material.dart';

enum BottomNavRole { buyer, seller }

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.onDestinationSelected,
    required this.selectedIndex,
    this.role = BottomNavRole.buyer,
  });

  final void Function(int index) onDestinationSelected;
  final int selectedIndex;
  final BottomNavRole role;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      destinations: [
        NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),

        NavigationDestination(
          icon: Icon(switch (role) {
            BottomNavRole.buyer => Icons.shopping_cart_outlined,
            BottomNavRole.seller => Icons.shopping_bag_outlined,
          }),
          label: switch (role) {
            BottomNavRole.buyer => 'Cart',
            BottomNavRole.seller => 'Orders',
          },
        ),
        NavigationDestination(
          icon: Icon(Icons.person_2_outlined),
          label: 'Profile',
        ),
      ],
    );
  }
}
