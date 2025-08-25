import 'package:flutter/material.dart';

class CustomDressSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const CustomDressSection({
    super.key,
    this.title = "Have a design in mind?",
    this.subtitle =
        "Our expert tailors can bring your vision to life. Share your ideas with us.",
    required this.onTap,
  });

  static const double _imageBorderRadius = 24.0;
  static const double _imageHeight = 480.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return InkWell(
      borderRadius: BorderRadius.circular(_imageBorderRadius),
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_imageBorderRadius),
        child: Stack(
          children: [
            // Background image
            Image.asset(
              'assets/images/custom_design.png',
              package: 'component_library',
              fit: BoxFit.cover,
              width: double.infinity,
              height: _imageHeight,
              errorBuilder: (context, error, stackTrace) => Container(
                height: _imageHeight,
                color: theme.colorScheme.surface,
                child: Icon(Icons.error, color: theme.colorScheme.error),
              ),
            ),

            // Text block with overlay (bottom aligned)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: .45),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      subtitle,
                      style: textTheme.bodyLarge?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
