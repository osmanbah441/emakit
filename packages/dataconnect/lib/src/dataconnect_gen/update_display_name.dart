part of 'default.dart';

class UpdateDisplayNameVariablesBuilder {
  String displayName;

  final FirebaseDataConnect _dataConnect;
  UpdateDisplayNameVariablesBuilder(this._dataConnect, {required  this.displayName,});
  Deserializer<UpdateDisplayNameData> dataDeserializer = (dynamic json)  => UpdateDisplayNameData.fromJson(jsonDecode(json));
  Serializer<UpdateDisplayNameVariables> varsSerializer = (UpdateDisplayNameVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateDisplayNameData, UpdateDisplayNameVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateDisplayNameData, UpdateDisplayNameVariables> ref() {
    UpdateDisplayNameVariables vars= UpdateDisplayNameVariables(displayName: displayName,);
    return _dataConnect.mutation("updateDisplayName", dataDeserializer, varsSerializer, vars);
  }
}

class UpdateDisplayNameUserUpdate {
  String uid;
  UpdateDisplayNameUserUpdate.fromJson(dynamic json):
  
  uid = nativeFromJson<String>(json['uid']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['uid'] = nativeToJson<String>(uid);
    return json;
  }

  UpdateDisplayNameUserUpdate({
    required this.uid,
  });
}

class UpdateDisplayNameData {
  UpdateDisplayNameUserUpdate? user_update;
  UpdateDisplayNameData.fromJson(dynamic json):
  
  user_update = json['user_update'] == null ? null : UpdateDisplayNameUserUpdate.fromJson(json['user_update']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (user_update != null) {
      json['user_update'] = user_update!.toJson();
    }
    return json;
  }

  UpdateDisplayNameData({
    this.user_update,
  });
}

class UpdateDisplayNameVariables {
  String displayName;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateDisplayNameVariables.fromJson(Map<String, dynamic> json):
  
  displayName = nativeFromJson<String>(json['displayName']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['displayName'] = nativeToJson<String>(displayName);
    return json;
  }

  UpdateDisplayNameVariables({
    required this.displayName,
  });
}

