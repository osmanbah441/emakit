import 'package:flutter/material.dart';

class ResponsiveImageUploadCard extends StatelessWidget {
  /// The main title of the card.
  final String title;

  /// The descriptive subtitle text.
  final String description;

  /// The icon to display in the center.
  final IconData icon;

  /// The callback function executed when the user taps the card.
  final VoidCallback onTap;

  const ResponsiveImageUploadCard({
    super.key,
    // Sensible defaults for the product listing screen
    this.title = 'List Your Product',
    this.description =
        'Upload a photo to see if your product is already in our catalog.',
    this.icon = Icons.camera_alt_outlined,
    required this.onTap, // Must be provided now, as it's the primary action
  });

  @override
  Widget build(BuildContext context) {
    // Defines the maximum width for responsiveness on large screens.
    const double maxWidth = 400.0;

    // Use GestureDetector to make the entire card tappable
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: maxWidth),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Card(
            elevation: 2,
            color: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(12.0),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // 1. Icon
                    Icon(icon, size: 64, color: Colors.grey.shade600),

                    const SizedBox(height: 16),

                    // 2. Title Text
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // 3. Subtitle Text
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
