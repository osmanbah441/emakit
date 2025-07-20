import 'package:flutter/material.dart';

enum _MenuItem { profileSettings, sellManageStore, myOrdersSwitchToBuy, logOut }

enum UserStoreState { noStore, hasStore, managing }

class ProfileAvatarPopupMenu extends StatelessWidget {
  final UserStoreState storeState;
  final String? avatarImageUrl;
  final VoidCallback? onProfileSettingsTap;
  final VoidCallback? onApplyToSellTap;
  final VoidCallback? onManageStoreTap;
  final VoidCallback? onMyOrdersTap;
  final VoidCallback? onSwitchToBuyerTap;
  final VoidCallback? onLogOutTap;

  const ProfileAvatarPopupMenu({
    super.key,
    required this.storeState,
    this.avatarImageUrl,
    this.onApplyToSellTap,
    this.onManageStoreTap,
    this.onProfileSettingsTap,
    this.onMyOrdersTap,
    this.onSwitchToBuyerTap,
    this.onLogOutTap,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_MenuItem>(
      onSelected: (_MenuItem item) {
        switch (item) {
          case _MenuItem.profileSettings:
            onProfileSettingsTap?.call();
            break;
          case _MenuItem.sellManageStore:
            if (storeState == UserStoreState.noStore) {
              onApplyToSellTap?.call();
            } else if (storeState == UserStoreState.hasStore) {
              onManageStoreTap?.call();
            }
            break;
          case _MenuItem.myOrdersSwitchToBuy:
            if (storeState == UserStoreState.hasStore ||
                storeState == UserStoreState.noStore) {
              onMyOrdersTap?.call();
            } else if (storeState == UserStoreState.managing) {
              onSwitchToBuyerTap?.call();
            }
            break;
          case _MenuItem.logOut:
            onLogOutTap?.call();
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        final items = <PopupMenuEntry<_MenuItem>>[
          const PopupMenuItem<_MenuItem>(
            value: _MenuItem.profileSettings,
            child: Text('Profile & Settings'),
          ),
        ];

        // Add Sell/Manage Store only if NOT managing the store
        if (storeState != UserStoreState.managing) {
          items.add(
            PopupMenuItem<_MenuItem>(
              value: _MenuItem.sellManageStore,
              child: Text(
                storeState == UserStoreState.noStore
                    ? 'Become a Seller'
                    : 'Manage My Store',
              ),
            ),
          );
        }

        items.add(
          PopupMenuItem<_MenuItem>(
            value: _MenuItem.myOrdersSwitchToBuy,
            child: Text(
              storeState == UserStoreState.managing
                  ? 'Switch to Buyer'
                  : 'My Orders',
            ),
          ),
        );

        items.add(const PopupMenuDivider());
        items.add(
          const PopupMenuItem<_MenuItem>(
            value: _MenuItem.logOut,
            child: Text('Log Out'),
          ),
        );

        return items;
      },
      icon: CircleAvatar(
        backgroundImage: avatarImageUrl != null
            ? NetworkImage(avatarImageUrl!)
            : null,
        backgroundColor: Colors.grey,
        child: avatarImageUrl == null
            ? const Icon(Icons.person, color: Colors.white)
            : null,
      ),
      offset: const Offset(0, 40),
    );
  }
}
