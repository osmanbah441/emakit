import 'package:flutter/material.dart';
import 'package:seller_onboarding/src/benefit.dart';
import 'package:seller_onboarding/src/benefit_card.dart';
import 'package:seller_onboarding/src/business_contact_form.dart';

class BecomeSellerScreen extends StatelessWidget {
  const BecomeSellerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/become_a_seller.png',
              package: 'component_library',
              fit: BoxFit.fill,
              width: double.infinity,
              height: 400,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Start Selling with Confidence',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Join Salone Bazaar and grow your business the smart way. '
                    'Fill in your business name and phone number to get started — our team will reach out to learn about your goals, help you set up your shop, and make sure you’re ready to succeed. '
                    'Together, we keep our marketplace safe, trusted, and ready to help local businesses thrive.',
                    style: theme.textTheme.bodyLarge,
                  ),

                  const SizedBox(height: 32),
                  const BusinessContactForm(),
                  const SizedBox(height: 48),
                  Text('Why Join Us?', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 18,
                    runSpacing: 18,
                    children: Benefit.all().map((benefit) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width > 600
                            ? (MediaQuery.of(context).size.width - 72) / 2
                            : double.infinity,
                        child: BenefitCard(benefit: benefit),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
