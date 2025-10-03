// class WaveformAmplitude {
//   final double current;
//   final double max;

import 'package:flutter/material.dart';

class FeaturedListSection<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final VoidCallback? onSeeAllTap;
  final int? itemLimit;
  final double listSpacing;

  const FeaturedListSection({
    super.key,
    required this.title,
    required this.items,
    required this.itemBuilder,
    this.onSeeAllTap,
    this.itemLimit,
    this.listSpacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final List<T> displayItems = itemLimit == null
        ? items
        : items.take(itemLimit!).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            if (onSeeAllTap != null)
              TextButton(onPressed: onSeeAllTap, child: const Text('See all')),
          ],
        ),
        const SizedBox(height: 8.0),
        ListView.separated(
          itemCount: displayItems.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final item = displayItems[index];
            return itemBuilder(context, item);
          },
          separatorBuilder: (context, index) => SizedBox(height: listSpacing),
        ),
      ],
    );
  }
}
