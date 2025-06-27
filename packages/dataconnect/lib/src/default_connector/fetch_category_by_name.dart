part of 'default.dart';

class FetchCategoryByNameVariablesBuilder {
  String name;

  final FirebaseDataConnect _dataConnect;
  FetchCategoryByNameVariablesBuilder(this._dataConnect, {required  this.name,});
  Deserializer<FetchCategoryByNameData> dataDeserializer = (dynamic json)  => FetchCategoryByNameData.fromJson(jsonDecode(json));
  Serializer<FetchCategoryByNameVariables> varsSerializer = (FetchCategoryByNameVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<FetchCategoryByNameData, FetchCategoryByNameVariables>> execute() {
    return ref().execute();
  }

  QueryRef<FetchCategoryByNameData, FetchCategoryByNameVariables> ref() {
    FetchCategoryByNameVariables vars= FetchCategoryByNameVariables(name: name,);
    return _dataConnect.query("fetchCategoryByName", dataDeserializer, varsSerializer, vars);
  }
}

class FetchCategoryByNameCategories {
  String id;
  String name;
  String? description;
  FetchCategoryByNameCategories.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),name = nativeFromJson<String>(json['name']),description = json['description'] == null ? null : nativeFromJson<String>(json['description']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    if (description != null) {
      json['description'] = nativeToJson<String?>(description);
    }
    return json;
  }

  FetchCategoryByNameCategories({
    required this.id,
    required this.name,
    this.description,
  });
}

class FetchCategoryByNameData {
  List<FetchCategoryByNameCategories> categories;
  FetchCategoryByNameData.fromJson(dynamic json):
  categories = (json['categories'] as List<dynamic>)
        .map((e) => FetchCategoryByNameCategories.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['categories'] = categories.map((e) => e.toJson()).toList();
    return json;
  }

  FetchCategoryByNameData({
    required this.categories,
  });
}

class FetchCategoryByNameVariables {
  String name;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  FetchCategoryByNameVariables.fromJson(Map<String, dynamic> json):
  name = nativeFromJson<String>(json['name']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  FetchCategoryByNameVariables({
    required this.name,
  });
}

