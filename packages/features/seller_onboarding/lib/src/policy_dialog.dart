import 'package:flutter/material.dart';

class PolicyDialog extends StatelessWidget {
  final String title;
  final String content;

  const PolicyDialog({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Text(content), // Now displays plain text
      ),
    );
  }
}
