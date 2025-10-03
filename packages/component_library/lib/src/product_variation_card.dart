import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:component_library/component_library.dart';
import 'package:image_picker/image_picker.dart';

enum ProductVariationMode {
  view,
  edit,
  add;

  bool get _isView => this == ProductVariationMode.view;
  bool get _isEdit => this == ProductVariationMode.edit;
  bool get _isAdd => this == ProductVariationMode.add;
}

class ProductVariationCard extends StatefulWidget {
  const ProductVariationCard({
    super.key,
    this.id,
    this.initialPrice,
    this.initialStock,
    this.optionalFields,
    this.selectedOptions,
    this.isActive = false,
    this.mode = ProductVariationMode.view,
    this.onToggleActive,
    this.onSaveOrAdd,
    this.onCancel,
    this.onEdit,
    this.onDelete,
    this.imagesFromNetwork,
    this.onAdd,
    this.onUpdate,
    this.onAddLabelText = 'Add',
  });

  final String? id;
  final String? initialPrice;
  final String? initialStock;
  final Map<String, List<String>>? optionalFields;
  final Map<String, dynamic>? selectedOptions;
  final bool isActive;
  final List<String>? imagesFromNetwork;
  final ValueChanged<bool>? onToggleActive;
  final VoidCallback? onSaveOrAdd;
  final VoidCallback? onCancel;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final ProductVariationMode mode;
  final String onAddLabelText;
  final void Function({
    required double price,
    required int stock,
    required Map<String, dynamic> selectedAttributesMap,
    required List<({Uint8List bytes, String mimeType})> images,
  })?
  onAdd;
  final void Function({required double price, required int stock})? onUpdate;

  @override
  State<ProductVariationCard> createState() => _ProductVariationCardState();
}

class _ProductVariationCardState extends State<ProductVariationCard> {
  late final TextEditingController _priceController;
  late final TextEditingController _stockController;
  final _formKey = GlobalKey<FormState>();

  final _selectedImages = <({Uint8List bytes, String mimeType})>[];
  final Map<String, String?> _selectedVariationAttributes = {};

  static const int _maxImages = 6;
  static const int _minImages = 4;

  @override
  void initState() {
    super.initState();
    _priceController = TextEditingController(text: widget.initialPrice);
    _stockController = TextEditingController(text: widget.initialStock);
  }

  @override
  void dispose() {
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  void _onUpdate() {
    if (_formKey.currentState!.validate()) {
      widget.onUpdate!(
        price: double.tryParse(_priceController.text) ?? 0,
        stock: int.tryParse(_stockController.text) ?? 0,
      );
    }
  }

  void _onAdd() {
    if (_formKey.currentState!.validate()) {
      widget.onAdd!(
        images: _selectedImages,
        price: double.tryParse(_priceController.text) ?? 0,
        stock: int.tryParse(_stockController.text) ?? 0,
        selectedAttributesMap: _selectedVariationAttributes,
      );
    }
  }

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    for (final file in pickedFiles) {
      final bytes = await file.readAsBytes();
      setState(() {
        _selectedImages.add((bytes: bytes, mimeType: file.mimeType!));
      });
    }
  }

  void _onImageRemoved(({Uint8List bytes, String mimeType}) image) =>
      setState(() => _selectedImages.remove(image));

  Widget _buildDropdownField(String fieldName, List<String> options) {
    return DropdownButtonFormField<String>(
      value: _selectedVariationAttributes[fieldName],
      items: options
          .map((opt) => DropdownMenuItem<String>(value: opt, child: Text(opt)))
          .toList(),
      decoration: InputDecoration(labelText: fieldName),
      validator: (val) =>
          val == null || val.isEmpty ? 'Please select $fieldName' : null,
      onChanged: (val) {
        setState(() {
          _selectedVariationAttributes[fieldName] = val;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget? stockPrefixIcon() {
      final stockValue = int.tryParse(_priceController.text) ?? 0;
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

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Switch(
                    value: widget.isActive,
                    onChanged: widget.onToggleActive,
                    inactiveThumbColor: widget.isActive ? Colors.green : null,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.id != null
                          ? "ID: ${widget.id!.substring(0, 8)}..."
                          : "Add Product Variation",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const Spacer(),
                  if (widget.mode._isView) ...[
                    IconButton(
                      onPressed: widget.onEdit,
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: widget.onDelete,
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _priceController,
                      enabled: !widget.mode._isView,
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
                        if (v == null || v.isEmpty) return 'Required';
                        if (double.tryParse(v) == null) return 'Invalid';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _stockController,
                      enabled: !widget.mode._isView,
                      decoration: InputDecoration(
                        labelText: 'Stock',
                        prefixIcon: stockPrefixIcon(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        if (int.tryParse(v) == null) return 'Must be integer';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (widget.mode._isAdd && widget.optionalFields != null) ...[
                ...widget.optionalFields!.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildDropdownField(entry.key, entry.value),
                  );
                }),
              ] else ...[
                if (widget.selectedOptions != null)
                  ...widget.selectedOptions!.entries.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: TextFormField(
                        initialValue: e.value,
                        enabled: false,
                        decoration: InputDecoration(labelText: e.key),
                      ),
                    );
                  }),
              ],

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: (widget.mode._isAdd)
                    ? [
                        ..._selectedImages.map(
                          (image) => DisplayMemoryImage(
                            width: 64,
                            height: 64,
                            imageBytes: image.bytes,
                            onRemove: () => _onImageRemoved(image),
                          ),
                        ),
                        if (_selectedImages.length < _maxImages)
                          ImagePlaceholder(
                            onTap: _pickImages,
                            height: 64,
                            width: 64,
                            borderRadius: BorderRadius.circular(8),
                          ),
                      ]
                    : widget.imagesFromNetwork != null
                    ? widget.imagesFromNetwork!.map((e) {
                        return AppNetworkImage(
                          imageUrl: e,
                          height: 64,
                          width: 64,
                          borderRadius: BorderRadius.circular(8),
                        );
                      }).toList()
                    : [],
              ),
              if (widget.mode._isEdit || widget.mode._isAdd)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (widget.onCancel != null) ...[
                        TextButton(
                          onPressed: widget.onCancel,
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: 12),
                      ],
                      ElevatedButton(
                        onPressed: widget.mode._isEdit ? _onUpdate : _onAdd,
                        child: Text(
                          widget.mode._isEdit
                              ? 'update'
                              : widget.onAddLabelText,
                        ),
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
