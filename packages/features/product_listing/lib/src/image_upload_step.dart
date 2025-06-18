import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:component_library/component_library.dart';

class ImageUploadStep extends StatefulWidget {
  const ImageUploadStep({super.key});

  @override
  State<ImageUploadStep> createState() => _ImageUploadStepState();
}

class _ImageUploadStepState extends State<ImageUploadStep> {
  final List<XFile> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();
  final int _maxImages = 2;
  final int _minImages = 2;
  bool get canAddImages => _selectedImages.length < _maxImages;

  void _uploadImages() async {
    final List<InlineDataPart> images = [];

    for (final image in _selectedImages) {
      if (image.mimeType == null) throw 'mime type null';
      images.add(InlineDataPart(image.mimeType!, await image.readAsBytes()));
    }

    final ai = FirebaseAI.googleAI().generativeModel(
      model: 'gemini-2.0-flash',
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: Schema.object(
          properties: {
            'name': Schema.string(),
            'description': Schema.string(),
            'category': Schema.string(),
            'price': Schema.number(),
          },
        ),
      ),
    );

    final response = await ai.generateContent([
      Content.multi(images),
      Content.text('Tell me what the images are about'),
    ]);

    print(response.text);
  }

  // Function to pick an image using image_picker
  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          _selectedImages.add(image);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: ${e.toString()}')),
      );
    }
  }

  // Function to remove an image
  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'For the best product listing, please upload 2 high-quality images showing different angles (front, back, and sides) of your item. This helps us understand it thoroughly!',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16.0),

          if (_selectedImages.isEmpty)
            EmptyImagePlaceholder(onUpload: _pickImage)
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 1.0,
              ),
              itemCount: _selectedImages.length + (canAddImages ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < _selectedImages.length) {
                  final image = _selectedImages[index];
                  return ImageThumbnail(
                    imageFile: image,
                    onRemove: () => _removeImage(index),
                  );
                } else {
                  return EmptyImagePlaceholder(onUpload: _pickImage);
                }
              },
            ),

          if (_selectedImages.isNotEmpty) const SizedBox(height: 16.0),
          PrimaryActionButton(
            onPressed: (_selectedImages.length < _minImages)
                ? null
                : _uploadImages,
            label: 'Upload Images',
          ),
        ],
      ),
    );
  }
}
