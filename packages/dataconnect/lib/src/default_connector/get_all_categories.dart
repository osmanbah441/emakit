part of 'default.dart';

class GetAllCategoriesVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetAllCategoriesVariablesBuilder(this._dataConnect, );
  Deserializer<GetAllCategoriesData> dataDeserializer = (dynamic json)  => GetAllCategoriesData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetAllCategoriesData, void>> execute() {
    return ref().execute();
  }

  QueryRef<GetAllCategoriesData, void> ref() {
    
    return _dataConnect.query("getAllCategories", dataDeserializer, emptySerializer, null);
  }
}

class GetAllCategoriesCategories {
  String id;
  String name;
  String description;
  String imageUrl;
  String? parentCategoryId;
  AnyValue? variationAttributes;
  GetAllCategoriesCategories.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),name = nativeFromJson<String>(json['name']),description = nativeFromJson<String>(json['description']),imageUrl = nativeFromJson<String>(json['imageUrl']),parentCategoryId = json['parentCategoryId'] == null ? null : nativeFromJson<String>(json['parentCategoryId']),variationAttributes = json['variationAttributes'] == null ? null : AnyValue.fromJson(json['variationAttributes']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['description'] = nativeToJson<String>(description);
    json['imageUrl'] = nativeToJson<String>(imageUrl);
    if (parentCategoryId != null) {
      json['parentCategoryId'] = nativeToJson<String?>(parentCategoryId);
    }
    if (variationAttributes != null) {
      json['variationAttributes'] = variationAttributes!.toJson();
    }
    return json;
  }

  GetAllCategoriesCategories({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.parentCategoryId,
    this.variationAttributes,
  });
}

class GetAllCategoriesData {
  List<GetAllCategoriesCategories> categories;
  GetAllCategoriesData.fromJson(dynamic json):
  categories = (json['categories'] as List<dynamic>)
        .map((e) => GetAllCategoriesCategories.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['categories'] = categories.map((e) => e.toJson()).toList();
    return json;
  }

  GetAllCategoriesData({
    required this.categories,
  });
}

