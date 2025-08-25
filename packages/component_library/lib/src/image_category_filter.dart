import 'package:flutter/material.dart';

class ImageCategoryFilter<T> extends StatelessWidget {
  final List<T> items;
  final String? selectedLabel;
  final ValueChanged<T?> onItemChanged;
  final String Function(T) labelBuilder;
  final String Function(T) imageBuilder;

  const ImageCategoryFilter({
    super.key,
    required this.items,
    required this.onItemChanged,
    required this.labelBuilder,
    required this.imageBuilder,
    this.selectedLabel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: items.length,
        itemBuilder: (ctx, index) {
          final item = items[index];
          final label = labelBuilder(item);
          final imageUrl = imageBuilder(item);
          final isSelected = selectedLabel != null && label == selectedLabel;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  shape: const CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {
                      if (isSelected) {
                        onItemChanged(null); // deselect
                      } else {
                        onItemChanged(item);
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      width: isSelected ? 70 : 62,
                      height: isSelected ? 70 : 62,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                          width: 2.5,
                        ),
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
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
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.black87,
                    ),
                    child: Text(label),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
