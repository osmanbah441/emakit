part of 'default.dart';

class GetAllPendingApprovalStoresVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetAllPendingApprovalStoresVariablesBuilder(this._dataConnect, );
  Deserializer<GetAllPendingApprovalStoresData> dataDeserializer = (dynamic json)  => GetAllPendingApprovalStoresData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetAllPendingApprovalStoresData, void>> execute() {
    return ref().execute();
  }

  QueryRef<GetAllPendingApprovalStoresData, void> ref() {
    
    return _dataConnect.query("getAllPendingApprovalStores", dataDeserializer, emptySerializer, null);
  }
}

class GetAllPendingApprovalStoresStores {
  String id;
  String name;
  String? description;
  String? logoUrl;
  String status;
  String phoneNumber;
  GetAllPendingApprovalStoresStoresOwner owner;
  GetAllPendingApprovalStoresStores.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  description = json['description'] == null ? null : nativeFromJson<String>(json['description']),
  logoUrl = json['logoUrl'] == null ? null : nativeFromJson<String>(json['logoUrl']),
  status = nativeFromJson<String>(json['status']),
  phoneNumber = nativeFromJson<String>(json['phoneNumber']),
  owner = GetAllPendingApprovalStoresStoresOwner.fromJson(json['owner']);

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

  GetAllPendingApprovalStoresStores({
    required this.id,
    required this.name,
    this.description,
    this.logoUrl,
    required this.status,
    required this.phoneNumber,
    required this.owner,
  });
}

class GetAllPendingApprovalStoresStoresOwner {
  String? displayName;
  GetAllPendingApprovalStoresStoresOwner.fromJson(dynamic json):
  
  displayName = json['displayName'] == null ? null : nativeFromJson<String>(json['displayName']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (displayName != null) {
      json['displayName'] = nativeToJson<String?>(displayName);
    }
    return json;
  }

  GetAllPendingApprovalStoresStoresOwner({
    this.displayName,
  });
}

class GetAllPendingApprovalStoresData {
  List<GetAllPendingApprovalStoresStores> stores;
  GetAllPendingApprovalStoresData.fromJson(dynamic json):
  
  stores = (json['stores'] as List<dynamic>)
        .map((e) => GetAllPendingApprovalStoresStores.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['stores'] = stores.map((e) => e.toJson()).toList();
    return json;
  }

  GetAllPendingApprovalStoresData({
    required this.stores,
  });
}

