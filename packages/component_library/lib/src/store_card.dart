import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.followers,
    required this.isFollowed,
    required this.onFollowTap,
    required this.onTap,
  });

  final String name;
  final String imageUrl;
  final double rating;
  final int followers;
  final bool isFollowed;
  final VoidCallback onFollowTap;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.primaryColor),
        ),
        child: Row(
          children: [
            AppNetworkImage(
              imageUrl: imageUrl,
              borderRadius: BorderRadius.circular(12),
              width: 80,
              height: 80,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        rating.toString(),
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "$followers followers",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            TextButton(
              onPressed: onFollowTap,
              child: Text(isFollowed ? 'unfollow' : 'Follow'),
            ),
          ],
        ),
      ),
    );
  }
}
