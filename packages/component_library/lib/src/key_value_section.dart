import 'package:component_library/component_library.dart';
import 'package:component_library/src/summary_row.dart';
import 'package:flutter/material.dart';

/// Displays a section with a title and a list of key-value information rows.
class KeyValueSection extends StatelessWidget {
  final String title;
  final Map<String, dynamic> data;
  final String? highlightKey; // Optional key whose value should be highlighted
  final TextStyle? highlightValueStyle; // Style for the highlighted value

  const KeyValueSection({
    super.key,
    required this.title,
    required this.data,
    this.highlightKey,
    this.highlightValueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: title),
            ...data.entries.map((entry) {
              return Column(
                children: [
                  const Divider(height: 24.0, thickness: 1.0),

                  SummaryRow(label: entry.key, value: entry.value),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

/// A simple row to display a label and its corresponding value.
class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.labelStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style:
              labelStyle ?? TextStyle(fontSize: 15.0, color: Colors.grey[700]),
        ),
        Text(
          value,
          style:
              valueStyle ??
              const TextStyle(fontSize: 15.0, color: Colors.black),
        ),
      ],
    );
  }
}
