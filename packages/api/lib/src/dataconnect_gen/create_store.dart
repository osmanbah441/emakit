part of 'default.dart';

class CreateStoreVariablesBuilder {
  String name;
  String description;
  String ownerId;
  String addressId;
  String logoUrl;
  String phoneNumber;

  final FirebaseDataConnect _dataConnect;
  CreateStoreVariablesBuilder(this._dataConnect, {required  this.name,required  this.description,required  this.ownerId,required  this.addressId,required  this.logoUrl,required  this.phoneNumber,});
  Deserializer<CreateStoreData> dataDeserializer = (dynamic json)  => CreateStoreData.fromJson(jsonDecode(json));
  Serializer<CreateStoreVariables> varsSerializer = (CreateStoreVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateStoreData, CreateStoreVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateStoreData, CreateStoreVariables> ref() {
    CreateStoreVariables vars= CreateStoreVariables(name: name,description: description,ownerId: ownerId,addressId: addressId,logoUrl: logoUrl,phoneNumber: phoneNumber,);
    return _dataConnect.mutation("createStore", dataDeserializer, varsSerializer, vars);
  }
}

class CreateStoreStoreInsert {
  String id;
  CreateStoreStoreInsert.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateStoreStoreInsert({
    required this.id,
  });
}

class CreateStoreData {
  CreateStoreStoreInsert store_insert;
  CreateStoreData.fromJson(dynamic json):
  store_insert = CreateStoreStoreInsert.fromJson(json['store_insert']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['store_insert'] = store_insert.toJson();
    return json;
  }

  CreateStoreData({
    required this.store_insert,
  });
}

class CreateStoreVariables {
  String name;
  String description;
  String ownerId;
  String addressId;
  String logoUrl;
  String phoneNumber;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateStoreVariables.fromJson(Map<String, dynamic> json):
  name = nativeFromJson<String>(json['name']),description = nativeFromJson<String>(json['description']),ownerId = nativeFromJson<String>(json['ownerId']),addressId = nativeFromJson<String>(json['addressId']),logoUrl = nativeFromJson<String>(json['logoUrl']),phoneNumber = nativeFromJson<String>(json['phoneNumber']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['description'] = nativeToJson<String>(description);
    json['ownerId'] = nativeToJson<String>(ownerId);
    json['addressId'] = nativeToJson<String>(addressId);
    json['logoUrl'] = nativeToJson<String>(logoUrl);
    json['phoneNumber'] = nativeToJson<String>(phoneNumber);
    return json;
  }

  CreateStoreVariables({
    required this.name,
    required this.description,
    required this.ownerId,
    required this.addressId,
    required this.logoUrl,
    required this.phoneNumber,
  });
}

