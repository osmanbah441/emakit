import 'package:flutter/material.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({
    super.key,
    required this.balance,
    required this.ownerName,
    this.ownerEmail = '',
    required this.actionSection,
  });

  final double balance;
  final String ownerName;
  final String ownerEmail;
  final Widget actionSection;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    const iconSize = 32.0;

    final balanceSection = Column(
      spacing: 4,
      children: [
        Text('Current Balance', style: textTheme.labelSmall),
        Text(
          '🇸🇱 SLE. ${balance.toStringAsFixed(2)}',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.2, 0.8],
          colors: [
            cs.onPrimaryContainer.withValues(alpha: .4),
            cs.onPrimaryContainer.withValues(alpha: .2),
          ],
        ),
      ),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              balanceSection,
              const Icon(Icons.logo_dev, size: iconSize),
            ],
          ),
          actionSection,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(ownerName, style: textTheme.labelSmall),
              Text(ownerEmail, style: textTheme.labelSmall),
            ],
          ),
        ],
      ),
    );
  }
}
