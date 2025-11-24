import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class AddVariationAndOfferScreen extends StatefulWidget {
  const AddVariationAndOfferScreen({super.key});

  @override
  State<AddVariationAndOfferScreen> createState() =>
      _AddVariationAndOfferScreenState();
}

class _AddVariationAndOfferScreenState
    extends State<AddVariationAndOfferScreen> {
  // SegmentedButton index: 0 => Choose Existing, 1 => Create New
  int _selectedSegment = 1;

  final Map<String, List<String>> _availableAttributes = {
    'Color': ['Red', 'Blue', 'Green', 'Black', 'White'],
    'Size': ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
  };

  final Map<String, String?> _selectedAttributes = {};
  List<String> _variationImageUrls = [
    'https://picsum.photos/seed/variationimg1/200/200',
    'https://picsum.photos/seed/variationimg2/200/200',
  ];

  final TextEditingController _priceController = TextEditingController(
    text: '19.99',
  );
  final TextEditingController _stockController = TextEditingController(
    text: '10',
  );

  @override
  void initState() {
    super.initState();
    for (final k in _availableAttributes.keys) {
      _selectedAttributes[k] = null;
    }
  }

  @override
  void dispose() {
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  void _onSegmentChanged(int value) {
    setState(() => _selectedSegment = value);
  }

  void _onAttributeChanged(String name, String? value) {
    setState(() => _selectedAttributes[name] = value);
  }

  void _onAddImage() {
    setState(() {
      _variationImageUrls.add(
        'https://picsum.photos/seed/${DateTime.now().microsecondsSinceEpoch}/200/200',
      );
    });
  }

  void _onRemoveImage(int index) {
    setState(() => _variationImageUrls.removeAt(index));
  }

  void _onAddVariation() {
    // Hook: validate and save
    debugPrint('Add Variation tapped');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCreateNew = _selectedSegment == 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Variation & Offers',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: BackButton(color: theme.appBarTheme.iconTheme?.color),
        actions: [
          TextButton(
            onPressed: () => debugPrint('Save pressed'),
            child: Text(
              'Save',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
        // Let AppBar theme govern background/elevation
      ),
      backgroundColor: theme.colorScheme.surfaceVariant.withOpacity(0.04),
      body: SafeArea(
        minimum: EdgeInsets.zero,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ), // minimal app-level padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SegmentedButton<int>(
                  segments: const <ButtonSegment<int>>[
                    ButtonSegment<int>(
                      value: 0,
                      label: Text('Choose Existing'),
                    ),
                    ButtonSegment<int>(value: 1, label: Text('Create New')),
                  ],
                  showSelectedIcon: false,
                  selected: <int>{_selectedSegment},
                  onSelectionChanged: (newSelection) {
                    if (newSelection.isNotEmpty) {
                      _onSegmentChanged(newSelection.first);
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),
              if (isCreateNew) ...[
                VariationAttributesCard(
                  attributes: _availableAttributes,
                  selectedAttributes: _selectedAttributes,
                  onChanged: _onAttributeChanged,
                ),
                VariationImagesPicker(
                  imageUrls: _variationImageUrls,
                  onAddImage: _onAddImage,
                  onRemoveImage: _onRemoveImage,
                ),
                VariationOfferCard(
                  priceController: _priceController,
                  stockController: _stockController,
                ),
              ] else
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: Text(
                      'Coming up next...',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PrimaryActionButton(
          label: 'Add Variation',
          onPressed: _onAddVariation,
        ),
      ),
    );
  }
}

/// -----------------------------
/// VariationAttributesCard
/// -----------------------------
class VariationAttributesCard extends StatelessWidget {
  final Map<String, List<String>> attributes;
  final Map<String, String?> selectedAttributes;
  final void Function(String attributeName, String? value) onChanged;

  const VariationAttributesCard({
    super.key,
    required this.attributes,
    required this.selectedAttributes,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      // Card appearance is driven by CardTheme from the app theme
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Attributes',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...attributes.entries.map((entry) {
              final attributeName = entry.key;
              final options = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: attributeName,
                    hintText: 'Choose $attributeName',
                  ),
                  isExpanded: true,
                  value: selectedAttributes[attributeName],
                  items: options
                      .map(
                        (opt) => DropdownMenuItem<String>(
                          value: opt,
                          child: Text(opt),
                        ),
                      )
                      .toList(),
                  onChanged: (val) => onChanged(attributeName, val),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

/// -----------------------------
/// VariationImagesCard
/// -----------------------------
class VariationImagesPicker extends StatelessWidget {
  final List<String> imageUrls;
  final VoidCallback onAddImage;
  final ValueChanged<int> onRemoveImage;

  const VariationImagesPicker({
    super.key,
    required this.imageUrls,
    required this.onAddImage,
    required this.onRemoveImage,
  });

  static const double _tileSize = 96.0; // reasonable, minimal explicit size

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tileRadius = BorderRadius.circular(8);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Variation Images',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Add up to 8 images for this variation.',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: _tileSize,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: imageUrls.length + 1,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return GestureDetector(
                      onTap: onAddImage,
                      child: Container(
                        width: _tileSize,
                        height: _tileSize,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceVariant,
                          borderRadius: tileRadius,
                          border: Border.all(color: theme.dividerColor),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add_a_photo_outlined,
                                size: 24,
                                color: theme.iconTheme.color,
                              ),
                              const SizedBox(height: 6),
                              Text('Add', style: theme.textTheme.bodySmall),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  final imgUrl = imageUrls[index - 1];
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: tileRadius,
                        child: Container(
                          width: _tileSize,
                          height: _tileSize,
                          color: theme.colorScheme.surface,
                          child: Image.network(
                            imgUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Icon(
                              Icons.broken_image,
                              size: 28,
                              color: theme.iconTheme.color,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 6,
                        right: 6,
                        child: InkWell(
                          onTap: () => onRemoveImage(index - 1),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.onSurface.withOpacity(
                                0.6,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              size: 14,
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// -----------------------------
/// VariationOfferCard
/// -----------------------------
class VariationOfferCard extends StatelessWidget {
  final TextEditingController priceController;
  final TextEditingController stockController;

  const VariationOfferCard({
    super.key,
    required this.priceController,
    required this.stockController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Offer Details',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: priceController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Price*',
                hintText: 'e.g. \$19.99',
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: stockController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Stock Quantity*',
                hintText: 'e.g. 10',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
