part of 'default.dart';

class GetUserVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetUserVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetUserData> dataDeserializer = (dynamic json)  => GetUserData.fromJson(jsonDecode(json));
  Serializer<GetUserVariables> varsSerializer = (GetUserVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetUserData, GetUserVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetUserData, GetUserVariables> ref() {
    GetUserVariables vars= GetUserVariables(id: id,);
    return _dataConnect.query("GetUser", dataDeserializer, varsSerializer, vars);
  }
}

class GetUserUser {
  String id;
  String? displayName;
  String? email;
  GetUserUserStore? store;
  GetUserUser.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),displayName = json['displayName'] == null ? null : nativeFromJson<String>(json['displayName']),email = json['email'] == null ? null : nativeFromJson<String>(json['email']),store = json['store'] == null ? null : GetUserUserStore.fromJson(json['store']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if (displayName != null) {
      json['displayName'] = nativeToJson<String?>(displayName);
    }
    if (email != null) {
      json['email'] = nativeToJson<String?>(email);
    }
    if (store != null) {
      json['store'] = store!.toJson();
    }
    return json;
  }

  GetUserUser({
    required this.id,
    this.displayName,
    this.email,
    this.store,
  });
}

class GetUserUserStore {
  String id;
  GetUserUserStore.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetUserUserStore({
    required this.id,
  });
}

class GetUserData {
  GetUserUser? user;
  GetUserData.fromJson(dynamic json):
  user = json['user'] == null ? null : GetUserUser.fromJson(json['user']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (user != null) {
      json['user'] = user!.toJson();
    }
    return json;
  }

  GetUserData({
    this.user,
  });
}

class GetUserVariables {
  String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetUserVariables.fromJson(Map<String, dynamic> json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetUserVariables({
    required this.id,
  });
}

