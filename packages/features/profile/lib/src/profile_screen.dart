import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:store_repository/store_repository.dart';
import 'package:wallet/wallet.dart';

import 'profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.onAuthenticationRequired,
    this.onEditProfilePictureTapped,
    this.onStartSellingTapped,
    this.onOrdersTapped,
    this.onSavedAddressesTapped,
    this.onMessageTapped,
    this.onAboutTapped,
    this.onNotificationTapped,
    this.onHelpTapped,
  });

  final VoidCallback onAuthenticationRequired;
  final VoidCallback? onEditProfilePictureTapped;
  final VoidCallback? onStartSellingTapped;
  final VoidCallback? onOrdersTapped;
  final VoidCallback? onSavedAddressesTapped;
  final VoidCallback? onMessageTapped;
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
      child: Scaffold(
        appBar: AppBar(),
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
                        const GenericWalletCard(),

                        const SizedBox(height: 40),

                        _ActionTile(
                          title: 'Orders',
                          icon: Icons.shopping_bag_outlined,
                          onTap: onOrdersTapped,
                        ),
                        _ActionTile(
                          title: 'Notifications',
                          icon: Icons.notifications_outlined,
                          onTap: onNotificationTapped,
                        ),
                        _ActionTile(
                          title: 'Saved Addresses',
                          icon: Icons.location_on_outlined,
                          onTap: onSavedAddressesTapped,
                        ),
                        _ActionTile(
                          title: 'Messages',
                          icon: Icons.message_outlined,
                          onTap: onMessageTapped,
                        ),
                        _ActionTile(
                          title: 'Help & Support',
                          icon: Icons.help_outline_outlined,
                          onTap: onHelpTapped,
                        ),
                        _ActionTile(
                          title: 'About Us',
                          icon: Icons.info_outline,
                          onTap: onAboutTapped,
                        ),
                        const SizedBox(height: 32),
                        PrimaryActionButton(
                          label: 'Start Selling',
                          onPressed: onStartSellingTapped,
                          icon: const Icon(Icons.storefront),
                        ),
                        const SizedBox(height: 16),

                        PrimaryActionButton(
                          label: 'Log out',
                          onPressed: () =>
                              context.read<ProfileCubit>().logOut(),
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
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.icon, required this.title, this.onTap});

  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: Icon(
        icon,
        size: 24,
        color: Theme.of(context).colorScheme.primary,
      ),
      onTap: onTap,
      title: Text(title),
    );
  }
}
