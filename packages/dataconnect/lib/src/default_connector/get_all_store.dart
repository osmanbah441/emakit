part of 'default.dart';

class GetAllStoreVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetAllStoreVariablesBuilder(this._dataConnect, );
  Deserializer<GetAllStoreData> dataDeserializer = (dynamic json)  => GetAllStoreData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetAllStoreData, void>> execute() {
    return ref().execute();
  }

  QueryRef<GetAllStoreData, void> ref() {
    
    return _dataConnect.query("getAllStore", dataDeserializer, emptySerializer, null);
  }
}

class GetAllStoreStores {
  String id;
  String name;
  String description;
  String logoUrl;
  String phoneNumber;
  GetAllStoreStores.fromJson(dynamic json):
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

  GetAllStoreStores({
    required this.id,
    required this.name,
    required this.description,
    required this.logoUrl,
    required this.phoneNumber,
  });
}

class GetAllStoreData {
  List<GetAllStoreStores> stores;
  GetAllStoreData.fromJson(dynamic json):
  stores = (json['stores'] as List<dynamic>)
        .map((e) => GetAllStoreStores.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['stores'] = stores.map((e) => e.toJson()).toList();
    return json;
  }

  GetAllStoreData({
    required this.stores,
  });
}

