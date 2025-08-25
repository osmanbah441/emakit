import 'package:flutter/material.dart';

class MeasurementGuideDialog extends StatelessWidget {
  const MeasurementGuideDialog({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(24);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      title: Text(title),
      content: ClipRRect(
        borderRadius: borderRadius,
        child: Image.asset(
          imageUrl,
          fit: BoxFit.contain,
          package: 'component_library',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Dismiss'),
        ),
      ],
    );
  }
}
