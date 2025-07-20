part of 'default.dart';

class GetAllAddressesVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetAllAddressesVariablesBuilder(this._dataConnect, );
  Deserializer<GetAllAddressesData> dataDeserializer = (dynamic json)  => GetAllAddressesData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetAllAddressesData, void>> execute() {
    return ref().execute();
  }

  QueryRef<GetAllAddressesData, void> ref() {
    
    return _dataConnect.query("getAllAddresses", dataDeserializer, emptySerializer, null);
  }
}

class GetAllAddressesAddresses {
  String id;
  String label;
  String? addressLine;
  String? district;
  String? province;
  double? longitude;
  double? latitude;
  bool isDefault;
  Timestamp createdAt;
  GetAllAddressesAddresses.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),label = nativeFromJson<String>(json['label']),addressLine = json['addressLine'] == null ? null : nativeFromJson<String>(json['addressLine']),district = json['district'] == null ? null : nativeFromJson<String>(json['district']),province = json['province'] == null ? null : nativeFromJson<String>(json['province']),longitude = json['longitude'] == null ? null : nativeFromJson<double>(json['longitude']),latitude = json['latitude'] == null ? null : nativeFromJson<double>(json['latitude']),isDefault = nativeFromJson<bool>(json['isDefault']),createdAt = Timestamp.fromJson(json['createdAt']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
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
    json['createdAt'] = createdAt.toJson();
    return json;
  }

  GetAllAddressesAddresses({
    required this.id,
    required this.label,
    this.addressLine,
    this.district,
    this.province,
    this.longitude,
    this.latitude,
    required this.isDefault,
    required this.createdAt,
  });
}

class GetAllAddressesData {
  List<GetAllAddressesAddresses> addresses;
  GetAllAddressesData.fromJson(dynamic json):
  addresses = (json['addresses'] as List<dynamic>)
        .map((e) => GetAllAddressesAddresses.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['addresses'] = addresses.map((e) => e.toJson()).toList();
    return json;
  }

  GetAllAddressesData({
    required this.addresses,
  });
}

