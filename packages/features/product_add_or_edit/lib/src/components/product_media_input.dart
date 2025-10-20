import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class ProductMediaInput extends StatefulWidget {
  const ProductMediaInput({
    super.key,
    required this.onMediaAdded,
    required this.onMediaRemoved,
  });

  final Function(ProductMedia media) onMediaAdded;
  final Function(ProductMedia media) onMediaRemoved;

  @override
  State<ProductMediaInput> createState() => _ProductMediaInputState();
}

class _ProductMediaInputState extends State<ProductMediaInput> {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _altTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final List<ProductMedia> _tempMediaList = [];

  void _addMedia() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final newMedia = ProductMedia(
      url: _urlController.text.trim(),
      altText: _altTextController.text.trim().isEmpty
          ? null
          : _altTextController.text.trim(),
    );

    setState(() {
      _tempMediaList.add(newMedia);
      widget.onMediaAdded(newMedia);

      _urlController.clear();
      _altTextController.clear();
    });
  }

  void _removeMedia(ProductMedia media) {
    setState(() {
      _tempMediaList.remove(media);
      widget.onMediaRemoved(media);
    });
  }

  @override
  void dispose() {
    _urlController.dispose();
    _altTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Media Gallery',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            Form(
              key: _formKey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      controller: _urlController,
                      decoration: const InputDecoration(
                        labelText: 'Image URL',
                        hintText: 'e.g., https://example.com/image.jpg',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Image URL is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: _altTextController,
                      decoration: const InputDecoration(
                        labelText: 'Alt Text (Optional)',
                        hintText: 'Description for accessibility',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ElevatedButton.icon(
                      onPressed: _addMedia,
                      icon: const Icon(Icons.add_photo_alternate),
                      label: const Text('Add Image Link'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 19,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            if (_tempMediaList.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text(
                    'No media links added yet. Use the form above to add an image URL.',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.2,
                ),
                itemCount: _tempMediaList.length,
                itemBuilder: (context, index) {
                  final media = _tempMediaList[index];
                  return Card(
                    elevation: 2,
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          media.url,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.broken_image,
                                  color: Colors.red,
                                  size: 48,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'URL Error',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Colors.black54,
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 10.0,
                            ),
                            child: Text(
                              media.altText ?? 'No Alt Text',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: CircleAvatar(
                            backgroundColor: Colors.red.withOpacity(0.8),
                            radius: 18,
                            child: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 18,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () => _removeMedia(media),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
