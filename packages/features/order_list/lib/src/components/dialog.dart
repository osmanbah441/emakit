import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class ProductActionCard extends StatelessWidget {
  final String imageUrl;
  final String message;
  final String itemName;
  final String confirmLabel;
  final Color backgroundConfirmColor;
  final Color foregroundConfirmColor;
  final VoidCallback onConfirm;

  const ProductActionCard({
    super.key,
    required this.imageUrl,
    required this.message,
    required this.itemName,
    required this.confirmLabel,
    required this.backgroundConfirmColor,
    required this.onConfirm,
    required this.foregroundConfirmColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final baseStyle = textTheme.titleMedium?.copyWith(
      height: 1.6,
      fontSize: 17,
    );
    final boldStyle = baseStyle?.copyWith(fontWeight: FontWeight.w700);

    final parts = message.split(itemName);

    return Dialog(
      backgroundColor: theme.colorScheme.surface,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.35,
              child: AppNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: baseStyle,
                  children: [
                    if (parts.isNotEmpty) TextSpan(text: parts[0]),
                    TextSpan(text: itemName, style: boldStyle),
                    if (parts.length > 1) TextSpan(text: parts[1]),
                  ],
                ),
              ),
            ),

            // Actions
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: backgroundConfirmColor,
                      foregroundColor: foregroundConfirmColor,
                      textStyle: textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      onConfirm();
                    },
                    child: Text(confirmLabel),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Confirm Receipt Dialog
// ---------------------------------------------------------------------------
class ConfirmReceiptDialog {
  static Future<void> show({
    required BuildContext context,
    required String itemName,
    required String imageUrl,
    required VoidCallback onConfirm,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return showDialog(
      context: context,
      builder: (_) => ProductActionCard(
        imageUrl: imageUrl,
        message:
            'You’re about to confirm receipt of $itemName and release the held funds to the seller. This action cannot be undone.',
        itemName: itemName,
        confirmLabel: 'Release Funds',
        backgroundConfirmColor: colorScheme.primary,
        foregroundConfirmColor: colorScheme.onPrimary,
        onConfirm: onConfirm,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Cancel Order Dialog
// ---------------------------------------------------------------------------
class CancelOrderDialog {
  static Future<void> show({
    required BuildContext context,
    required String itemName,
    required String imageUrl,
    required VoidCallback onConfirm,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return showDialog(
      context: context,
      builder: (_) => ProductActionCard(
        imageUrl: imageUrl,
        message:
            'You’re about to cancel your order for $itemName. The payment will be returned to your balance.',
        itemName: itemName,
        confirmLabel: 'Cancel Order',
        backgroundConfirmColor: colorScheme.error,
        foregroundConfirmColor: colorScheme.onError,
        onConfirm: onConfirm,
      ),
    );
  }
}
