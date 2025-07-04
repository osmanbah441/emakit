import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:add_edit_product/src/add_edit_product_cubit.dart';
import 'package:component_library/component_library.dart';

class AddProductSpecificationStep extends StatefulWidget {
  const AddProductSpecificationStep({super.key});

  @override
  State<AddProductSpecificationStep> createState() =>
      _AddProductSpecificationStepState();
}

class _AddProductSpecificationStepState
    extends State<AddProductSpecificationStep> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final Map<String, TextEditingController> _specControllers = {};

  AddEditProductCubit get _cubit => context.read<AddEditProductCubit>();

  @override
  void initState() {
    super.initState();
    final product = _cubit.state.newProduct!;
    _nameController.text = product.name;
    _descriptionController.text = product.description;
    product.specifications.forEach((key, value) {
      _specControllers[key] = TextEditingController(text: value.toString());
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    for (final controller in _specControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final specs = <String, dynamic>{};
    _specControllers.forEach((key, controller) {
      final value = controller.text.trim();
      if (value.isEmpty) return;
      specs[key] = int.tryParse(value) ?? double.tryParse(value) ?? value;
    });

    _cubit.validateProductWithLLM(
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      specifications: specs,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Enter product name' : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  minLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) => val == null || val.isEmpty
                      ? 'Enter product description'
                      : null,
                ),
                const SizedBox(height: 16),

                for (final entry in _specControllers.entries)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: TextFormField(
                      controller: entry.value,
                      decoration: InputDecoration(
                        labelText: entry.key,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (val) => val == null || val.isEmpty
                          ? 'Enter ${entry.key}'
                          : null,
                    ),
                  ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        ButtonActionBar(
          leftLabel: 'Back',
          rightLabel: 'Next',
          onRightTap: _handleSubmit,
          onLeftTap: () => context.read<AddEditProductCubit>().goToStep(
            AddEditProductStep.similarProducts,
          ),
        ),
      ],
    );
  }
}
