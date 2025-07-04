part of 'default.dart';

class GetStoreByIdVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetStoreByIdVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetStoreByIdData> dataDeserializer = (dynamic json)  => GetStoreByIdData.fromJson(jsonDecode(json));
  Serializer<GetStoreByIdVariables> varsSerializer = (GetStoreByIdVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetStoreByIdData, GetStoreByIdVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetStoreByIdData, GetStoreByIdVariables> ref() {
    GetStoreByIdVariables vars= GetStoreByIdVariables(id: id,);
    return _dataConnect.query("getStoreById", dataDeserializer, varsSerializer, vars);
  }
}

class GetStoreByIdStore {
  String id;
  String name;
  String description;
  String logoUrl;
  String phoneNumber;
  GetStoreByIdStore.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),name = nativeFromJson<String>(json['name']),description = nativeFromJson<String>(json['description']),logoUrl = nativeFromJson<String>(json['logoUrl']),phoneNumber = nativeFromJson<String>(json['phoneNumber']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['description'] = nativeToJson<String>(description);
    json['logoUrl'] = nativeToJson<String>(logoUrl);
    json['phoneNumber'] = nativeToJson<String>(phoneNumber);
    return json;
  }

  GetStoreByIdStore({
    required this.id,
    required this.name,
    required this.description,
    required this.logoUrl,
    required this.phoneNumber,
  });
}

class GetStoreByIdData {
  GetStoreByIdStore? store;
  GetStoreByIdData.fromJson(dynamic json):
  store = json['store'] == null ? null : GetStoreByIdStore.fromJson(json['store']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (store != null) {
      json['store'] = store!.toJson();
    }
    return json;
  }

  GetStoreByIdData({
    this.store,
  });
}

class GetStoreByIdVariables {
  String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetStoreByIdVariables.fromJson(Map<String, dynamic> json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetStoreByIdVariables({
    required this.id,
  });
}

