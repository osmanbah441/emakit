part of 'product_details_cubit.dart';

extension on Product {
  /// Extracts all unique attributes and their possible values from a list of variations.
  LinkedHashMap<String, LinkedHashSet<dynamic>> extractAvailableAttributes() {
    final availableAttributes =
        LinkedHashMap<String, LinkedHashSet<dynamic>>.identity();
    for (var variation in variations) {
      variation.attributes.forEach((key, value) {
        availableAttributes
            .putIfAbsent(key, () => LinkedHashSet.identity())
            .add(value);
      });
    }
    return availableAttributes;
  }

  /// Sorts the available attributes based on a preferred order, placing others at the end.
  LinkedHashMap<String, LinkedHashSet<dynamic>> extractSortAvailableAttributes({
    List<String> preferredOrder = const ['color', 'size', 'material', 'finish'],
  }) {
    final availableAttributes = extractAvailableAttributes();
    final sortedAvailableAttributes =
        LinkedHashMap<String, LinkedHashSet<dynamic>>.identity();

    for (String key in preferredOrder) {
      if (availableAttributes.containsKey(key)) {
        sortedAvailableAttributes[key] = availableAttributes[key]!;
      }
    }
    availableAttributes.forEach((key, value) {
      if (!sortedAvailableAttributes.containsKey(key)) {
        sortedAvailableAttributes[key] = value;
      }
    });
    return sortedAvailableAttributes;
  }

  /// Determines the initial product variation to be selected based on available attributes.
  ProductVariation? determineInitialVariation(
    Map<String, dynamic>
    initialSelectedAttributes, // This map will be populated
  ) {
    final sortedAvailableAttributes = extractSortAvailableAttributes();
    ProductVariation? initialVariation;

    if (variations.isNotEmpty) {
      // Attempt to set initial selections based on the first variation's attributes
      final firstVariationAttributes = variations.first.attributes;
      firstVariationAttributes.forEach((key, value) {
        if (sortedAvailableAttributes.containsKey(key) &&
            sortedAvailableAttributes[key]!.contains(value)) {
          initialSelectedAttributes[key] = value;
        }
      });
      initialVariation = findMatchingVariation(initialSelectedAttributes);

      // If the first variation's attributes didn't make a full initial selection,
      // or if no variation matched that, try a more basic default.
      if (initialVariation == null && sortedAvailableAttributes.isNotEmpty) {
        initialSelectedAttributes.clear(); // Clear previous attempt
        // Select the first option for each attribute type if possible
        sortedAvailableAttributes.forEach((key, values) {
          if (values.isNotEmpty) {
            initialSelectedAttributes[key] = values.first;
          }
        });
        initialVariation = findMatchingVariation(initialSelectedAttributes);
      }
      // If still no match (e.g. product has attributes but no variations), set to first variation if any.
      initialVariation ??= variations.first;
    }
    return initialVariation;
  }

  /// Finds a product variation that matches the given set of selected attributes.
  ProductVariation? findMatchingVariation(Map<String, dynamic> selections) {
    if (selections.isEmpty && variations.isNotEmpty) {
      return null;
    }

    for (var variation in variations) {
      bool allMatch = true;
      for (var entry in selections.entries) {
        if (!variation.attributes.containsKey(entry.key) ||
            variation.attributes[entry.key] != entry.value) {
          allMatch = false;
          break;
        }
      }
      if (allMatch) {
        return variation;
      }
    }
    return null;
  }
}
