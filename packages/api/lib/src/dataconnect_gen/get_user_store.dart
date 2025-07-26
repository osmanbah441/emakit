part of 'default.dart';

class GetUserStoreVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetUserStoreVariablesBuilder(this._dataConnect, );
  Deserializer<GetUserStoreData> dataDeserializer = (dynamic json)  => GetUserStoreData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetUserStoreData, void>> execute() {
    return ref().execute();
  }

  QueryRef<GetUserStoreData, void> ref() {
    
    return _dataConnect.query("getUserStore", dataDeserializer, emptySerializer, null);
  }
}

class GetUserStoreUser {
  GetUserStoreUserStore? store;
  GetUserStoreUser.fromJson(dynamic json):
  
  store = json['store'] == null ? null : GetUserStoreUserStore.fromJson(json['store']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (store != null) {
      json['store'] = store!.toJson();
    }
    return json;
  }

  GetUserStoreUser({
    this.store,
  });
}

class GetUserStoreUserStore {
  String id;
  String name;
  String? description;
  String? logoUrl;
  String status;
  String phoneNumber;
  GetUserStoreUserStoreOwner owner;
  GetUserStoreUserStore.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  description = json['description'] == null ? null : nativeFromJson<String>(json['description']),
  logoUrl = json['logoUrl'] == null ? null : nativeFromJson<String>(json['logoUrl']),
  status = nativeFromJson<String>(json['status']),
  phoneNumber = nativeFromJson<String>(json['phoneNumber']),
  owner = GetUserStoreUserStoreOwner.fromJson(json['owner']);

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

  GetUserStoreUserStore({
    required this.id,
    required this.name,
    this.description,
    this.logoUrl,
    required this.status,
    required this.phoneNumber,
    required this.owner,
  });
}

class GetUserStoreUserStoreOwner {
  String? displayName;
  GetUserStoreUserStoreOwner.fromJson(dynamic json):
  
  displayName = json['displayName'] == null ? null : nativeFromJson<String>(json['displayName']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (displayName != null) {
      json['displayName'] = nativeToJson<String?>(displayName);
    }
    return json;
  }

  GetUserStoreUserStoreOwner({
    this.displayName,
  });
}

class GetUserStoreData {
  GetUserStoreUser? user;
  GetUserStoreData.fromJson(dynamic json):
  
  user = json['user'] == null ? null : GetUserStoreUser.fromJson(json['user']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (user != null) {
      json['user'] = user!.toJson();
    }
    return json;
  }

  GetUserStoreData({
    this.user,
  });
}

