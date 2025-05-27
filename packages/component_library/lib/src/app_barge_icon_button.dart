// lib/components/app_badge_icon_button.dart
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class AppBadgeIconButton extends StatelessWidget {
  final int itemCount;
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  const AppBadgeIconButton({
    super.key,
    required this.itemCount,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return badges.Badge(
      badgeStyle: badges.BadgeStyle(
        badgeColor: colorScheme.error,
        padding: const EdgeInsets.all(5),
      ),
      // Badge content text uses onPrimary color from theme
      badgeContent: Text(
        itemCount.toString(),
        style: TextStyle(color: colorScheme.onPrimary, fontSize: 10),
      ),
      showBadge: itemCount > 0,
      position: badges.BadgePosition.topEnd(
        top: 0,
        end: -3,
      ), // Adjusted position slightly
      child: IconButton(
        icon: Icon(icon),
        tooltip: tooltip,
        onPressed: onPressed,
      ),
    );
  }
}
