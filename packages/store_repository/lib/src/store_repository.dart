import 'package:domain_models/domain_models.dart';
import 'store_repository_impl.dart';

abstract class StoreRepository {
  static const StoreRepository instance = StoreRepositoryImpl();

  Future<void> createStore({
    required String ownerId,
    required String name,
    required String description,
    String? logoUrl,
    List<String>? phones,
    List<String>? emails,
  });

  Future<void> updateStore({
    required String storeId,
    String? name,
    String? description,
    String? logoUrl,
    List<String>? phones,
    List<String>? emails,
  });

  Future<Store?> getOwnedStore();

  Future<Store?> getStoreById(String storeId);

  Future<List<Store>> getAllStores({
    String status = 'pending',
    String? lastStoreId,
    int limit = 20,
  });

  Future<Store> toggleFollow(String storeId);

  Future<void> updateStoreStatus(String storeId, String newStatus);

  Future<void> deleteStore(String storeId);
}
