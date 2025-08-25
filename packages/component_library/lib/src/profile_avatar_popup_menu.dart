import 'package:flutter/material.dart';

enum UserStoreState { noStore, pendingApproval, suspended, hasStore, managing }

class ProfileAvatarPopupMenu extends StatelessWidget {
  final UserStoreState storeState;
  final bool isSignedIn;
  final String? avatarImageUrl;
  final VoidCallback? onProfileSettingsTap;
  final VoidCallback? onApplyToSellTap;
  final VoidCallback? onManageStoreTap;
  final VoidCallback? onMyOrdersTap;
  final VoidCallback? onSwitchToBuyerTap;
  final VoidCallback? onLogInTap;
  final VoidCallback? onLogOutTap;
  final VoidCallback? onContactSupportTap;

  const ProfileAvatarPopupMenu({
    super.key,
    required this.storeState,
    required this.isSignedIn,
    this.avatarImageUrl,
    this.onProfileSettingsTap,
    this.onApplyToSellTap,
    this.onManageStoreTap,
    this.onMyOrdersTap,
    this.onSwitchToBuyerTap,
    this.onLogInTap,
    this.onLogOutTap,
    this.onContactSupportTap,
  });

  PopupMenuEntry _buildStoreActionItem(BuildContext context) {
    switch (storeState) {
      case UserStoreState.noStore:
        return PopupMenuItem(
          onTap: onApplyToSellTap,
          enabled: onApplyToSellTap != null,
          child: const Text('Become a Seller'),
        );
      case UserStoreState.hasStore:
        return PopupMenuItem(
          onTap: onManageStoreTap,
          enabled: onManageStoreTap != null,
          child: const Text('Manage My Store'),
        );
      case UserStoreState.pendingApproval:
        return const PopupMenuItem(
          enabled: false,
          child: Text('Application Pending'),
        );
      case UserStoreState.suspended:
        return const PopupMenuItem(
          enabled: false,
          child: Text('Store Suspended'),
        );
      case UserStoreState.managing:
        return const PopupMenuItem(height: 0, child: SizedBox.shrink());
    }
  }

  List<PopupMenuEntry> _buildMenuItems(BuildContext context) {
    // If user is not signed in, only show the Log In option.
    if (!isSignedIn) {
      return [
        PopupMenuItem(
          onTap: onLogInTap,
          enabled: onLogInTap != null,
          child: const Text('Log In'),
        ),
      ];
    }

    // If signed in, build the full menu.
    final items = <PopupMenuEntry>[
      PopupMenuItem(
        onTap: onProfileSettingsTap,
        enabled: onProfileSettingsTap != null,
        child: const Text('Profile & Settings'),
      ),
    ];

    if (storeState != UserStoreState.managing) {
      items.add(_buildStoreActionItem(context));
    }

    if (storeState == UserStoreState.managing) {
      items.add(
        PopupMenuItem(
          onTap: onSwitchToBuyerTap,
          enabled: onSwitchToBuyerTap != null,
          child: const Text('Switch to Buyer'),
        ),
      );
    } else {
      items.add(
        PopupMenuItem(
          onTap: onMyOrdersTap,
          enabled: onMyOrdersTap != null,
          child: const Text('My Orders'),
        ),
      );
    }

    items.addAll([
      const PopupMenuDivider(),
      PopupMenuItem(
        onTap: onLogOutTap,
        enabled: onLogOutTap != null,
        child: const Text('Log Out'),
      ),
    ]);

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: _buildMenuItems,
      icon: CircleAvatar(
        backgroundImage: avatarImageUrl != null
            ? NetworkImage(avatarImageUrl!)
            : null,
        backgroundColor: Colors.grey.shade400,
        child: avatarImageUrl == null
            ? const Icon(Icons.person, color: Colors.white)
            : null,
      ),
      offset: const Offset(0, 40),
    );
  }
}
