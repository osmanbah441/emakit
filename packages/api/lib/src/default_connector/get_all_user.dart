part of 'default.dart';

class GetAllUserVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetAllUserVariablesBuilder(this._dataConnect, );
  Deserializer<GetAllUserData> dataDeserializer = (dynamic json)  => GetAllUserData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetAllUserData, void>> execute() {
    return ref().execute();
  }

  QueryRef<GetAllUserData, void> ref() {
    
    return _dataConnect.query("getAllUser", dataDeserializer, emptySerializer, null);
  }
}

class GetAllUserUsers {
  String id;
  String? displayName;
  String? phoneNumber;
  GetAllUserUsers.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),displayName = json['displayName'] == null ? null : nativeFromJson<String>(json['displayName']),phoneNumber = json['phoneNumber'] == null ? null : nativeFromJson<String>(json['phoneNumber']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if (displayName != null) {
      json['displayName'] = nativeToJson<String?>(displayName);
    }
    if (phoneNumber != null) {
      json['phoneNumber'] = nativeToJson<String?>(phoneNumber);
    }
    return json;
  }

  GetAllUserUsers({
    required this.id,
    this.displayName,
    this.phoneNumber,
  });
}

class GetAllUserData {
  List<GetAllUserUsers> users;
  GetAllUserData.fromJson(dynamic json):
  users = (json['users'] as List<dynamic>)
        .map((e) => GetAllUserUsers.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['users'] = users.map((e) => e.toJson()).toList();
    return json;
  }

  GetAllUserData({
    required this.users,
  });
}

