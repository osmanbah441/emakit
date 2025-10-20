import 'dart:math';

import '../address_repository.dart';
import 'package:domain_models/domain_models.dart';

class MockAddressRepositoryImpl implements AddressRepository {
  final List<Address> _addresses = [];

  @override
  Future<List<Address>> getAddresses() async {
    return List.unmodifiable(_addresses);
  }

  @override
  Future<void> addAddress({
    required String streetAddress,
    required String city,
    required double latitude,
    required double longitude,
    bool isDefault = false,
  }) async {
    final newAddress = Address(
      id: Random().nextInt(9999).toString(),
      streetAddress: streetAddress,
      city: city,
      location: (latitude: latitude, longitude: longitude),
      isDefault: isDefault,
    );
    _addresses.add(newAddress);
  }

  @override
  Future<void> updateAddress({
    required String addressId,
    String? streetAddress,
    String? city,
    ({double latitude, double longitude})? location,
    bool? isDefault,
  }) async {
    final index = _addresses.indexWhere((a) => a.id == addressId);
    if (index != -1) {
      final oldAddress = _addresses[index];
      _addresses[index] = Address(
        id: oldAddress.id,
        streetAddress: streetAddress ?? oldAddress.streetAddress,
        city: city ?? oldAddress.city,
        location: location ?? oldAddress.location,
        isDefault: isDefault ?? oldAddress.isDefault,
      );
    }
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    _addresses.removeWhere((a) => a.id == addressId);
  }
}
