// import 'package:component_library/component_library.dart';
// import 'package:domain_models/src/attribute_data_type.dart';
// import 'package:domain_models/src/attribute_definition.dart';
// import 'package:flutter/material.dart';
// import 'package:domain_models/domain_models.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'attributes_option_management_fields.dart';
// import 'category_management_cubit.dart';

// class AddAttributeDialog extends StatefulWidget {
//   // Make the attribute optional for ADD mode.
//   // Pass an existing attribute for EDIT mode.
//   final AttributeDefinition? initialAttribute;

//   const AddAttributeDialog({super.key, this.initialAttribute});

//   @override
//   State<AddAttributeDialog> createState() => _AddAttributeDialogState();
// }

// class _AddAttributeDialogState extends State<AddAttributeDialog> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _unitController = TextEditingController();
//   final TextEditingController _optionController = TextEditingController();

//   late AttributeDataType _dataType;
//   final List<String> _optionValues = [];

//   bool get isEditMode => widget.initialAttribute != null;

//   @override
//   void initState() {
//     super.initState();
//     final attr = widget.initialAttribute;

//     // Initialize fields based on whether we are in Edit mode
//     if (attr != null) {
//       _nameController.text = attr.name;
//       _unitController.text = attr.unit ?? '';
//       _dataType = attr.dataType;

//       if (attr.options != null) {
//         _optionValues.addAll(attr.options!);
//       }
//     } else {
//       // Default to 'text' for Add mode
//       _dataType = AttributeDataType.text;
//     }
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _unitController.dispose();
//     _optionController.dispose();
//     super.dispose();
//   }

//   // --- Option Management (Unchanged) ---
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
//   // ------------------------------------

//   void _saveForm() {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();

//       // **Update the ID only in EDIT mode**
//       final String? idToSave = isEditMode ? widget.initialAttribute!.id : null;

//       // Determine the unit to save: only include unit if the type is 'number'
//       final String? unitToSave = _dataType == AttributeDataType.number
//           ? _unitController.text.trim().isNotEmpty
//                 ? _unitController.text.trim()
//                 : null
//           : null; // Explicitly set to null for all other types

//       // Determine options to save: only include options if the type is 'dropdown'
//       final List<String>? optionsToSave =
//           _dataType == AttributeDataType.dropdown && _optionValues.isNotEmpty
//           ? _optionValues
//           : null;

//       // Dispatch the action. upsertAttribute should handle creating new
//       // if id is null, or updating if id is provided.
//       context.read<CategoryManagementCubit>().upsertAttribute(
//         id: idToSave, // Pass ID for update, or null for add
//         name: _nameController.text,
//         dataType: _dataType.name,
//         unit: unitToSave,
//         options: optionsToSave,
//       );

//       Navigator.of(context).pop();
//     }
//   }

//   void _onDataTypeChanged(AttributeDataType? newValue) {
//     if (newValue == null || newValue == _dataType) {
//       return;
//     }

//     setState(() {
//       // Prevent changing the data type if in EDIT mode (Data types are often immutable)
//       // Unless your system explicitly allows type changes, which is rare.
//       if (isEditMode) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Cannot change Data Type for an existing attribute.'),
//           ),
//         );
//         return;
//       }

//       _dataType = newValue;

//       // Clear options/unit based on the new type
//       if (newValue != AttributeDataType.dropdown) {
//         _optionValues.clear();
//       }
//       if (newValue != AttributeDataType.number) {
//         _unitController.clear();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isEditing = isEditMode;
//     final titleText = isEditing
//         ? 'Edit Attribute: ${widget.initialAttribute!.name}'
//         : 'Add New Attribute Definition';

//     return AlertDialog(
//       title: Text(
//         titleText,
//         style: theme.textTheme.headlineSmall?.copyWith(
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       contentPadding: const EdgeInsets.all(24.0),
//       actionsPadding: const EdgeInsets.only(right: 24, bottom: 24, top: 16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       content: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                   labelText: 'Attribute Name',
//                   hintText: 'e.g., Color',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter an attribute name' : null,
//               ),
//               const SizedBox(height: 16),

//               DropdownButtonFormField<AttributeDataType>(
//                 isExpanded: true,
//                 initialValue: _dataType,
//                 decoration: InputDecoration(
//                   labelText: 'Data Type',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 // Disable changing the data type in Edit mode
//                 onChanged: isEditing ? null : _onDataTypeChanged,

//                 items: AttributeDataType.values.map((type) {
//                   return DropdownMenuItem(
//                     value: type,
//                     // If editing, disable items that don't match the current type for visual clarity
//                     enabled: !isEditing || type == _dataType,
//                     child: Text(type.displayString),
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(height: 16),

//               // Conditionally show the Unit field for 'number' type only
//               if (_dataType == AttributeDataType.number)
//                 Column(
//                   children: [
//                     TextFormField(
//                       controller: _unitController,
//                       decoration: InputDecoration(
//                         labelText: 'Unit',
//                         hintText: 'e.g., kg, cm',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                   ],
//                 ),

//               // Conditionally show Option Management for 'dropdown' type only
//               if (_dataType == AttributeDataType.dropdown)
//                 OptionManagementFields(
//                   optionController: _optionController,
//                   optionValues: _optionValues,
//                   onAddOption: _addOption,
//                   onRemoveOption: _removeOption,
//                 ),
//             ],
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
//                     label: isEditing ? 'Update' : 'Save',
//                     onPressed: _saveForm,
//                     isExtended: false,
//                   );
//           },
//         ),
//       ],
//     );
//   }
// }
