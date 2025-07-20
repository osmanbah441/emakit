part of 'default.dart';

class GetAllUsersVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetAllUsersVariablesBuilder(this._dataConnect, );
  Deserializer<GetAllUsersData> dataDeserializer = (dynamic json)  => GetAllUsersData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetAllUsersData, void>> execute() {
    return ref().execute();
  }

  QueryRef<GetAllUsersData, void> ref() {
    
    return _dataConnect.query("getAllUsers", dataDeserializer, emptySerializer, null);
  }
}

class GetAllUsersUsers {
  String id;
  String? displayName;
  String? email;
  String? phoneNumber;
  String? photoUrl;
  GetAllUsersUsersStore? store;
  GetAllUsersUsersAddress? address;
  GetAllUsersUsers.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),displayName = json['displayName'] == null ? null : nativeFromJson<String>(json['displayName']),email = json['email'] == null ? null : nativeFromJson<String>(json['email']),phoneNumber = json['phoneNumber'] == null ? null : nativeFromJson<String>(json['phoneNumber']),photoUrl = json['photoUrl'] == null ? null : nativeFromJson<String>(json['photoUrl']),store = json['store'] == null ? null : GetAllUsersUsersStore.fromJson(json['store']),address = json['address'] == null ? null : GetAllUsersUsersAddress.fromJson(json['address']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if (displayName != null) {
      json['displayName'] = nativeToJson<String?>(displayName);
    }
    if (email != null) {
      json['email'] = nativeToJson<String?>(email);
    }
    if (phoneNumber != null) {
      json['phoneNumber'] = nativeToJson<String?>(phoneNumber);
    }
    if (photoUrl != null) {
      json['photoUrl'] = nativeToJson<String?>(photoUrl);
    }
    if (store != null) {
      json['store'] = store!.toJson();
    }
    if (address != null) {
      json['address'] = address!.toJson();
    }
    return json;
  }

  GetAllUsersUsers({
    required this.id,
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoUrl,
    this.store,
    this.address,
  });
}

class GetAllUsersUsersStore {
  String id;
  String name;
  GetAllUsersUsersStore.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),name = nativeFromJson<String>(json['name']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  GetAllUsersUsersStore({
    required this.id,
    required this.name,
  });
}

class GetAllUsersUsersAddress {
  String label;
  String? addressLine;
  String? district;
  String? province;
  double? longitude;
  double? latitude;
  bool isDefault;
  GetAllUsersUsersAddress.fromJson(dynamic json):
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

  GetAllUsersUsersAddress({
    required this.label,
    this.addressLine,
    this.district,
    this.province,
    this.longitude,
    this.latitude,
    required this.isDefault,
  });
}

class GetAllUsersData {
  List<GetAllUsersUsers> users;
  GetAllUsersData.fromJson(dynamic json):
  users = (json['users'] as List<dynamic>)
        .map((e) => GetAllUsersUsers.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['users'] = users.map((e) => e.toJson()).toList();
    return json;
  }

  GetAllUsersData({
    required this.users,
  });
}

