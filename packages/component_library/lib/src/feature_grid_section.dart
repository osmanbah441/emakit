// class WaveformAmplitude {
//   final double current;
//   final double max;

import 'dart:math';
import 'package:flutter/material.dart';

class FeaturedGridSection<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final void Function(T) onItemTap;
  final Widget Function(BuildContext context, T item) itemBuilder;

  const FeaturedGridSection({
    super.key,
    required this.title,
    required this.items,
    required this.onItemTap,
    required this.itemBuilder,
  });

  static const double _titleBottomSpacing = 8.0;
  static const double _gridSpacing = 8.0;
  static const double _gridRunSpacing = 8.0;
  static const double _minItemWidth = 144.0;

  @override
  Widget build(BuildContext context) {
    final displayItems = items.take(4).toList();
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textTheme.titleLarge),
        const SizedBox(height: _titleBottomSpacing),
        LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final crossAxisCount = max(
              2,
              (screenWidth / _minItemWidth).floor(),
            );
            final itemWidth =
                (screenWidth - (crossAxisCount - 1) * _gridSpacing) /
                crossAxisCount;

            return Wrap(
              spacing: _gridSpacing,
              runSpacing: _gridRunSpacing,
              children: displayItems.map((item) {
                return SizedBox(
                  width: itemWidth,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12.0),
                    onTap: () => onItemTap(item),
                    child: itemBuilder(context, item),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
