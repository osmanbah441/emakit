import 'dart:math';
import 'package:flutter/material.dart';

class ShowcaseGridSection<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final VoidCallback? onSeeMore;
  final void Function(T) onItemTap;

  final Widget Function(BuildContext context, T item) itemBuilder;

  const ShowcaseGridSection({
    super.key,
    required this.title,
    required this.items,
    this.onSeeMore,
    required this.onItemTap,
    required this.itemBuilder,
  });

  static const EdgeInsets _sectionPadding = EdgeInsets.symmetric(
    vertical: 24.0,
    horizontal: 16.0,
  );
  static const double _titleBottomSpacing = 20.0;
  static const double _gridSpacing = 8.0;
  static const double _gridRunSpacing = 8.0;
  static const double _minItemWidth = 144.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final displayItems = items.take(4).toList();

    return Padding(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: textTheme.titleMedium),
              if (onSeeMore != null)
                TextButton(onPressed: onSeeMore, child: const Text('See more')),
            ],
          ),
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
      ),
    );
  }
}
