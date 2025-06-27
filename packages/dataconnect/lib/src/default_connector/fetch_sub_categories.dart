part of 'default.dart';

class FetchSubCategoriesVariablesBuilder {
  String parentId;

  final FirebaseDataConnect _dataConnect;
  FetchSubCategoriesVariablesBuilder(this._dataConnect, {required  this.parentId,});
  Deserializer<FetchSubCategoriesData> dataDeserializer = (dynamic json)  => FetchSubCategoriesData.fromJson(jsonDecode(json));
  Serializer<FetchSubCategoriesVariables> varsSerializer = (FetchSubCategoriesVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<FetchSubCategoriesData, FetchSubCategoriesVariables>> execute() {
    return ref().execute();
  }

  QueryRef<FetchSubCategoriesData, FetchSubCategoriesVariables> ref() {
    FetchSubCategoriesVariables vars= FetchSubCategoriesVariables(parentId: parentId,);
    return _dataConnect.query("fetchSubCategories", dataDeserializer, varsSerializer, vars);
  }
}

class FetchSubCategoriesCategories {
  String? parentId;
  String id;
  String name;
  String? description;
  FetchSubCategoriesCategories.fromJson(dynamic json):
  parentId = json['parentId'] == null ? null : nativeFromJson<String>(json['parentId']),id = nativeFromJson<String>(json['id']),name = nativeFromJson<String>(json['name']),description = json['description'] == null ? null : nativeFromJson<String>(json['description']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (parentId != null) {
      json['parentId'] = nativeToJson<String?>(parentId);
    }
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    if (description != null) {
      json['description'] = nativeToJson<String?>(description);
    }
    return json;
  }

  FetchSubCategoriesCategories({
    this.parentId,
    required this.id,
    required this.name,
    this.description,
  });
}

class FetchSubCategoriesData {
  List<FetchSubCategoriesCategories> categories;
  FetchSubCategoriesData.fromJson(dynamic json):
  categories = (json['categories'] as List<dynamic>)
        .map((e) => FetchSubCategoriesCategories.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['categories'] = categories.map((e) => e.toJson()).toList();
    return json;
  }

  FetchSubCategoriesData({
    required this.categories,
  });
}

class FetchSubCategoriesVariables {
  String parentId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  FetchSubCategoriesVariables.fromJson(Map<String, dynamic> json):
  parentId = nativeFromJson<String>(json['parentId']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['parentId'] = nativeToJson<String>(parentId);
    return json;
  }

  FetchSubCategoriesVariables({
    required this.parentId,
  });
}

