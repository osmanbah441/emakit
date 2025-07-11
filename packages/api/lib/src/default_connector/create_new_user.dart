part of 'default.dart';

class CreateNewUserVariablesBuilder {
  Optional<String> _displayName = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _phoneNumber = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _email = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _photoURL = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  CreateNewUserVariablesBuilder displayName(String? t) {
   _displayName.value = t;
   return this;
  }
  CreateNewUserVariablesBuilder phoneNumber(String? t) {
   _phoneNumber.value = t;
   return this;
  }
  CreateNewUserVariablesBuilder email(String? t) {
   _email.value = t;
   return this;
  }
  CreateNewUserVariablesBuilder photoURL(String? t) {
   _photoURL.value = t;
   return this;
  }

  CreateNewUserVariablesBuilder(this._dataConnect, );
  Deserializer<CreateNewUserData> dataDeserializer = (dynamic json)  => CreateNewUserData.fromJson(jsonDecode(json));
  Serializer<CreateNewUserVariables> varsSerializer = (CreateNewUserVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateNewUserData, CreateNewUserVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateNewUserData, CreateNewUserVariables> ref() {
    CreateNewUserVariables vars= CreateNewUserVariables(displayName: _displayName,phoneNumber: _phoneNumber,email: _email,photoURL: _photoURL,);
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
  late Optional<String>displayName;
  late Optional<String>phoneNumber;
  late Optional<String>email;
  late Optional<String>photoURL;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateNewUserVariables.fromJson(Map<String, dynamic> json) {
  
    displayName = Optional.optional(nativeFromJson, nativeToJson);
    displayName.value = json['displayName'] == null ? null : nativeFromJson<String>(json['displayName']);
  
    phoneNumber = Optional.optional(nativeFromJson, nativeToJson);
    phoneNumber.value = json['phoneNumber'] == null ? null : nativeFromJson<String>(json['phoneNumber']);
  
    email = Optional.optional(nativeFromJson, nativeToJson);
    email.value = json['email'] == null ? null : nativeFromJson<String>(json['email']);
  
    photoURL = Optional.optional(nativeFromJson, nativeToJson);
    photoURL.value = json['photoURL'] == null ? null : nativeFromJson<String>(json['photoURL']);
  
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if(displayName.state == OptionalState.set) {
      json['displayName'] = displayName.toJson();
    }
    if(phoneNumber.state == OptionalState.set) {
      json['phoneNumber'] = phoneNumber.toJson();
    }
    if(email.state == OptionalState.set) {
      json['email'] = email.toJson();
    }
    if(photoURL.state == OptionalState.set) {
      json['photoURL'] = photoURL.toJson();
    }
    return json;
  }

  CreateNewUserVariables({
    required this.displayName,
    required this.phoneNumber,
    required this.email,
    required this.photoURL,
  });
}

