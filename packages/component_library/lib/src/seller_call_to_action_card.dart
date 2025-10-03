import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class SellerCallToActionCard extends StatelessWidget {
  const SellerCallToActionCard._({
    super.key,
    required this.title,
    required this.subtitle,
    this.buttonLabel,
    this.onButtonTapped,
  });

  final String title;
  final String subtitle;
  final String? buttonLabel;
  final VoidCallback? onButtonTapped;

  const SellerCallToActionCard.newStore({
    Key? key,
    required VoidCallback onStartSellingTapped,
  }) : this._(
         key: key,
         title: 'Become a Seller',
         buttonLabel: 'Start Selling',
         onButtonTapped: onStartSellingTapped,
         subtitle:
             'Join our community of sellers. List your items, connect with buyers, and turn your passion into profit.',
       );

  const SellerCallToActionCard.existingStore({
    Key? key,
    required VoidCallback onManageStoreTapped,
  }) : this._(
         key: key,
         title: 'Welcome Back, Seller!',
         buttonLabel: 'Manage Store',
         onButtonTapped: onManageStoreTapped,
         subtitle:
             'Ready to check on your shop? Here you can see your latest sales, keep track of orders, and manage all of your products.',
       );

  const SellerCallToActionCard.pendingApproval({Key? key})
    : this._(
        key: key,
        title: 'Pending Approval',
        subtitle: 'Your store is awaiting approval.',
      );

  const SellerCallToActionCard.suspended({Key? key})
    : this._(
        key: key,
        title: 'Suspended',
        subtitle: 'Your store has been suspended.',
      );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(subtitle, style: textTheme.bodyMedium),
            const SizedBox(height: 16),
            if (onButtonTapped != null && buttonLabel != null)
              ExtendedElevatedButton(
                onPressed: onButtonTapped,
                icon: const Icon(Icons.storefront_outlined),
                label: buttonLabel!,
              ),
          ],
        ),
      ),
    );
  }
}
