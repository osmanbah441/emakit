import 'package:api/api.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback? onOrderHistoryTap;
  final VoidCallback? onPaymentMethodsTap;
  final VoidCallback? onDeliveryAddressesTap;
  final void Function(BuildContext context) onUserAuthenticationRequired;
  final void Function(BuildContext context)? onBecomeSellerTap;

  const ProfileScreen({
    super.key,
    this.onOrderHistoryTap,
    this.onPaymentMethodsTap,
    this.onDeliveryAddressesTap,
    required this.onUserAuthenticationRequired,
    this.onBecomeSellerTap,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  final userRepository = Api.instance.userRepository;

  void logout() async {
    await userRepository.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: userRepository.authChanges(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const CenteredProgressIndicator();
          }

          if (asyncSnapshot.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${asyncSnapshot.error}')),
            );
            return const SizedBox.shrink();
          }

          final user = asyncSnapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(
                    user.photoURL ?? 'https://via.placeholder.com/150',
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  user.displayName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                const SizedBox(height: 30),

                if (user.phoneNumber == null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PhoneNumberInputField(
                      controller: _phoneNumberController,
                    ),
                  )
                else
                  ListTile(
                    title: Text(
                      'Phone Number',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    subtitle: Text(
                      user.phoneNumber!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    leading: const Icon(Icons.phone),
                  ),
                ListTile(
                  title: Text(
                    'Google Account',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  subtitle: Text(
                    user.email != null
                        ? user.email!
                        : 'Linked with email@example.com',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  leading: Image.asset(
                    'assets/google_icon.png',
                    package: 'component_library',
                    width: 24,
                    height: 24,
                  ),
                  trailing: user.email == null
                      ? null
                      : TextButton(onPressed: () {}, child: Text('Link')),
                ),
                ListTile(
                  title: Text(
                    'Order History',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: widget.onOrderHistoryTap,
                ),
                ListTile(
                  title: Text(
                    'Payment Methods',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: widget.onPaymentMethodsTap,
                ),
                ListTile(
                  title: Text(
                    'Delivery Addresses',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: widget.onDeliveryAddressesTap,
                ),
                const SizedBox(height: 16),

                ExtendedElevatedButton(label: 'Log out', onPressed: logout),
                const SizedBox(height: 16),

                ExtendedOutlineButton(
                  label: 'Become a seller',
                  onPressed: () => widget.onBecomeSellerTap?.call(context),
                  icon: const Icon(Icons.store),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
