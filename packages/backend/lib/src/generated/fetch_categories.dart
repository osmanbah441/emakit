part of 'default.dart';

class FetchCategoriesVariablesBuilder {
  Optional<bool> _onlyRoot = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  FetchCategoriesVariablesBuilder onlyRoot(bool? t) {
   _onlyRoot.value = t;
   return this;
  }

  FetchCategoriesVariablesBuilder(this._dataConnect, );
  Deserializer<FetchCategoriesData> dataDeserializer = (dynamic json)  => FetchCategoriesData.fromJson(jsonDecode(json));
  Serializer<FetchCategoriesVariables> varsSerializer = (FetchCategoriesVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<FetchCategoriesData, FetchCategoriesVariables>> execute() {
    return ref().execute();
  }

  QueryRef<FetchCategoriesData, FetchCategoriesVariables> ref() {
    FetchCategoriesVariables vars= FetchCategoriesVariables(onlyRoot: _onlyRoot,);
    return _dataConnect.query("fetchCategories", dataDeserializer, varsSerializer, vars);
  }
}

class FetchCategoriesCategories {
  String id;
  String name;
  String? description;
  String? parentId;
  FetchCategoriesCategories.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),name = nativeFromJson<String>(json['name']),description = json['description'] == null ? null : nativeFromJson<String>(json['description']),parentId = json['parentId'] == null ? null : nativeFromJson<String>(json['parentId']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    if (description != null) {
      json['description'] = nativeToJson<String?>(description);
    }
    if (parentId != null) {
      json['parentId'] = nativeToJson<String?>(parentId);
    }
    return json;
  }

  FetchCategoriesCategories({
    required this.id,
    required this.name,
    this.description,
    this.parentId,
  });
}

class FetchCategoriesData {
  List<FetchCategoriesCategories> categories;
  FetchCategoriesData.fromJson(dynamic json):
  categories = (json['categories'] as List<dynamic>)
        .map((e) => FetchCategoriesCategories.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['categories'] = categories.map((e) => e.toJson()).toList();
    return json;
  }

  FetchCategoriesData({
    required this.categories,
  });
}

class FetchCategoriesVariables {
  late Optional<bool>onlyRoot;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  FetchCategoriesVariables.fromJson(Map<String, dynamic> json) {
  
    onlyRoot = Optional.optional(nativeFromJson, nativeToJson);
    onlyRoot.value = json['onlyRoot'] == null ? null : nativeFromJson<bool>(json['onlyRoot']);
  
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if(onlyRoot.state == OptionalState.set) {
      json['onlyRoot'] = onlyRoot.toJson();
    }
    return json;
  }

  FetchCategoriesVariables({
    required this.onlyRoot,
  });
}

