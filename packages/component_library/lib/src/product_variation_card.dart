import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum VariationCardMode {
  viewing,
  editing,
  adding;

  bool get isViewing => this == VariationCardMode.viewing;
  bool get isEditing => this == VariationCardMode.editing;
  bool get isAdding => this == VariationCardMode.adding;
}

class ProductVariationCard extends StatelessWidget {
  const ProductVariationCard({
    super.key,
    this.id,
    required this.priceController,
    required this.stockController,
    required this.optionalFields,
    required this.selectedOptions,
    required this.images,
    required this.isActive,
    required this.cardMode,
    required this.onToggleActive,
    required this.onEdit,
    required this.onDelete,
    required this.onAdd,
    required this.onUpdate,
    required this.onCancel,
    required this.onOptionChanged,
    required this.onImageAdd,
    required this.onImageRemove,
    required this.formKey,
    required this.canSave,
  });

  final String? id;
  final TextEditingController priceController;
  final TextEditingController stockController;
  final Map<String, List<String>> optionalFields;
  final Map<String, String> selectedOptions;
  final List<String> images;
  final bool isActive;
  final VariationCardMode cardMode;
  final GlobalKey<FormState> formKey;
  final bool canSave;

  // Callbacks for UI interactions, handled by the parent
  final ValueChanged<bool> onToggleActive;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onCancel;
  final void Function({
    required String price,
    required String stock,
    required List<String> images,
    required bool isActive,
    required Map<String, String> selectedOptions,
  })
  onAdd;
  final void Function({
    required String price,
    required String stock,
    required bool isActive,
  })
  onUpdate;

  final Function(String key, String value) onOptionChanged;
  final VoidCallback onImageAdd;
  final Function(int index) onImageRemove;

  @override
  Widget build(BuildContext context) {
    final bool isEditable = cardMode.isEditing || cardMode.isAdding;

    // Constants moved here for direct use in build method
    const activeColor = Colors.green;
    const inactiveColor = Colors.red;

    Widget? stockPrefixIcon() {
      final stockValue = int.tryParse(stockController.text) ?? 0;
      if (stockValue == 0) {
        return const Tooltip(
          message: 'Out of Stock',
          child: Icon(Icons.error, color: Colors.red),
        );
      } else if (stockValue < 10) {
        return const Tooltip(
          message: 'Low Stock',
          child: Icon(Icons.warning_amber, color: Colors.amber),
        );
      }
      return null;
    }

    Widget buildImageTile(int index, String url) {
      return Stack(
        alignment: Alignment.topRight,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              url,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 60,
                height: 60,
                color: Colors.grey[200],
                child: const Icon(Icons.broken_image, size: 30),
              ),
            ),
          ),
          if (isEditable)
            Positioned(
              child: GestureDetector(
                onTap: () => onImageRemove(index),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black54,
                    border: Border.all(color: Colors.white),
                  ),
                  child: const Icon(Icons.close, size: 16, color: Colors.white),
                ),
              ),
            ),
        ],
      );
    }

    final variationCardHeader = Row(
      children: [
        Tooltip(
          message: isActive ? 'Active' : 'Inactive',
          child: Switch(
            value: isActive,
            onChanged: cardMode.isEditing || cardMode.isAdding
                ? onToggleActive
                : null,
            activeColor: activeColor,
            inactiveTrackColor: inactiveColor.withAlpha(128),
            thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
              (states) => states.contains(WidgetState.disabled)
                  ? Icon(
                      isActive ? Icons.check_circle : Icons.cancel,
                      color: isActive ? activeColor : inactiveColor,
                    )
                  : null,
            ),
            trackColor: WidgetStateProperty.resolveWith<Color?>(
              (states) => states.contains(WidgetState.disabled)
                  ? (isActive
                        ? activeColor.withAlpha(128)
                        : inactiveColor.withAlpha(128))
                  : null,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Tooltip(
          message: 'Copy ID',
          child: InkWell(
            onTap: () {
              Clipboard.setData(ClipboardData(text: id ?? ''));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('ID copied to clipboard')),
              );
            },
            child: Text(
              'ID: ${(id ?? 'New Variation').length > 8 ? '${(id ?? 'New Variation').substring(0, 8)}...' : (id ?? 'New Variation')}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        const Spacer(),
        if (cardMode.isViewing) ...[
          IconButton(
            tooltip: 'Edit Item',
            onPressed: onEdit,
            icon: const Icon(Icons.edit_document),
            color: Colors.lightBlue,
          ),
          IconButton(
            tooltip: 'Delete Item',
            onPressed: onDelete,
            icon: const Icon(Icons.delete),
            color: inactiveColor,
          ),
        ],
      ],
    );

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              variationCardHeader,
              const SizedBox(height: 12),

              // --- Variation Card Details (Price, Stock, Optional Fields) ---
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: priceController,
                          enabled: !cardMode.isViewing,
                          decoration: const InputDecoration(labelText: 'Price'),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d{0,2}'),
                            ),
                          ],
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Price is required';
                            }
                            if (double.tryParse(v) == null) {
                              return 'Invalid decimal number';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: stockController,
                          enabled: !cardMode.isViewing,
                          decoration: InputDecoration(
                            labelText: 'Stock',
                            prefixIcon: stockPrefixIcon(),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Stock is required';
                            }
                            if (int.tryParse(v) == null) {
                              return 'Stock must be an integer';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Column(
                    children: optionalFields.entries
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: DropdownButtonFormField<String>(
                              value: selectedOptions[e.key],
                              decoration: InputDecoration(labelText: e.key),
                              items: e.value
                                  .map(
                                    (v) => DropdownMenuItem(
                                      value: v,
                                      child: Text(v),
                                    ),
                                  )
                                  .toList(),
                              onChanged: cardMode.isAdding || cardMode.isEditing
                                  ? (v) => onOptionChanged(e.key, v!)
                                  : null,
                              validator: (v) => (v == null || v.isEmpty)
                                  ? 'Please select ${e.key}'
                                  : null,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // --- Variation Card Images ---
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ...images.asMap().entries.map(
                    (e) => buildImageTile(e.key, e.value),
                  ),
                  if (isEditable && images.length < 5)
                    GestureDetector(
                      onTap: onImageAdd,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Icon(Icons.add, color: Colors.blue),
                        ),
                      ),
                    ),
                ],
              ),
              if (isEditable && images.length != 5)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Please add exactly 5 images (currently ${images.length}/5).',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),

              // --- Variation Card Actions (Cancel, Save/Add buttons) ---
              if (isEditable)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: onCancel,
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: canSave
                            ? () {
                                if (formKey.currentState?.validate() ??
                                    false && images.length == 5) {
                                  if (cardMode.isEditing) {
                                    onUpdate(
                                      price: priceController.text,
                                      stock: stockController.text,
                                      isActive: isActive,
                                    );
                                  } else if (cardMode.isAdding) {
                                    onAdd(
                                      price: priceController.text,
                                      stock: stockController.text,
                                      images: images,
                                      isActive: isActive,
                                      selectedOptions: selectedOptions,
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Please correct validation errors and ensure 5 images are added.',
                                      ),
                                    ),
                                  );
                                }
                              }
                            : null,
                        child: Text(cardMode.isAdding ? 'Add' : 'Save'),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
