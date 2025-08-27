// product_list_screen.dart

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomSliverStaggeredGrid extends StatelessWidget {
  final List<Widget> children;
  final int crossAxisCount;
  final List<double> childAspectRatios;

  const CustomSliverStaggeredGrid({
    super.key,
    required this.children,
    required this.crossAxisCount,
    required this.childAspectRatios,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) => children[index],
        childCount: children.length,
      ),
      gridDelegate: SliverStaggeredGridDelegate(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatios: childAspectRatios,
      ),
    );
  }
}

class SliverStaggeredGridDelegate extends SliverGridDelegate {
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final List<double> _childAspectRatios;

  SliverStaggeredGridDelegate({
    required this.crossAxisCount,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    required List<double> childAspectRatios,
  }) : _childAspectRatios = childAspectRatios;

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final double usableCrossAxisExtent =
        constraints.crossAxisExtent - crossAxisSpacing * (crossAxisCount - 1);
    final double childCrossAxisExtent = usableCrossAxisExtent / crossAxisCount;
    return _SliverStaggeredGridLayout(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      childCrossAxisExtent: childCrossAxisExtent,
      childAspectRatios: _childAspectRatios,
    );
  }

  @override
  bool shouldRelayout(SliverStaggeredGridDelegate oldDelegate) {
    return oldDelegate.crossAxisCount != crossAxisCount ||
        oldDelegate.mainAxisSpacing != mainAxisSpacing ||
        oldDelegate.crossAxisSpacing != crossAxisSpacing ||
        oldDelegate._childAspectRatios != _childAspectRatios;
  }
}

class _SliverStaggeredGridLayout extends SliverGridLayout {
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childCrossAxisExtent;
  final List<double> childAspectRatios;

  _SliverStaggeredGridLayout({
    required this.crossAxisCount,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
    required this.childCrossAxisExtent,
    required this.childAspectRatios,
  }) {
    _cacheLayout(childAspectRatios.length);
  }

  late final List<double> _columnHeights;
  late final List<SliverGridGeometry> _geometries;

  void _cacheLayout(int childCount) {
    _columnHeights = List.filled(crossAxisCount, 0.0);
    _geometries = List.generate(childCount, (index) {
      int shortestColumn = 0;
      for (int j = 1; j < crossAxisCount; j++) {
        if (_columnHeights[j] < _columnHeights[shortestColumn]) {
          shortestColumn = j;
        }
      }
      final scrollOffset = _columnHeights[shortestColumn];
      final crossAxisOffset =
          shortestColumn * (childCrossAxisExtent + crossAxisSpacing);
      final mainAxisExtent = childCrossAxisExtent / childAspectRatios[index];
      _columnHeights[shortestColumn] += mainAxisExtent + mainAxisSpacing;

      return SliverGridGeometry(
        scrollOffset: scrollOffset,
        crossAxisOffset: crossAxisOffset,
        mainAxisExtent: mainAxisExtent,
        crossAxisExtent: childCrossAxisExtent,
      );
    });
  }

  @override
  double computeMaxScrollOffset(int childCount) {
    if (_columnHeights.isEmpty) return 0.0;
    return _columnHeights.reduce(math.max) - mainAxisSpacing;
  }

  @override
  SliverGridGeometry getGeometryForChildIndex(int index) => _geometries[index];
  @override
  int getMaxChildIndexForScrollOffset(double scrollOffset) =>
      childAspectRatios.length - 1;
  @override
  int getMinChildIndexForScrollOffset(double scrollOffset) => 0;
}
