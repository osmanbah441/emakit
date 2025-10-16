// import 'package:flutter/material.dart';
// import 'package:domain_models/domain_models.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:component_library/component_library.dart';

// import 'category_specs.dart';

// class ProductFormScreen extends StatefulWidget {
//   final Product? product;
//   final XFile image;
//   final ProductCategoryType category;

//   const ProductFormScreen({
//     super.key,
//     this.product,
//     required this.category,
//     required this.image,
//   });

//   @override
//   State<ProductFormScreen> createState() => _ProductFormScreenState();
// }

// class _ProductFormScreenState extends State<ProductFormScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final Map<String, String> _specifications = {};

//   @override
//   void initState() {
//     super.initState();
//     if (widget.product != null) {
//       _nameController.text = widget.product!.name;
//       _specifications.addAll(widget.product!.specifications);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isEditing = widget.product != null;
//     final specFields = widget.category.specs;
//     final theme = Theme.of(context);

//     final imageHeader = SizedBox(
//       height: 154,
//       child: Card(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             spacing: 12,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadiusGeometry.circular(12),
//                 child: FutureBuilder(
//                   future: widget.image.readAsBytes(),
//                   builder: (context, asyncSnapshot) {
//                     if (asyncSnapshot.hasError) {
//                       return Center(child: Text('Error loading image'));
//                     }
//                     return Image.memory(
//                       asyncSnapshot.data!,

//                       height: 136,
//                       width: 136,
//                       fit: BoxFit.cover,
//                     );
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     TextFormField(
//                       controller: _nameController,
//                       decoration: const InputDecoration(
//                         labelText: 'Product Name',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (v) =>
//                           v == null || v.isEmpty ? 'Enter product name' : null,
//                     ),
//                     Text(
//                       "category: ${widget.category.name}",
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: theme.textTheme.labelLarge,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );

//     return Scaffold(
//       appBar: AppBar(title: Text(isEditing ? 'Edit Product' : 'Add Product')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               imageHeader,
//               const SizedBox(height: 32),
//               Text(
//                 'Product Specifications',
//                 style: theme.textTheme.titleMedium,
//               ),
//               const SizedBox(height: 16),
//               ...specFields.map((field) {
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 12),
//                   child: TextFormField(
//                     initialValue: _specifications[field],
//                     decoration: InputDecoration(
//                       labelText: field,
//                       border: const OutlineInputBorder(),
//                     ),
//                     onSaved: (val) => _specifications[field] = val ?? '',
//                     validator: (v) =>
//                         v == null || v.isEmpty ? 'Enter $field' : null,
//                   ),
//                 );
//               }),

//               const SizedBox(height: 20),

//               PrimaryActionButton(
//                 label: 'Add New Product',
//                 icon: Icon(Icons.save),
//                 onPressed: _saveProduct,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _saveProduct() {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//     }
//   }
// }
