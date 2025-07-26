part of 'default.dart';

class GetAllSuspendedStoresVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetAllSuspendedStoresVariablesBuilder(this._dataConnect, );
  Deserializer<GetAllSuspendedStoresData> dataDeserializer = (dynamic json)  => GetAllSuspendedStoresData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetAllSuspendedStoresData, void>> execute() {
    return ref().execute();
  }

  QueryRef<GetAllSuspendedStoresData, void> ref() {
    
    return _dataConnect.query("getAllSuspendedStores", dataDeserializer, emptySerializer, null);
  }
}

class GetAllSuspendedStoresStores {
  String id;
  String name;
  String? description;
  String? logoUrl;
  String status;
  String phoneNumber;
  GetAllSuspendedStoresStoresOwner owner;
  GetAllSuspendedStoresStores.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  description = json['description'] == null ? null : nativeFromJson<String>(json['description']),
  logoUrl = json['logoUrl'] == null ? null : nativeFromJson<String>(json['logoUrl']),
  status = nativeFromJson<String>(json['status']),
  phoneNumber = nativeFromJson<String>(json['phoneNumber']),
  owner = GetAllSuspendedStoresStoresOwner.fromJson(json['owner']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    if (description != null) {
      json['description'] = nativeToJson<String?>(description);
    }
    if (logoUrl != null) {
      json['logoUrl'] = nativeToJson<String?>(logoUrl);
    }
    json['status'] = nativeToJson<String>(status);
    json['phoneNumber'] = nativeToJson<String>(phoneNumber);
    json['owner'] = owner.toJson();
    return json;
  }

  GetAllSuspendedStoresStores({
    required this.id,
    required this.name,
    this.description,
    this.logoUrl,
    required this.status,
    required this.phoneNumber,
    required this.owner,
  });
}

class GetAllSuspendedStoresStoresOwner {
  String? displayName;
  GetAllSuspendedStoresStoresOwner.fromJson(dynamic json):
  
  displayName = json['displayName'] == null ? null : nativeFromJson<String>(json['displayName']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (displayName != null) {
      json['displayName'] = nativeToJson<String?>(displayName);
    }
    return json;
  }

  GetAllSuspendedStoresStoresOwner({
    this.displayName,
  });
}

class GetAllSuspendedStoresData {
  List<GetAllSuspendedStoresStores> stores;
  GetAllSuspendedStoresData.fromJson(dynamic json):
  
  stores = (json['stores'] as List<dynamic>)
        .map((e) => GetAllSuspendedStoresStores.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['stores'] = stores.map((e) => e.toJson()).toList();
    return json;
  }

  GetAllSuspendedStoresData({
    required this.stores,
  });
}

