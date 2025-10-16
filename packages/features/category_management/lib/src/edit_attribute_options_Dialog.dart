// import 'package:component_library/component_library.dart';
// import 'package:flutter/material.dart';
// import 'package:domain_models/domain_models.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'attributes_option_management_fields.dart';
// import 'category_management_cubit.dart';

// class EditAttributeOptionsDialog extends StatefulWidget {
//   final AttributeDefinition attributeToEdit;

//   const EditAttributeOptionsDialog({super.key, required this.attributeToEdit});

//   @override
//   State<EditAttributeOptionsDialog> createState() =>
//       _EditAttributeOptionsDialogState();
// }

// class _EditAttributeOptionsDialogState
//     extends State<EditAttributeOptionsDialog> {
//   final TextEditingController _optionController = TextEditingController();

//   // Use a temporary list to manage changes
//   late final List<String> _optionValues;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize the list with a deep copy of the existing options
//     _optionValues = List.from(widget.attributeToEdit.options ?? []);
//   }

//   @override
//   void dispose() {
//     _optionController.dispose();
//     super.dispose();
//   }

//   void _addOption() {
//     final option = _optionController.text.trim();
//     if (option.isNotEmpty && !_optionValues.contains(option)) {
//       setState(() {
//         _optionValues.add(option);
//         _optionController.clear();
//       });
//     }
//   }

//   void _removeOption(String option) {
//     setState(() {
//       _optionValues.remove(option);
//     });
//   }

//   void _saveForm() {
//     // Call the Cubit's upsert function to update ONLY the options
//     context.read<CategoryManagementCubit>().upsertAttribute(
//       name: widget.attributeToEdit.name,
//       dataType: widget.attributeToEdit.dataType.name,
//       unit: widget.attributeToEdit.unit ?? '',
//       options: _optionValues, // Pass the new list of options
//     );

//     Navigator.of(context).pop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return AlertDialog(
//       title: Text(
//         'Edit Options for "${widget.attributeToEdit.name}"',
//         style: theme.textTheme.headlineSmall?.copyWith(
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       contentPadding: const EdgeInsets.all(24.0),
//       actionsPadding: const EdgeInsets.only(right: 24, bottom: 24, top: 16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       content: SizedBox(
//         width: 500,
//         child: SingleChildScrollView(
//           child: OptionManagementFields(
//             optionController: _optionController,
//             optionValues: _optionValues,
//             onAddOption: _addOption,
//             onRemoveOption: _removeOption,
//           ),
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: Text(
//             'Cancel',
//             style: theme.textTheme.labelLarge?.copyWith(
//               color: theme.colorScheme.onSurfaceVariant,
//             ),
//           ),
//         ),
//         const SizedBox(width: 8),

//         BlocBuilder<CategoryManagementCubit, CategoryManagementState>(
//           builder: (context, state) {
//             final isLoading = state.status == CategoryManagementStatus.loading;

//             return isLoading
//                 ? PrimaryActionButton.isLoadingProgress()
//                 : PrimaryActionButton(
//                     label: 'Save Changes',
//                     onPressed: _saveForm,
//                   );
//           },
//         ),
//       ],
//     );
//   }
// }
