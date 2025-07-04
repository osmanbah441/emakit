import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.0),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            spacing: 12,
            children: [
              CachedProductImage(
                imageUrl: imageUrl,
                width: 60,
                height: 60,
                borderRadius: BorderRadius.circular(12),
              ),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
