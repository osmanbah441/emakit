import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImagePickerComponent extends StatelessWidget {
  final VoidCallback onImageSelected;
  final Uint8List? initialImage;
  final double aspectRatio;
  final String hintText;

  const ImagePickerComponent({
    super.key,
    required this.onImageSelected,
    this.initialImage,
    this.hintText = 'Tap to add image',
    this.aspectRatio = 16 / 11,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasImage = initialImage != null;
    final hint = hasImage ? 'Tap to change image' : hintText;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onImageSelected,
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (hasImage) Image.memory(initialImage!, fit: BoxFit.contain),
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 200,
                  maxHeight: 120,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black.withValues(alpha: .4),
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.cloud_upload_rounded,
                        color: Colors.white,
                        size: 32,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        hint,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
