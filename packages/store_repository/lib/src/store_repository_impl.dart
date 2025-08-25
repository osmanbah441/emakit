import 'package:domain_models/domain_models.dart';
import 'package:store_repository/src/store_repository.dart';

class StoreRepositoryImpl implements StoreRepository {
  const StoreRepositoryImpl();
  @override
  Future<void> createStore({
    required String ownerId,
    required String name,
    required String description,
    String? logoUrl,
    List<String>? phones,
    List<String>? emails,
  }) {
    // TODO: implement createStore
    throw UnimplementedError();
  }

  @override
  Future<void> deleteStore(String storeId) {
    // TODO: implement deleteStore
    throw UnimplementedError();
  }

  @override
  Future<List<Store>> getAllStores({
    String status = 'pending',
    String? lastStoreId,
    int limit = 20,
  }) {
    // TODO: implement getAllStores
    throw UnimplementedError();
  }

  @override
  Future<Store?> getOwnedStore() {
    // TODO: implement getOwnedStore
    throw UnimplementedError();
  }

  @override
  Future<Store?> getStoreById(String storeId) {
    // TODO: implement getStoreById
    throw UnimplementedError();
  }

  @override
  Future<void> updateStore({
    required String storeId,
    String? name,
    String? description,
    String? logoUrl,
    List<String>? phones,
    List<String>? emails,
  }) {
    // TODO: implement updateStore
    throw UnimplementedError();
  }

  @override
  Future<void> updateStoreStatus(String storeId, String newStatus) {
    // TODO: implement updateStoreStatus
    throw UnimplementedError();
  }
}
