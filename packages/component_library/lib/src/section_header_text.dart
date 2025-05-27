import 'package:flutter/material.dart';

class SectionHeaderText extends StatelessWidget {
  final String title;

  const SectionHeaderText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
