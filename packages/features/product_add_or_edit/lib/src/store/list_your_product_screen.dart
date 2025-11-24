import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../components/image_upload_box.dart';

class ListYourProductScreen extends StatefulWidget {
  const ListYourProductScreen({super.key});

  @override
  State<ListYourProductScreen> createState() => _ListYourProductScreenState();
}

class _ListYourProductScreenState extends State<ListYourProductScreen> {
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(child: ResponsiveImageUploadCard(onTap: () {})),
      ),
    );
  }
}
