import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile/src/seller_section.dart';
import 'package:profile/src/user_info_section.dart';
import 'package:user_repository/user_repository.dart';
import 'package:store_repository/store_repository.dart';

import 'profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.onAuthenticationRequired,
    this.onEditProfilePictureTapped,
    this.onStartSellingTapped,
    this.onOrdersTapped,
    this.onSavedAddressesTapped,
    this.onPaymentMethodsTapped,
    this.onAboutTapped,
    this.onNotificationTapped,
    this.onHelpTapped,
  });

  final VoidCallback onAuthenticationRequired;
  final VoidCallback? onEditProfilePictureTapped;
  final VoidCallback? onStartSellingTapped;
  final VoidCallback? onOrdersTapped;
  final VoidCallback? onSavedAddressesTapped;
  final VoidCallback? onPaymentMethodsTapped;
  final VoidCallback? onNotificationTapped;
  final VoidCallback? onHelpTapped;
  final VoidCallback? onAboutTapped;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(
        userRepository: UserRepository.instance,
        storeRepository: StoreRepository.instance,
      ),
      child: ProfileView(
        onAuthenticationRequired: onAuthenticationRequired,
        onEditProfilePictureTapped: onEditProfilePictureTapped,
        onStartSellingTapped: onStartSellingTapped,
        onOrdersTapped: onOrdersTapped,
        onSavedAddressesTapped: onSavedAddressesTapped,
        onPaymentMethodsTapped: onPaymentMethodsTapped,
        onNotificationTapped: onNotificationTapped,
        onHelpTapped: onHelpTapped,
        onAboutTapped: onAboutTapped,
      ),
    );
  }
}

@visibleForTesting
class ProfileView extends StatelessWidget {
  const ProfileView({
    super.key,
    required this.onAuthenticationRequired,
    this.onEditProfilePictureTapped,
    this.onStartSellingTapped,
    this.onOrdersTapped,
    this.onSavedAddressesTapped,
    this.onPaymentMethodsTapped,
    this.onNotificationTapped,
    this.onHelpTapped,
    this.onAboutTapped,
  });

  final VoidCallback onAuthenticationRequired;
  final VoidCallback? onEditProfilePictureTapped;
  final VoidCallback? onStartSellingTapped;
  final VoidCallback? onOrdersTapped;
  final VoidCallback? onSavedAddressesTapped;
  final VoidCallback? onPaymentMethodsTapped;
  final VoidCallback? onNotificationTapped;
  final VoidCallback? onHelpTapped;
  final VoidCallback? onAboutTapped;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SafeArea(
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listenWhen: (previous, current) =>
              previous.updateStatus != current.updateStatus,
          listener: (context, state) {
            if (state.updateStatus == UpdateStatus.failure) {
              final snackBar = SnackBar(
                content: Text(state.error ?? 'An unexpected error occurred.'),
                backgroundColor: Theme.of(context).colorScheme.error,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, state) {
            // Show loading indicator for both initial load and subsequent fetches
            if (state.status == ProfileStatus.loading && state.user == null) {
              return const CenteredProgressIndicator();
            }

            // Handle authentication required state
            if (state.status == ProfileStatus.authenticationRequired) {
              return ExceptionIndicator.authentication(
                message:
                    'To view profile information, you need to sign in to your account',
                onLoginTapped: onAuthenticationRequired,
              );
            }

            // Handle page load failure
            if (state.status == ProfileStatus.failure) {
              return ExceptionIndicator(
                message: state.error,
                onButtonTapped: context.read<ProfileCubit>().refetch,
              );
            }

            if (state.user == null) {
              return const CenteredProgressIndicator();
            }

            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const UserInfoSection(),
                      const SizedBox(height: 16),

                      ExtendedElevatedButton(
                        label: 'Start Selling',
                        onPressed: onStartSellingTapped,
                        icon: const Icon(Icons.storefront),
                      ),
                      const SizedBox(height: 16),
                      WalletCard(
                        balance: 100,
                        ownerName: 'osman',
                        ownerEmail: 'osmanbah441@gmail.com'.substring(0, 21),
                        actionSection: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {},

                                icon: const Icon(Icons.phone_android),
                                label: const Text('Add Money'),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {},

                                icon: const Icon(Icons.swap_horiz),
                                label: const Text('Cash out'),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                      ActionListTile(
                        title: 'Orders',
                        icon: Icons.shopping_bag_outlined,
                        onTap: onOrdersTapped,
                      ),
                      ActionListTile(
                        title: 'Notifications',
                        icon: Icons.notifications_outlined,
                        onTap: onOrdersTapped,
                      ),
                      ActionListTile(
                        title: 'Saved Addresses',
                        icon: Icons.location_on_outlined,
                        onTap: onSavedAddressesTapped,
                      ),
                      ActionListTile(
                        title: 'Payment Methods',
                        icon: Icons.payment_outlined,
                        onTap: onPaymentMethodsTapped,
                      ),
                      ActionListTile(
                        title: 'Help & Support',
                        icon: Icons.help_outline_outlined,
                        onTap: onSavedAddressesTapped,
                      ),
                      ActionListTile(
                        title: 'About Us',
                        icon: Icons.info_outline,
                        onTap: onPaymentMethodsTapped,
                      ),
                      const SizedBox(height: 32),

                      ExtendedElevatedButton(
                        label: 'Log out',
                        onPressed: () => context.read<ProfileCubit>().logOut(),
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.errorContainer,
                        foregroundColor: Theme.of(
                          context,
                        ).colorScheme.onErrorContainer,
                        icon: Icon(Icons.logout),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
