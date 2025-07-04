enum VariationFieldType { string, list }

class VariationField {
  final String id;
  final String name;
  final VariationFieldType type;
  final List<String> options;

  const VariationField({
    required this.id,
    required this.name,
    required this.type,
    this.options = const [],
  });
}
