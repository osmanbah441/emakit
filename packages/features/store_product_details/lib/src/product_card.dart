import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.description,
    required this.name,
  });
  final String imageUrl;
  final String description;
  final String name;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isExpanded = true; // Controls the expanded/collapsed state

  @override
  Widget build(BuildContext context) {
    Widget collapsedView = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          AppNetworkImage(imageUrl: widget.imageUrl, width: 64, height: 64),
          const SizedBox(width: 16.0),
          Expanded(
            child: Text(
              widget.name,
              style: Theme.of(context).textTheme.titleMedium,
              overflow: TextOverflow.ellipsis, // Prevents text overflow
            ),
          ),
          const Icon(Icons.info_outline),
        ],
      ),
    );

    Widget expandedView = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppNetworkImage(
            imageUrl: widget.imageUrl,
            height: 200,
            width: double.infinity,
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.name,

                  overflow: TextOverflow.clip,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const Icon(Icons.info_outline),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            widget.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );

    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded; // Toggle expanded state on tap
        });
      },
      child: Card(
        margin: const EdgeInsets.all(16.0),
        child: AnimatedCrossFade(
          firstChild: collapsedView,
          secondChild: expandedView,
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
          sizeCurve: Curves.easeInOut,
        ),
      ),
    );
  }
}
