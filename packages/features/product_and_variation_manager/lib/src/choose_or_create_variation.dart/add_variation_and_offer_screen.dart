// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:product_and_variation_manager/src/components/variation_offer_form.dart';

// import 'screens/cubit/product_flow_cubit.dart';
// import 'components/variation_images_picker.dart';
// import 'components/variation_card.dart';

// class AddVariationAndOffer extends StatefulWidget {
//   const AddVariationAndOffer({super.key});

//   @override
//   State<AddVariationAndOffer> createState() => _AddVariationAndOfferState();
// }

// class _AddVariationAndOfferState extends State<AddVariationAndOffer> {
//   int _selectedSegment = 0;

//   final Map<String, List<String>> _availableAttributes = {
//     'Color': ['Red', 'Blue', 'Green', 'Black', 'White'],
//     'Size': ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
//   };

//   final _variationImageUrls = [
//     'https://picsum.photos/seed/variationimg1/200/200',
//     'https://picsum.photos/seed/variationimg2/200/200',
//   ];

//   int _selectedExistingIndex = -1;

//   void _onSegmentChanged(int value) {
//     setState(() => _selectedSegment = value);
//   }

//   void _onAddImage() {
//     setState(() {
//       _variationImageUrls.add(
//         'https://picsum.photos/seed/${DateTime.now().microsecondsSinceEpoch}/200/200',
//       );
//     });
//   }

//   void _onRemoveImage(int index) {
//     setState(() => _variationImageUrls.removeAt(index));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isCreateNew = _selectedSegment == 1;
//     final cubit = context.read<ProductAddVariationCubit>();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Variation & Offers'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: cubit.setStateToSearchResult,
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             SizedBox(
//               width: double.infinity,
//               child: SegmentedButton<int>(
//                 segments: const [
//                   ButtonSegment(value: 0, label: Text('Choose Existing')),
//                   ButtonSegment(value: 1, label: Text('Create New')),
//                 ],
//                 showSelectedIcon: false,
//                 selected: {_selectedSegment},
//                 onSelectionChanged: (newSel) {
//                   if (newSel.isNotEmpty) _onSegmentChanged(newSel.first);
//                 },
//               ),
//             ),

//             const SizedBox(height: 24),

//             // --- CHOOSE OR CREATE ---
//             SizedBox(
//               height: 300,
//               child: isCreateNew
//                   ? VariationImagesPicker(
//                       imageUrls: _variationImageUrls,
//                       onAddImage: _onAddImage,
//                       onRemoveImage: _onRemoveImage,
//                     )
//                   : ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: _variationImageUrls.length,
//                       itemBuilder: (context, index) {
//                         final img = _variationImageUrls[index];

//                         return VariationCard(
//                           imageUrl: img,
//                           label: 'Variation ${index + 1}',
//                           isSelected: _selectedExistingIndex == index,
//                           onTap: () {
//                             setState(() => _selectedExistingIndex = index);
//                           },
//                         );
//                       },
//                     ),
//             ),

//             const SizedBox(height: 16),

//             VariationOfferForm(
//               attributes: _availableAttributes,
//               enableAttributeSelection: isCreateNew,
//               offerSelectedAttributes: {'Color': 'Red', 'Size': 'M'},
//               onOfferSubmitted: ({required price, required stock}) {},
//               onVariationSubmitted:
//                   ({
//                     required price,
//                     required selectedAttributes,
//                     required stock,
//                   }) {},
//             ),
//             const SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }
// }
