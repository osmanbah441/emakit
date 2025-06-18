import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_listing_cubit.dart';

// final Map<String, List<String>> requiredSpecsByCategory = {
//   'Electronics': ['Brand', 'Model', 'Battery Life', 'Warranty'],
//   'Shoes': ['Brand', 'Size', 'Material', 'Color'],
//   'Furniture': ['Brand', 'Material', 'Dimensions', 'Weight Capacity'],
// };

class CompleteSpecsScreen extends StatefulWidget {
  const CompleteSpecsScreen({super.key});

  @override
  State<CompleteSpecsScreen> createState() => _CompleteSpecsScreenState();
}

class _CompleteSpecsScreenState extends State<CompleteSpecsScreen> {
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    final state = context.read<ProductCubit>().state;
    // final currentSpecs = state.specs;
    // final category = state.category ?? 'Electronics'; // fallback category

    // final requiredKeys = requiredSpecsByCategory[category] ?? [];

    for (var field in state.requiredSpecsByCategory) {
      _controllers[field] = TextEditingController();
    }
  }

  void _backToUpload() {
    context.read<ProductCubit>().previousStep();
  }

  void _onSubmit() {
    context.read<ProductCubit>().nextStep();
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final category = context.watch<ProductCubit>().state.category ?? 'Unknown';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Complete Specs for Category: $category",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Column(
            children: _controllers.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextField(
                  controller: entry.value,
                  decoration: InputDecoration(
                    labelText: entry.key,
                    border: const OutlineInputBorder(),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              ElevatedButton(
                onPressed: _backToUpload,
                child: Text("Back to Upload"),
              ),
              const SizedBox(width: 20),
              ElevatedButton(onPressed: _onSubmit, child: const Text("Finish")),
            ],
          ),
        ],
      ),
    );
  }
}
