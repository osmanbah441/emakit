import 'package:add_edit_product/src/add_edit_product_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductAttributesBuilder extends StatefulWidget {
  const ProductAttributesBuilder({
    super.key,
    required this.initialValues,
    required this.onSubmit,
    required this.title,
  });

  final Map<String, dynamic> initialValues;
  final Function(Map<String, dynamic> data) onSubmit;
  final String title;

  @override
  State<ProductAttributesBuilder> createState() =>
      _ProductAttributesBuilderState();
}

class _ProductAttributesBuilderState extends State<ProductAttributesBuilder> {
  final _formKey = GlobalKey<FormState>();
  final _textControllers = <String, TextEditingController>{};
  final _boolValues = <String, bool>{};
  final _optionalValues = <String, String?>{};

  @override
  void initState() {
    super.initState();
    widget.initialValues.forEach((key, value) {
      if (value is String || value is int || value is double) {
        _textControllers[key] = TextEditingController(text: value.toString());
      } else if (value is bool) {
        _boolValues[key] = value;
      } else if (value is List<String>) {
        _optionalValues[key] = value.isNotEmpty ? value.first : null;
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _textControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<Widget> textFields = _textControllers.entries.map((entry) {
      final key = entry.key;
      final value = widget.initialValues[key];
      final keyboardType = value is int
          ? TextInputType.number
          : value is double
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text;

      final inputFormatters = value is int
          ? [FilteringTextInputFormatter.digitsOnly]
          : value is double
          ? [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))]
          : null;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: TextFormField(
          controller: entry.value,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            hintText: key,
            labelText: key,
            border: const OutlineInputBorder(),
          ),
          validator: (val) =>
              (val == null || val.isEmpty) ? 'Please enter a value' : null,
        ),
      );
    }).toList();

    final List<Widget> optionalValues = _optionalValues.entries.map((entry) {
      final options = widget.initialValues[entry.key];
      if (options is! List<String>) return const SizedBox.shrink();

      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(entry.key, style: theme.textTheme.titleMedium),
              ...options.map<Widget>((option) {
                return RadioListTile<String>(
                  title: Text(option, style: theme.textTheme.bodyLarge),
                  value: option,
                  groupValue: entry.value,
                  onChanged: (newVal) =>
                      setState(() => _optionalValues[entry.key] = newVal),
                );
              }).toList(),
            ],
          ),
        ),
      );
    }).toList();

    final List<Widget> booleanFields = _boolValues.entries.map((entry) {
      return CheckboxListTile(
        title: Text(entry.key, style: theme.textTheme.titleMedium),
        value: entry.value,
        onChanged: (val) =>
            setState(() => _boolValues[entry.key] = val ?? false),
      );
    }).toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(widget.title, style: theme.textTheme.titleMedium),
          const SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Column(children: textFields),
          ),
          const SizedBox(height: 16),
          ...optionalValues,
          ...booleanFields,
          const SizedBox(height: 16),
          ButtonActionBar(
            leftLabel: 'Back',
            rightLabel: 'Next',
            onLeftTap: context.read<AddEditProductCubit>().previousStep,

            onRightTap: _onSubmit,
          ),
        ],
      ),
    );
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields.')),
      );
      return;
    }

    final data = <String, dynamic>{};

    _textControllers.forEach((key, controller) {
      final original = widget.initialValues[key];
      final text = controller.text;
      if (original is int) {
        data[key] = int.tryParse(text) ?? 0;
      } else if (original is double) {
        data[key] = double.tryParse(text) ?? 0.0;
      } else {
        data[key] = text;
      }
    });

    data.addAll(_boolValues);
    data.addAll(_optionalValues);

    widget.onSubmit(data);
  }
}
