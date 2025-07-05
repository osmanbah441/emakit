part of 'default.dart';

class CreateNewCategoryVariablesBuilder {
  String name;
  String description;
  Optional<String> _parentId = Optional.optional(nativeFromJson, nativeToJson);
  String imageUrl;

  final FirebaseDataConnect _dataConnect;  CreateNewCategoryVariablesBuilder parentId(String? t) {
   _parentId.value = t;
   return this;
  }

  CreateNewCategoryVariablesBuilder(this._dataConnect, {required  this.name,required  this.description,required  this.imageUrl,});
  Deserializer<CreateNewCategoryData> dataDeserializer = (dynamic json)  => CreateNewCategoryData.fromJson(jsonDecode(json));
  Serializer<CreateNewCategoryVariables> varsSerializer = (CreateNewCategoryVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateNewCategoryData, CreateNewCategoryVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateNewCategoryData, CreateNewCategoryVariables> ref() {
    CreateNewCategoryVariables vars= CreateNewCategoryVariables(name: name,description: description,parentId: _parentId,imageUrl: imageUrl,);
    return _dataConnect.mutation("createNewCategory", dataDeserializer, varsSerializer, vars);
  }
}

class CreateNewCategoryCategoryInsert {
  String id;
  CreateNewCategoryCategoryInsert.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateNewCategoryCategoryInsert({
    required this.id,
  });
}

class CreateNewCategoryData {
  CreateNewCategoryCategoryInsert category_insert;
  CreateNewCategoryData.fromJson(dynamic json):
  category_insert = CreateNewCategoryCategoryInsert.fromJson(json['category_insert']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['category_insert'] = category_insert.toJson();
    return json;
  }

  CreateNewCategoryData({
    required this.category_insert,
  });
}

class CreateNewCategoryVariables {
  String name;
  String description;
  late Optional<String>parentId;
  String imageUrl;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateNewCategoryVariables.fromJson(Map<String, dynamic> json):
  name = nativeFromJson<String>(json['name']),description = nativeFromJson<String>(json['description']),imageUrl = nativeFromJson<String>(json['imageUrl']) {
  
    parentId = Optional.optional(nativeFromJson, nativeToJson);
    parentId.value = json['parentId'] == null ? null : nativeFromJson<String>(json['parentId']);
  
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['description'] = nativeToJson<String>(description);
    if(parentId.state == OptionalState.set) {
      json['parentId'] = parentId.toJson();
    }
    json['imageUrl'] = nativeToJson<String>(imageUrl);
    return json;
  }

  CreateNewCategoryVariables({
    required this.name,
    required this.description,
    required this.parentId,
    required this.imageUrl,
  });
}

