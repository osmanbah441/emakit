import 'package:flutter/material.dart';

enum _MenuItem { profileSettings, sellManageStore, myOrdersSwitchToBuy, logOut }

enum UserStoreState { noStore, pendingApproval, suspended, hasStore, managing }

class ProfileAvatarPopupMenu extends StatelessWidget {
  final UserStoreState storeState;
  final String? avatarImageUrl;
  final VoidCallback? onProfileSettingsTap;
  final VoidCallback? onApplyToSellTap;
  final VoidCallback? onManageStoreTap;
  final VoidCallback? onMyOrdersTap;
  final VoidCallback? onSwitchToBuyerTap;
  final VoidCallback? onLogOutTap;
  final VoidCallback? onContactSupportTap;

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
    this.onContactSupportTap,
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
            switch (storeState) {
              case UserStoreState.noStore:
                onApplyToSellTap?.call();
                break;
              case UserStoreState.hasStore:
                onManageStoreTap?.call();
                break;
              case UserStoreState.managing:
                // Should not appear
                break;
              case UserStoreState.pendingApproval:
                // Optional: show dialog/snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Your seller application is pending approval.',
                    ),
                  ),
                );
                break;
              case UserStoreState.suspended:
                if (onContactSupportTap != null) {
                  onContactSupportTap!();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Your store is suspended. Contact support.',
                      ),
                    ),
                  );
                }
                break;
            }
            break;
          case _MenuItem.myOrdersSwitchToBuy:
            if (storeState == UserStoreState.managing) {
              onSwitchToBuyerTap?.call();
            } else {
              onMyOrdersTap?.call();
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
          String label;
          bool disabled = false;

          switch (storeState) {
            case UserStoreState.noStore:
              label = 'Become a Seller';
              break;
            case UserStoreState.hasStore:
              label = 'Manage My Store';
              break;
            case UserStoreState.pendingApproval:
              label = 'Application Pending';
              disabled = true;
              break;
            case UserStoreState.suspended:
              label = 'Store Suspended';
              disabled = false; // Let user tap to contact support
              break;
            default:
              label = 'Manage My Store';
          }

          items.add(
            PopupMenuItem<_MenuItem>(
              value: disabled ? null : _MenuItem.sellManageStore,
              enabled: !disabled,
              child: Text(label),
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
