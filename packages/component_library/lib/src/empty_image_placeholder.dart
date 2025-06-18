import 'package:flutter/material.dart';

import 'dotted_border_box.dart';

class EmptyImagePlaceholder extends StatelessWidget {
  const EmptyImagePlaceholder({super.key, required this.onUpload});

  final VoidCallback onUpload;

  @override
  Widget build(BuildContext context) {
    return DottedBorderBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Add photos', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 24.0),
          ElevatedButton.icon(
            onPressed: onUpload,
            icon: const Icon(Icons.upload_file),
            label: const Text('Upload'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade100,
              foregroundColor: Colors.blue.shade900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
