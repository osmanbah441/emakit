part of 'default.dart';

class GetAllActiveStoresVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetAllActiveStoresVariablesBuilder(this._dataConnect, );
  Deserializer<GetAllActiveStoresData> dataDeserializer = (dynamic json)  => GetAllActiveStoresData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetAllActiveStoresData, void>> execute() {
    return ref().execute();
  }

  QueryRef<GetAllActiveStoresData, void> ref() {
    
    return _dataConnect.query("getAllActiveStores", dataDeserializer, emptySerializer, null);
  }
}

class GetAllActiveStoresStores {
  String id;
  String name;
  String? description;
  String? logoUrl;
  String status;
  String phoneNumber;
  GetAllActiveStoresStoresOwner owner;
  GetAllActiveStoresStores.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  description = json['description'] == null ? null : nativeFromJson<String>(json['description']),
  logoUrl = json['logoUrl'] == null ? null : nativeFromJson<String>(json['logoUrl']),
  status = nativeFromJson<String>(json['status']),
  phoneNumber = nativeFromJson<String>(json['phoneNumber']),
  owner = GetAllActiveStoresStoresOwner.fromJson(json['owner']);

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

  GetAllActiveStoresStores({
    required this.id,
    required this.name,
    this.description,
    this.logoUrl,
    required this.status,
    required this.phoneNumber,
    required this.owner,
  });
}

class GetAllActiveStoresStoresOwner {
  String? displayName;
  GetAllActiveStoresStoresOwner.fromJson(dynamic json):
  
  displayName = json['displayName'] == null ? null : nativeFromJson<String>(json['displayName']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (displayName != null) {
      json['displayName'] = nativeToJson<String?>(displayName);
    }
    return json;
  }

  GetAllActiveStoresStoresOwner({
    this.displayName,
  });
}

class GetAllActiveStoresData {
  List<GetAllActiveStoresStores> stores;
  GetAllActiveStoresData.fromJson(dynamic json):
  
  stores = (json['stores'] as List<dynamic>)
        .map((e) => GetAllActiveStoresStores.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['stores'] = stores.map((e) => e.toJson()).toList();
    return json;
  }

  GetAllActiveStoresData({
    required this.stores,
  });
}

