class Address {
  final String id;
  final String streetAddress;
  final String city;
  final ({double latitude, double longitude}) location;
  final bool isDefault;

  const Address({
    required this.id,
    required this.streetAddress,
    required this.city,
    required this.location,
    this.isDefault = false,
  });
}
