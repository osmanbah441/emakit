part of 'default.dart';

class FetchCategoriesVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  FetchCategoriesVariablesBuilder(this._dataConnect, );
  Deserializer<FetchCategoriesData> dataDeserializer = (dynamic json)  => FetchCategoriesData.fromJson(jsonDecode(json));
  
  Future<QueryResult<FetchCategoriesData, void>> execute() {
    return ref().execute();
  }

  QueryRef<FetchCategoriesData, void> ref() {
    
    return _dataConnect.query("fetchCategories", dataDeserializer, emptySerializer, null);
  }
}

class FetchCategoriesCategories {
  String id;
  String name;
  String? description;
  FetchCategoriesCategories.fromJson(dynamic json):
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

  FetchCategoriesCategories({
    required this.id,
    required this.name,
    this.description,
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

