part of 'default.dart';

class AddNewCategoryVariablesBuilder {
  String name;
  Optional<String> _description = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _parentId = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  AddNewCategoryVariablesBuilder description(String? t) {
   _description.value = t;
   return this;
  }
  AddNewCategoryVariablesBuilder parentId(String? t) {
   _parentId.value = t;
   return this;
  }

  AddNewCategoryVariablesBuilder(this._dataConnect, {required  this.name,});
  Deserializer<AddNewCategoryData> dataDeserializer = (dynamic json)  => AddNewCategoryData.fromJson(jsonDecode(json));
  Serializer<AddNewCategoryVariables> varsSerializer = (AddNewCategoryVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AddNewCategoryData, AddNewCategoryVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AddNewCategoryData, AddNewCategoryVariables> ref() {
    AddNewCategoryVariables vars= AddNewCategoryVariables(name: name,description: _description,parentId: _parentId,);
    return _dataConnect.mutation("addNewCategory", dataDeserializer, varsSerializer, vars);
  }
}

class AddNewCategoryCategoryInsert {
  String id;
  AddNewCategoryCategoryInsert.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AddNewCategoryCategoryInsert({
    required this.id,
  });
}

class AddNewCategoryData {
  AddNewCategoryCategoryInsert category_insert;
  AddNewCategoryData.fromJson(dynamic json):
  category_insert = AddNewCategoryCategoryInsert.fromJson(json['category_insert']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['category_insert'] = category_insert.toJson();
    return json;
  }

  AddNewCategoryData({
    required this.category_insert,
  });
}

class AddNewCategoryVariables {
  String name;
  late Optional<String>description;
  late Optional<String>parentId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AddNewCategoryVariables.fromJson(Map<String, dynamic> json):
  name = nativeFromJson<String>(json['name']) {
  
    description = Optional.optional(nativeFromJson, nativeToJson);
    description.value = json['description'] == null ? null : nativeFromJson<String>(json['description']);
  
    parentId = Optional.optional(nativeFromJson, nativeToJson);
    parentId.value = json['parentId'] == null ? null : nativeFromJson<String>(json['parentId']);
  
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    if(description.state == OptionalState.set) {
      json['description'] = description.toJson();
    }
    if(parentId.state == OptionalState.set) {
      json['parentId'] = parentId.toJson();
    }
    return json;
  }

  AddNewCategoryVariables({
    required this.name,
    required this.description,
    required this.parentId,
  });
}

