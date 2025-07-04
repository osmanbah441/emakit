part of 'default.dart';

class CreateNewUserVariablesBuilder {
  String displayName;
  String phoneNumber;

  final FirebaseDataConnect _dataConnect;
  CreateNewUserVariablesBuilder(this._dataConnect, {required  this.displayName,required  this.phoneNumber,});
  Deserializer<CreateNewUserData> dataDeserializer = (dynamic json)  => CreateNewUserData.fromJson(jsonDecode(json));
  Serializer<CreateNewUserVariables> varsSerializer = (CreateNewUserVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateNewUserData, CreateNewUserVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateNewUserData, CreateNewUserVariables> ref() {
    CreateNewUserVariables vars= CreateNewUserVariables(displayName: displayName,phoneNumber: phoneNumber,);
    return _dataConnect.mutation("createNewUser", dataDeserializer, varsSerializer, vars);
  }
}

class CreateNewUserUserInsert {
  String id;
  CreateNewUserUserInsert.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateNewUserUserInsert({
    required this.id,
  });
}

class CreateNewUserData {
  CreateNewUserUserInsert user_insert;
  CreateNewUserData.fromJson(dynamic json):
  user_insert = CreateNewUserUserInsert.fromJson(json['user_insert']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_insert'] = user_insert.toJson();
    return json;
  }

  CreateNewUserData({
    required this.user_insert,
  });
}

class CreateNewUserVariables {
  String displayName;
  String phoneNumber;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateNewUserVariables.fromJson(Map<String, dynamic> json):
  displayName = nativeFromJson<String>(json['displayName']),phoneNumber = nativeFromJson<String>(json['phoneNumber']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['displayName'] = nativeToJson<String>(displayName);
    json['phoneNumber'] = nativeToJson<String>(phoneNumber);
    return json;
  }

  CreateNewUserVariables({
    required this.displayName,
    required this.phoneNumber,
  });
}

