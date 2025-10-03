// import 'package:component_library/component_library.dart';
// import 'package:component_library/src/key_value_row.dart';
// import 'package:flutter/material.dart';

// /// Displays a section with a title and a list of key-value information rows.
// class KeyValueSection extends StatelessWidget {
//   final String title;
//   final Map<String, dynamic> data;
//   final String? highlightKey; // Optional key whose value should be highlighted
//   final TextStyle? highlightValueStyle; // Style for the highlighted value

//   const KeyValueSection({
//     super.key,
//     required this.title,
//     required this.data,
//     this.highlightKey,
//     this.highlightValueStyle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SectionTitle(title: title),
//             ...data.entries.map((entry) {
//               return Column(
//                 children: [
//                   const Divider(height: 24.0, thickness: 1.0),

//                   KeyValueRow(label: entry.key, value: entry.value.toString()),
//                 ],
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
