import 'address_repository.dart';
import 'package:domain_models/domain_models.dart';

class AddressRepositoryImpl implements AddressRepository {
  const AddressRepositoryImpl();

  @override
  Future<List<Address>> getAddresses() {
    throw UnimplementedError();
  }

  @override
  Future<void> addAddress({
    required String streetAddress,
    required String city,
    required double latitude,
    required double longitude,
    bool isDefault = false,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateAddress({
    required String addressId,
    String? streetAddress,
    String? city,
    ({double latitude, double longitude})? location,
    bool? isDefault,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAddress(String addressId) {
    throw UnimplementedError();
  }
}
