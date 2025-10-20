import 'package:domain_models/domain_models.dart';
import 'store_repository.dart';

final _sampleStores = [
  const Store(
    id: 'store_001',
    name: 'Kadi’s Kollections',
    rating: 4.8,
    reviewCount: 1253,
  ),
  const Store(
    id: 'store_002',
    name: 'Freetown Fashion House',
    rating: 4.6,
    reviewCount: 879,
  ),
  const Store(
    id: 'store_003',
    name: 'Sierra Leone Styles',
    rating: 4.9,
    reviewCount: 2410,
  ),
];

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
  }) async {
    await Future.delayed(Duration(milliseconds: 300));
    return _sampleStores;
  }

  @override
  Future<Store?> getOwnedStore() async {
    return _sampleStores[0];
  }

  @override
  Future<Store?> getStoreById(String storeId) async {
    await Future.delayed(Duration(milliseconds: 300));
    return _sampleStores.firstWhere((store) => store.id == storeId);
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

  @override
  Future<Store> toggleFollow(String storeId) {
    throw UnimplementedError();
  }
}
