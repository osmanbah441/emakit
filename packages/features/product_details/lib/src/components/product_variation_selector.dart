import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';

class ProductVariationSelector extends StatelessWidget {
  const ProductVariationSelector({
    super.key,
    required this.variants,
    required this.selectedVariant,
    required this.onVariantSelected,
  });

  final List<ProductVariation> variants;
  final ProductVariation? selectedVariant;
  final ValueChanged<ProductVariation> onVariantSelected;

  @override
  Widget build(BuildContext context) {
    if (variants.isEmpty) return const SizedBox.shrink();

    final attributeKeys = <String>{};
    for (final v in variants) {
      attributeKeys.addAll(v.attributes.keys);
    }

    final sortedKeys = attributeKeys.toList()
      ..sort((a, b) {
        if (a == 'Color') return -1;
        if (b == 'Color') return 1;
        return 0;
      });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sortedKeys.map((key) {
        final options = <String>{};
        for (final v in variants) {
          final val = v.attributes[key];
          if (val is String && val.isNotEmpty) options.add(val);
        }

        final selectedValue = selectedVariant?.attributes[key];

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  key,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              key == 'Color'
                  ? _buildColorSelector(
                      context,
                      options.toList(),
                      selectedValue,
                    )
                  : _buildChoiceSelector(
                      context,
                      key,
                      options.toList(),
                      selectedValue,
                    ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildColorSelector(
    BuildContext context,
    List<String> options,
    String? selected,
  ) {
    // Get color swatches from variants
    final colorOptions = variants
        .map((v) => v.attributes['Color'] as String?)
        .whereType<String>()
        .toSet()
        .map((colorName) {
          final variant = variants.firstWhere(
            (v) => v.attributes['Color'] == colorName,
            orElse: () => variants.first,
          );
          final swatchUrl = variant.media.isNotEmpty
              ? variant.media.first.url
              : 'https://placehold.co/70x70/CCCCCC/000000?text=$colorName';
          return ColorOption(name: colorName, swatchImageUrl: swatchUrl);
        })
        .toList();

    return CircularImageSelector<ColorOption>(
      items: colorOptions,
      labelBuilder: (c) => c.name,
      imageBuilder: (c) => c.swatchImageUrl,
      selectedLabel: selected,
      onItemChanged: (c) {
        _updateVariant('Color', c.name);
      },
      isItemDisabled: (c) => !_isOptionAvailable('Color', c.name),
    );
  }

  Widget _buildChoiceSelector(
    BuildContext context,
    String key,
    List<String> options,
    String? selected,
  ) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: options.map((option) {
          final isSelected = option == selected;
          // Uses the less strict check
          final isDisabled = !_isOptionAvailable(key, option);

          return GestureDetector(
            onTap: isDisabled ? null : () => _updateVariant(key, option),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? theme.colorScheme.primary
                    : (isDisabled
                          ? theme.colorScheme.surfaceContainerHighest
                          : theme.colorScheme.surface),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : (isDisabled
                            ? Colors.grey.shade300
                            : Colors.grey.shade400),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Text(
                option,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDisabled
                      ? theme.colorScheme.onSurface.withOpacity(0.5)
                      : (isSelected
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.onSurface),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _updateVariant(String key, String value) {
    final currentAttrs = selectedVariant?.attributes ?? {};

    final newAttrs = Map<String, String>.from(currentAttrs)..[key] = value;

    ProductVariation? matchedVariant = variants.firstWhere(
      (v) {
        for (final attr in newAttrs.entries) {
          if (v.attributes[attr.key] != attr.value) return false;
        }
        return true;
      },
      orElse: () {
        return variants.firstWhere(
          (v) => v.attributes[key] == value,
          orElse: () => selectedVariant ?? variants.first,
        );
      },
    );

    onVariantSelected(matchedVariant);
  }

  bool _isOptionAvailable(String key, String value) {
    return variants.any((v) => v.attributes[key] == value);
  }
}
