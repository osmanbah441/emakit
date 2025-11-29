import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:product_and_variation_manager/src/components/dashed_border_painter.dart';
import 'package:product_and_variation_manager/src/create_or_edit_offer_screen.dart';

class AddVariantButtonComponent extends StatelessWidget {
  const AddVariantButtonComponent({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: CustomPaint(
        painter: DashedBorderPainter(
          color: Theme.of(context).colorScheme.primaryContainer,
          strokeWidth: 1.5,
          gap: 5.0,
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.add),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Add New Variant Offer', style: textTheme.titleSmall),
                  SizedBox(height: 2),
                  Text(
                    'Create another offer for this product',
                    style: textTheme.labelSmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
