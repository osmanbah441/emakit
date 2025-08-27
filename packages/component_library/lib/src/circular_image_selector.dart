import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularImageSelector<T> extends StatelessWidget {
  const CircularImageSelector({
    super.key,
    required this.items,
    required this.onItemChanged,
    required this.labelBuilder,
    required this.imageBuilder,
    this.selectedLabel,
    this.selectedItemId,
    this.idBuilder,
  });

  final List<T> items;
  final ValueChanged<T> onItemChanged;
  final String Function(T) labelBuilder;
  final String Function(T) imageBuilder;
  final String? selectedLabel;
  final String? selectedItemId;
  final String Function(T)? idBuilder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
        itemCount: items.length,
        itemBuilder: (ctx, index) {
          final item = items[index];
          final label = labelBuilder(item);
          final imageUrl = imageBuilder(item);
          final primaryColor = Theme.of(context).colorScheme.primary;
          bool isSelected;
          if (idBuilder != null && selectedItemId != null) {
            final itemId = idBuilder!(item);
            isSelected = itemId == selectedItemId;
          } else {
            isSelected = selectedLabel != null && label == selectedLabel;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  width: isSelected ? 70 : 62,
                  height: isSelected ? 70 : 62,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? primaryColor : Colors.transparent,
                      width: 2.5,
                    ),
                  ),
                  child: Material(
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () => onItemChanged(item),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: Colors.grey[200]),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                ),
                if (label.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  AnimatedScale(
                    scale: isSelected ? 1.1 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSelected ? primaryColor : null,
                      ),
                      child: Text(label),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
