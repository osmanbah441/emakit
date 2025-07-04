import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    super.key,
    required this.imageUrl,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  final String imageUrl;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  void _showDailog(BuildContext context) async => await showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: CachedProductImage(
          imageUrl: imageUrl,
          borderRadius: BorderRadius.circular(24),
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Row(
          children: [
            InkWell(
              onTap: () => _showDailog(context),
              child: SizedBox(
                width: 80,
                height: 80,
                child: CachedProductImage(
                  borderRadius: BorderRadius.circular(12),
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
