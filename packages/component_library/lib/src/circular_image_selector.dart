import 'package:component_library/component_library.dart'; // Ensure AppNetworkImage is here
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
    this.itemSize = 70,
    this.unselectedItemSize = 60,
    this.height = 100,
    this.maxLabelLines = 2,
    this.labelTextAlign = TextAlign.center,
    this.isItemDisabled,
  });

  final List<T> items;
  final ValueChanged<T> onItemChanged;
  final String Function(T) labelBuilder;
  final String Function(T) imageBuilder;
  final String? selectedLabel;
  final String? selectedItemId;
  final String Function(T)? idBuilder;
  final double itemSize;
  final double unselectedItemSize;
  final double height;
  final int maxLabelLines;
  final TextAlign labelTextAlign;
  final bool Function(T)? isItemDisabled;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: items.length,
        itemBuilder: (ctx, index) {
          final item = items[index];
          final label = labelBuilder(item);
          final imageUrl = imageBuilder(item);

          final isSelected = (idBuilder != null && selectedItemId != null)
              ? idBuilder!(item) == selectedItemId
              : selectedLabel != null && label == selectedLabel;

          // NEW: Check if the item is disabled
          final isDisabled = isItemDisabled?.call(item) ?? false;

          final currentSize = isSelected ? itemSize : unselectedItemSize;
          final borderColor = isDisabled
              ? Colors.grey.shade300
              : isSelected
              ? primaryColor
              : Colors.transparent;

          // Determine the tap action: disabled items cannot be selected
          final onTapAction = isDisabled ? null : () => onItemChanged(item);

          return Padding(
            padding: EdgeInsets.only(right: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onTapAction,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    width: currentSize,
                    height: currentSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: borderColor, width: 2.5),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Image
                        ClipOval(
                          child: AppNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // NEW: Opacity overlay for disabled items
                        if (isDisabled)
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (label.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  AnimatedScale(
                    scale: isSelected ? 1.05 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: textTheme.bodySmall!.copyWith(
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isDisabled
                            ? textTheme.bodySmall!.color!.withOpacity(0.4)
                            : isSelected
                            ? primaryColor
                            : textTheme.bodySmall!.color,
                      ),
                      child: SizedBox(
                        width: itemSize + 10, // ensures wrapping space
                        child: Text(
                          label,
                          textAlign: labelTextAlign,
                          maxLines: maxLabelLines,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
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
