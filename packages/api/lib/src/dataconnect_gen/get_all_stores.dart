part of 'default.dart';

class GetAllStoresVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetAllStoresVariablesBuilder(this._dataConnect, );
  Deserializer<GetAllStoresData> dataDeserializer = (dynamic json)  => GetAllStoresData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetAllStoresData, void>> execute() {
    return ref().execute();
  }

  QueryRef<GetAllStoresData, void> ref() {
    
    return _dataConnect.query("getAllStores", dataDeserializer, emptySerializer, null);
  }
}

class GetAllStoresStores {
  String id;
  String name;
  String description;
  String logoUrl;
  String phoneNumber;
  GetAllStoresStoresOwner owner;
  GetAllStoresStoresAddress? address;
  GetAllStoresStores.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),name = nativeFromJson<String>(json['name']),description = nativeFromJson<String>(json['description']),logoUrl = nativeFromJson<String>(json['logoUrl']),phoneNumber = nativeFromJson<String>(json['phoneNumber']),owner = GetAllStoresStoresOwner.fromJson(json['owner']),address = json['address'] == null ? null : GetAllStoresStoresAddress.fromJson(json['address']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['description'] = nativeToJson<String>(description);
    json['logoUrl'] = nativeToJson<String>(logoUrl);
    json['phoneNumber'] = nativeToJson<String>(phoneNumber);
    json['owner'] = owner.toJson();
    if (address != null) {
      json['address'] = address!.toJson();
    }
    return json;
  }

  GetAllStoresStores({
    required this.id,
    required this.name,
    required this.description,
    required this.logoUrl,
    required this.phoneNumber,
    required this.owner,
    this.address,
  });
}

class GetAllStoresStoresOwner {
  String? displayName;
  GetAllStoresStoresOwner.fromJson(dynamic json):
  displayName = json['displayName'] == null ? null : nativeFromJson<String>(json['displayName']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (displayName != null) {
      json['displayName'] = nativeToJson<String?>(displayName);
    }
    return json;
  }

  GetAllStoresStoresOwner({
    this.displayName,
  });
}

class GetAllStoresStoresAddress {
  String label;
  String? addressLine;
  String? district;
  String? province;
  double? longitude;
  double? latitude;
  bool isDefault;
  GetAllStoresStoresAddress.fromJson(dynamic json):
  label = nativeFromJson<String>(json['label']),addressLine = json['addressLine'] == null ? null : nativeFromJson<String>(json['addressLine']),district = json['district'] == null ? null : nativeFromJson<String>(json['district']),province = json['province'] == null ? null : nativeFromJson<String>(json['province']),longitude = json['longitude'] == null ? null : nativeFromJson<double>(json['longitude']),latitude = json['latitude'] == null ? null : nativeFromJson<double>(json['latitude']),isDefault = nativeFromJson<bool>(json['isDefault']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['label'] = nativeToJson<String>(label);
    if (addressLine != null) {
      json['addressLine'] = nativeToJson<String?>(addressLine);
    }
    if (district != null) {
      json['district'] = nativeToJson<String?>(district);
    }
    if (province != null) {
      json['province'] = nativeToJson<String?>(province);
    }
    if (longitude != null) {
      json['longitude'] = nativeToJson<double?>(longitude);
    }
    if (latitude != null) {
      json['latitude'] = nativeToJson<double?>(latitude);
    }
    json['isDefault'] = nativeToJson<bool>(isDefault);
    return json;
  }

  GetAllStoresStoresAddress({
    required this.label,
    this.addressLine,
    this.district,
    this.province,
    this.longitude,
    this.latitude,
    required this.isDefault,
  });
}

class GetAllStoresData {
  List<GetAllStoresStores> stores;
  GetAllStoresData.fromJson(dynamic json):
  stores = (json['stores'] as List<dynamic>)
        .map((e) => GetAllStoresStores.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['stores'] = stores.map((e) => e.toJson()).toList();
    return json;
  }

  GetAllStoresData({
    required this.stores,
  });
}

