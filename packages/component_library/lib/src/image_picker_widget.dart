import 'dart:typed_data';

import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef PickedImageData = ({String mimeType, Uint8List bytes});

class SingleImagePickerWidget extends StatelessWidget {
  const SingleImagePickerWidget({
    super.key,
    this.initialImage,
    required this.onImagePicked,
    this.onImageRemoved,
    this.width = 300,
    this.height = 300,
    this.imageUrl,
    this.borderRadius = BorderRadius.zero,
  });

  final PickedImageData? initialImage;
  final ValueChanged<PickedImageData> onImagePicked;
  final VoidCallback? onImageRemoved;
  final double width;
  final double height;
  final String? imageUrl;
  final BorderRadius borderRadius;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final imageData = (
        mimeType: picked.mimeType!,
        bytes: await picked.readAsBytes(),
      );

      onImagePicked(imageData);
    }
  }

  void _removeImage() {
    onImageRemoved?.call();
  }

  @override
  Widget build(BuildContext context) {
    return initialImage == null
        ? ImagePlaceholder(
            width: width,
            height: height,
            onTap: _pickImage,
            imageUrl: imageUrl,
            borderRadius: borderRadius,
          )
        : DisplayMemoryImage(
            imageBytes: initialImage!.bytes,
            onRemove: _removeImage,
            width: width,
            height: height,
            borderRadius: borderRadius,
          );
  }
}

class MultipleImagesPickerWidget extends StatefulWidget {
  const MultipleImagesPickerWidget({
    super.key,
    required this.selectedImages,
    required this.onImagesSelected,
    required this.onImageRemoved,
    this.maxImages = 5,
    this.minImages = 3,
    this.pickerTitle =
        "Upload 3-5 photos of the same item, from different angles.",
  });

  final List<({Uint8List bytes, String mimeType})> selectedImages;
  final ValueChanged<List<({Uint8List bytes, String mimeType})>>
  onImagesSelected;
  final ValueChanged<({Uint8List bytes, String mimeType})> onImageRemoved;
  final int maxImages;
  final int minImages;
  final String pickerTitle;

  @override
  State<MultipleImagesPickerWidget> createState() =>
      _MultipleImagesPickerWidgetState();
}

class _MultipleImagesPickerWidgetState
    extends State<MultipleImagesPickerWidget> {
  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    final newImages = <({Uint8List bytes, String mimeType})>[];
    for (final file in pickedFiles) {
      final bytes = await file.readAsBytes();
      newImages.add((bytes: bytes, mimeType: file.mimeType!));
    }
    widget.onImagesSelected(newImages);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.pickerTitle, style: theme.textTheme.bodyMedium),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8.0,
          runSpacing: 16.0,
          children: [
            ...widget.selectedImages.map(
              (image) => DisplayMemoryImage(
                width: 120,
                height: 120,
                imageBytes: image.bytes,
                onRemove: () => widget.onImageRemoved(image),
              ),
            ),
            if (widget.selectedImages.length < widget.maxImages)
              ImagePlaceholder(onTap: _pickImages, height: 120, width: 120),
          ],
        ),
      ],
    );
  }
}
