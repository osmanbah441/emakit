part of 'default.dart';

class ApproveStoreVariablesBuilder {
  String storeId;

  final FirebaseDataConnect _dataConnect;
  ApproveStoreVariablesBuilder(this._dataConnect, {required  this.storeId,});
  Deserializer<ApproveStoreData> dataDeserializer = (dynamic json)  => ApproveStoreData.fromJson(jsonDecode(json));
  Serializer<ApproveStoreVariables> varsSerializer = (ApproveStoreVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<ApproveStoreData, ApproveStoreVariables>> execute() {
    return ref().execute();
  }

  MutationRef<ApproveStoreData, ApproveStoreVariables> ref() {
    ApproveStoreVariables vars= ApproveStoreVariables(storeId: storeId,);
    return _dataConnect.mutation("approveStore", dataDeserializer, varsSerializer, vars);
  }
}

class ApproveStoreStoreUpdate {
  String id;
  ApproveStoreStoreUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  ApproveStoreStoreUpdate({
    required this.id,
  });
}

class ApproveStoreData {
  ApproveStoreStoreUpdate? store_update;
  ApproveStoreData.fromJson(dynamic json):
  
  store_update = json['store_update'] == null ? null : ApproveStoreStoreUpdate.fromJson(json['store_update']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (store_update != null) {
      json['store_update'] = store_update!.toJson();
    }
    return json;
  }

  ApproveStoreData({
    this.store_update,
  });
}

class ApproveStoreVariables {
  String storeId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ApproveStoreVariables.fromJson(Map<String, dynamic> json):
  
  storeId = nativeFromJson<String>(json['storeId']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['storeId'] = nativeToJson<String>(storeId);
    return json;
  }

  ApproveStoreVariables({
    required this.storeId,
  });
}

