import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'product_listing_cubit.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  final ImagePicker _picker = ImagePicker();
  final List<({String mimeType, Uint8List bytes})> _images = [];

  Future<void> _pickImage() async {
    if (_images.length >= 5) return;

    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() => _images.add((mimeType: picked.mimeType!, bytes: bytes)));
    }
  }

  void _onContinue() {
    context.read<ProductCubit>().uploadImages(_images);
    context.read<ProductCubit>().nextStep();
  }

  void _removeImage(int index) {
    setState(() => _images.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    final isContinueEnabled = _images.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            "Upload Product Images",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(_images.length, (index) {
              return Stack(
                children: [
                  Image.memory(
                    _images[index].bytes,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        size: 18,
                        color: Colors.red,
                      ),
                      onPressed: () => _removeImage(index),
                    ),
                  ),
                ],
              );
            }),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _images.length >= 5 ? null : _pickImage,
            icon: const Icon(Icons.photo),
            label: Text("Pick Image (${_images.length}/5)"),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: isContinueEnabled ? _onContinue : null,
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }
}
