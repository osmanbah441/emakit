import 'package:domain_models/domain_models.dart';
import 'package:domain_models/src/attribute_data_type.dart';
import 'package:domain_models/src/link_category_to_atrributes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_add_or_edit/src/product_add_or_edit_cubit.dart';
import 'package:product_add_or_edit/src/product_add_or_edit_state.dart';

/// A dynamic product specification form that renders fields
/// based on category attributes from the Cubit state.
///
/// - Validates only non-variant and required fields.
/// - Emits a `Map<String, dynamic>` via [onChanged].
/// - Controlled externally using a [GlobalKey<FormState>].
class DynamicSpecForm extends StatefulWidget {
  const DynamicSpecForm({
    super.key,
    required this.formKey,
    required this.onChanged,
  });

  /// External form key for validation
  final GlobalKey<FormState> formKey;

  /// Callback when form values change
  final ValueChanged<Map<String, dynamic>?> onChanged;

  @override
  State<DynamicSpecForm> createState() => _DynamicSpecFormState();
}

class _DynamicSpecFormState extends State<DynamicSpecForm> {
  final Map<String, dynamic> _values = {};
  final Map<String, TextEditingController> _controllers = {};
  List<LinkCategoryToAtrributes> _attributes = [];
  String? _lastCategoryId;

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  /// Initializes controllers and default values once per category.
  void _initializeForm({
    required String categoryId,
    required List<LinkCategoryToAtrributes> attributes,
    required Map<String, dynamic> initialValues,
  }) {
    if (_lastCategoryId == categoryId) return; // avoid reinit for same category
    _lastCategoryId = categoryId;
    _attributes = attributes;

    _controllers.clear();
    for (final link in attributes) {
      final id = link.attributeId;
      final initValue = initialValues[link.attributeName];

      _values[id] = initValue;
      if (link.dataType != AttributeDataType.dropdown) {
        _controllers[id] = TextEditingController(
          text: initValue?.toString() ?? '',
        );
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => _notifyParent());
  }

  /// Notifies parent with only valid, non-empty specs.
  void _notifyParent() {
    final result = <String, dynamic>{};
    for (final link in _attributes) {
      final value = _values[link.attributeId];
      if (value != null && (value is String ? value.trim().isNotEmpty : true)) {
        result[link.attributeName] = value;
      }
    }
    widget.onChanged(result.isEmpty ? null : result);
  }

  /// Validation logic for each attribute field.
  String? _validateField(LinkCategoryToAtrributes link, String? value) {
    if (link.isVariant) return null; // skip variant validation
    if (link.isRequired && (value == null || value.trim().isEmpty)) {
      return '${link.attributeName} is required';
    }
    if (link.dataType == AttributeDataType.number &&
        value != null &&
        value.isNotEmpty &&
        double.tryParse(value) == null) {
      return 'Must be a number';
    }
    return null;
  }

  /// Builds a dropdown field for enum-like attributes.
  Widget _buildDropdownField(LinkCategoryToAtrributes link) {
    final id = link.attributeId;
    final current = _values[id];

    return DropdownButtonFormField<String>(
      initialValue: (current is String && link.options.contains(current))
          ? current
          : null,
      decoration: InputDecoration(
        labelText: link.attributeName,
        border: const OutlineInputBorder(),
      ),
      items: link.options
          .map((opt) => DropdownMenuItem(value: opt, child: Text(opt)))
          .toList(),
      onChanged: (value) {
        setState(() {
          _values[id] = value;
          _notifyParent();
        });
      },
      validator: (v) => _validateField(link, v),
    );
  }

  /// Builds a text/number input field.
  Widget _buildTextField(LinkCategoryToAtrributes link) {
    final id = link.attributeId;
    final controller = _controllers[id]!;

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: link.attributeName,
        border: const OutlineInputBorder(),
      ),
      keyboardType: link.dataType == AttributeDataType.number
          ? TextInputType.number
          : TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (v) {
        _values[id] = link.dataType == AttributeDataType.number
            ? double.tryParse(v) ?? v
            : v;
        _notifyParent();
      },
      validator: (v) => _validateField(link, v),
    );
  }

  /// Decides which field widget to render.
  Widget _buildField(LinkCategoryToAtrributes link) {
    switch (link.dataType) {
      case AttributeDataType.dropdown:
        return _buildDropdownField(link);
      case AttributeDataType.number:
      case AttributeDataType.text:
        return _buildTextField(link);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductAddOrEditCubit, ProductAddOrEditState>(
      buildWhen: (prev, curr) {
        if (curr is! ProductAddOrEditSuccess ||
            prev is! ProductAddOrEditSuccess) {
          return true;
        }
        final categoryChanged =
            prev.selectedCategory?.id != curr.selectedCategory?.id;
        final specsChanged =
            prev.productToEdit?.specifications !=
            curr.productToEdit?.specifications;
        return categoryChanged || specsChanged;
      },
      builder: (context, state) {
        if (state is! ProductAddOrEditSuccess ||
            state.selectedCategory == null) {
          return const SizedBox.shrink();
        }

        final category = state.selectedCategory!;
        final attributes = category.attributes
            .where((a) => !a.isVariant)
            .toList();
        final initialValues = state.productToEdit?.specifications ?? {};

        _initializeForm(
          categoryId: category.id!,
          attributes: attributes,
          initialValues: initialValues,
        );

        if (attributes.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: Text(
                'No custom specifications defined for this category.',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ),
          );
        }

        return Form(
          key: widget.formKey, // ✅ external key controls validation
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: attributes
                .map(
                  (attr) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildField(attr),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
