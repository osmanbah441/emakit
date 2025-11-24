import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MultiImagePicker extends StatefulWidget {
  final ValueChanged<List<XFile>> onChanged;
  final int maxImages;

  const MultiImagePicker({
    super.key,
    required this.onChanged,
    this.maxImages = 5,
  });

  @override
  State<MultiImagePicker> createState() => _MultiImagePickerState();
}

class _MultiImagePickerState extends State<MultiImagePicker> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _images = [];
  final List<Uint8List> _bytes = [];

  Future<void> _pickImages() async {
    final picked = await _picker.pickMultiImage();
    if (picked.isEmpty) return;

    final remaining = widget.maxImages - _images.length;
    final selected = picked.take(remaining).toList();

    final loadedBytes = await Future.wait(selected.map((e) => e.readAsBytes()));

    setState(() {
      _images.addAll(selected);
      _bytes.addAll(loadedBytes);
    });

    widget.onChanged(_images);
  }

  void _remove(int index) {
    setState(() {
      _images.removeAt(index);
      _bytes.removeAt(index);
    });
    widget.onChanged(_images);
  }

  @override
  Widget build(BuildContext context) {
    final total = _images.length;
    final canAddMore = total < widget.maxImages;

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        ..._bytes.asMap().entries.map((entry) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.memory(
                  entry.value,
                  width: _getSize(total),
                  height: _getSize(total),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: -4,
                top: -4,
                child: IconButton(
                  onPressed: () => _remove(entry.key),
                  icon: const Icon(Icons.close, size: 24),
                ),
              ),
            ],
          );
        }),
        if (canAddMore)
          GestureDetector(
            onTap: _pickImages,
            child: Container(
              width: _getSize(total),
              height: _getSize(total),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              child: const Icon(Icons.add_a_photo, size: 32),
            ),
          ),
      ],
    );
  }

  double _getSize(int count) {
    if (count >= 4) return 130;
    if (count == 3) return 150;
    if (count == 2) return 170;
    return 200; // 1 image → larger
  }
}
