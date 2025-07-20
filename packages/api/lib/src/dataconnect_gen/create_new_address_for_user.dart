part of 'default.dart';

class CreateNewAddressForUserVariablesBuilder {
  String label;
  Optional<String> _addressLine = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _district = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  CreateNewAddressForUserVariablesBuilder addressLine(String? t) {
   _addressLine.value = t;
   return this;
  }
  CreateNewAddressForUserVariablesBuilder district(String? t) {
   _district.value = t;
   return this;
  }

  CreateNewAddressForUserVariablesBuilder(this._dataConnect, {required  this.label,});
  Deserializer<CreateNewAddressForUserData> dataDeserializer = (dynamic json)  => CreateNewAddressForUserData.fromJson(jsonDecode(json));
  Serializer<CreateNewAddressForUserVariables> varsSerializer = (CreateNewAddressForUserVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateNewAddressForUserData, CreateNewAddressForUserVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateNewAddressForUserData, CreateNewAddressForUserVariables> ref() {
    CreateNewAddressForUserVariables vars= CreateNewAddressForUserVariables(label: label,addressLine: _addressLine,district: _district,);
    return _dataConnect.mutation("createNewAddressForUser", dataDeserializer, varsSerializer, vars);
  }
}

class CreateNewAddressForUserAddressInsert {
  String id;
  CreateNewAddressForUserAddressInsert.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateNewAddressForUserAddressInsert({
    required this.id,
  });
}

class CreateNewAddressForUserData {
  CreateNewAddressForUserAddressInsert address_insert;
  CreateNewAddressForUserData.fromJson(dynamic json):
  address_insert = CreateNewAddressForUserAddressInsert.fromJson(json['address_insert']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['address_insert'] = address_insert.toJson();
    return json;
  }

  CreateNewAddressForUserData({
    required this.address_insert,
  });
}

class CreateNewAddressForUserVariables {
  String label;
  late Optional<String>addressLine;
  late Optional<String>district;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateNewAddressForUserVariables.fromJson(Map<String, dynamic> json):
  label = nativeFromJson<String>(json['label']) {
  
    addressLine = Optional.optional(nativeFromJson, nativeToJson);
    addressLine.value = json['addressLine'] == null ? null : nativeFromJson<String>(json['addressLine']);
  
    district = Optional.optional(nativeFromJson, nativeToJson);
    district.value = json['district'] == null ? null : nativeFromJson<String>(json['district']);
  
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['label'] = nativeToJson<String>(label);
    if(addressLine.state == OptionalState.set) {
      json['addressLine'] = addressLine.toJson();
    }
    if(district.state == OptionalState.set) {
      json['district'] = district.toJson();
    }
    return json;
  }

  CreateNewAddressForUserVariables({
    required this.label,
    required this.addressLine,
    required this.district,
  });
}

