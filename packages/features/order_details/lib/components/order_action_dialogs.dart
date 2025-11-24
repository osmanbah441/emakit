import 'package:flutter/material.dart';

Future<bool?> showCancelItemDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) => const _ConfirmActionDialog(
      title: 'Cancel Item',
      content:
          'Are you sure you want to cancel this item? This action cannot be undone.',
      confirmText: 'Cancel Item',
      confirmColor: Colors.red,
    ),
  );
}

Future<bool?> showConfirmItemDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) => const _ConfirmActionDialog(
      title: 'Confirm Item',
      content: 'Have you received your item and wish to release the funds?',
      confirmText: 'Confirm Receipt',
      confirmColor: Colors.green,
    ),
  );
}

class _ConfirmActionDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final Color confirmColor;

  const _ConfirmActionDialog({
    required this.title,
    required this.content,
    required this.confirmText,
    required this.confirmColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: confirmColor),
          onPressed: () => Navigator.pop(context, true),
          child: Text(confirmText),
        ),
      ],
    );
  }
}
