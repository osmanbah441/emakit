import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageThumbnail extends StatelessWidget {
  final XFile imageFile;
  final VoidCallback onRemove;

  const ImageThumbnail({
    super.key,
    required this.imageFile,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: // kisWeb ?
          Image.network(
            // Use Image.network for web
            imageFile.path,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.red.shade100,
              child: const Center(
                child: Icon(Icons.broken_image, color: Colors.red),
              ),
            ),
          ),
          // : Image.file(
          //     // Use Image.file for non-web platforms
          //     File(imageFile.path),
          //     fit: BoxFit.cover,
          //     width: double.infinity,
          //     height: double.infinity,
          //     errorBuilder: (context, error, stackTrace) => Container(
          //       color: Colors.red.shade100,
          //       child: const Center(
          //         child: Icon(Icons.broken_image, color: Colors.red),
          //       ),
          //     ),
          //   ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 18),
            ),
          ),
        ),
      ],
    );
  }
}
