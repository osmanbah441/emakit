part of 'default.dart';

class CreateStoreForUserVariablesBuilder {
  String ownerId;
  String name;
  String description;
  String logoUrl;
  String phoneNumber;

  final FirebaseDataConnect _dataConnect;
  CreateStoreForUserVariablesBuilder(this._dataConnect, {required  this.ownerId,required  this.name,required  this.description,required  this.logoUrl,required  this.phoneNumber,});
  Deserializer<CreateStoreForUserData> dataDeserializer = (dynamic json)  => CreateStoreForUserData.fromJson(jsonDecode(json));
  Serializer<CreateStoreForUserVariables> varsSerializer = (CreateStoreForUserVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateStoreForUserData, CreateStoreForUserVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateStoreForUserData, CreateStoreForUserVariables> ref() {
    CreateStoreForUserVariables vars= CreateStoreForUserVariables(ownerId: ownerId,name: name,description: description,logoUrl: logoUrl,phoneNumber: phoneNumber,);
    return _dataConnect.mutation("createStoreForUser", dataDeserializer, varsSerializer, vars);
  }
}

class CreateStoreForUserStoreInsert {
  String id;
  CreateStoreForUserStoreInsert.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateStoreForUserStoreInsert({
    required this.id,
  });
}

class CreateStoreForUserData {
  CreateStoreForUserStoreInsert store_insert;
  CreateStoreForUserData.fromJson(dynamic json):
  store_insert = CreateStoreForUserStoreInsert.fromJson(json['store_insert']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['store_insert'] = store_insert.toJson();
    return json;
  }

  CreateStoreForUserData({
    required this.store_insert,
  });
}

class CreateStoreForUserVariables {
  String ownerId;
  String name;
  String description;
  String logoUrl;
  String phoneNumber;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateStoreForUserVariables.fromJson(Map<String, dynamic> json):
  ownerId = nativeFromJson<String>(json['ownerId']),name = nativeFromJson<String>(json['name']),description = nativeFromJson<String>(json['description']),logoUrl = nativeFromJson<String>(json['logoUrl']),phoneNumber = nativeFromJson<String>(json['phoneNumber']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['ownerId'] = nativeToJson<String>(ownerId);
    json['name'] = nativeToJson<String>(name);
    json['description'] = nativeToJson<String>(description);
    json['logoUrl'] = nativeToJson<String>(logoUrl);
    json['phoneNumber'] = nativeToJson<String>(phoneNumber);
    return json;
  }

  CreateStoreForUserVariables({
    required this.ownerId,
    required this.name,
    required this.description,
    required this.logoUrl,
    required this.phoneNumber,
  });
}

