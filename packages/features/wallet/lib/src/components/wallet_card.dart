import 'package:flutter/material.dart';
import 'package:wallet/src/models/models.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({
    super.key,
    this.balance,
    required this.actionSection,
    this.isFetchBalance = false,
  });

  final Balance? balance;

  final bool isFetchBalance;
  final Widget actionSection;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    const iconSize = 32.0;

    final balanceSection = Column(
      children: [
        Text('Current Balance', style: textTheme.labelSmall),
        if (balance != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(balance!.currency),
              const SizedBox(width: 8),
              Text(
                balance!.amount.toStringAsFixed(2),
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        else
          Text('Failed check internet connection'),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isFetchBalance)
                const CircularProgressIndicator()
              else
                balanceSection,
              const Icon(Icons.logo_dev, size: iconSize),
            ],
          ),
          actionSection,
        ],
      ),
    );
  }
}
