part of 'default.dart';

class ApplyForStoreVariablesBuilder {
  String name;
  String phoneNumber;

  final FirebaseDataConnect _dataConnect;
  ApplyForStoreVariablesBuilder(this._dataConnect, {required  this.name,required  this.phoneNumber,});
  Deserializer<ApplyForStoreData> dataDeserializer = (dynamic json)  => ApplyForStoreData.fromJson(jsonDecode(json));
  Serializer<ApplyForStoreVariables> varsSerializer = (ApplyForStoreVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<ApplyForStoreData, ApplyForStoreVariables>> execute() {
    return ref().execute();
  }

  MutationRef<ApplyForStoreData, ApplyForStoreVariables> ref() {
    ApplyForStoreVariables vars= ApplyForStoreVariables(name: name,phoneNumber: phoneNumber,);
    return _dataConnect.mutation("applyForStore", dataDeserializer, varsSerializer, vars);
  }
}

class ApplyForStoreStoreInsert {
  String id;
  ApplyForStoreStoreInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  ApplyForStoreStoreInsert({
    required this.id,
  });
}

class ApplyForStoreData {
  ApplyForStoreStoreInsert store_insert;
  ApplyForStoreData.fromJson(dynamic json):
  
  store_insert = ApplyForStoreStoreInsert.fromJson(json['store_insert']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['store_insert'] = store_insert.toJson();
    return json;
  }

  ApplyForStoreData({
    required this.store_insert,
  });
}

class ApplyForStoreVariables {
  String name;
  String phoneNumber;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ApplyForStoreVariables.fromJson(Map<String, dynamic> json):
  
  name = nativeFromJson<String>(json['name']),
  phoneNumber = nativeFromJson<String>(json['phoneNumber']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['phoneNumber'] = nativeToJson<String>(phoneNumber);
    return json;
  }

  ApplyForStoreVariables({
    required this.name,
    required this.phoneNumber,
  });
}

