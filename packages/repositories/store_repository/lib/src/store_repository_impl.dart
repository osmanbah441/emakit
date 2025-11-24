import 'store_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StoreRepositoryImpl implements StoreRepository {
  const StoreRepositoryImpl();

  static final _client = Supabase.instance.client;
  static final _table = 'store';
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
    final res = await _client.from(_table).select();

    return res.map((e) => e.toStore()).toList();
  }

  @override
  Future<Store?> getOwnedStore() async {
    return null;
  }

  @override
  Future<Store?> getStoreById(String storeId) async {
    return _client
        .from(_table)
        .select()
        .eq('id', storeId)
        .single()
        .then((value) => value.toStore());
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

  @override
  Future<StoreMetricModel> getStoreDashboardMetric(String id) async {
    return await _client
        .from('v_store_dashboard_metrics')
        .select()
        .eq('store_id', id)
        .single()
        .then((res) {
          return StoreMetricModel.fromJson(res);
        });
  }
}

extension on Map<String, dynamic> {
  Store toStore() {
    return Store(
      id: this['id'],
      ownerId: this['owner_id'],
      name: this['name'] as String,
      logoUrl: this['logo_url'],
    );
  }
}
