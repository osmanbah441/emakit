enum AttributeDataType {
  dropdown,
  text,
  number;

  String get displayString {
    return name.replaceFirst(name[0], name[0].toUpperCase());
  }

  static AttributeDataType fromString(String? type) {
    if (type != null && type.isNotEmpty) {
      try {
        return AttributeDataType.values.byName(type.toLowerCase());
      } catch (_) {
        return AttributeDataType.text;
      }
    }
    return AttributeDataType.text;
  }
}
