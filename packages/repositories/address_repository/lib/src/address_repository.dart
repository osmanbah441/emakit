import 'mock_repository_impl.dart';
import 'package:domain_models/domain_models.dart';

abstract class AddressRepository {
  /// The static instance that provides access to the concrete implementation.
  static AddressRepository instance = MockAddressRepositoryImpl();

  Future<List<Address>> getAddresses();

  Future<void> addAddress({
    required String streetAddress,
    required String city,
    required double latitude,
    required double longitude,
    bool isDefault = false,
  });

  Future<void> updateAddress({
    required String addressId,
    String? streetAddress,
    String? city,
    ({double latitude, double longitude})? location,
    bool? isDefault,
  });

  Future<void> deleteAddress(String addressId);
}
