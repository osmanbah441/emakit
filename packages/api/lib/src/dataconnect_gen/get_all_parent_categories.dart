part of 'default.dart';

class GetAllParentCategoriesVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetAllParentCategoriesVariablesBuilder(this._dataConnect, );
  Deserializer<GetAllParentCategoriesData> dataDeserializer = (dynamic json)  => GetAllParentCategoriesData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetAllParentCategoriesData, void>> execute() {
    return ref().execute();
  }

  QueryRef<GetAllParentCategoriesData, void> ref() {
    
    return _dataConnect.query("getAllParentCategories", dataDeserializer, emptySerializer, null);
  }
}

class GetAllParentCategoriesCategories {
  String id;
  String name;
  String description;
  String imageUrl;
  AnyValue? variationAttributes;
  List<String>? specificationAttributes;
  String? parentCategoryId;
  GetAllParentCategoriesCategories.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),name = nativeFromJson<String>(json['name']),description = nativeFromJson<String>(json['description']),imageUrl = nativeFromJson<String>(json['imageUrl']),variationAttributes = json['variationAttributes'] == null ? null : AnyValue.fromJson(json['variationAttributes']),specificationAttributes = json['specificationAttributes'] == null ? null : (json['specificationAttributes'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),parentCategoryId = json['parentCategoryId'] == null ? null : nativeFromJson<String>(json['parentCategoryId']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['description'] = nativeToJson<String>(description);
    json['imageUrl'] = nativeToJson<String>(imageUrl);
    if (variationAttributes != null) {
      json['variationAttributes'] = variationAttributes!.toJson();
    }
    if (specificationAttributes != null) {
      json['specificationAttributes'] = specificationAttributes?.map((e) => nativeToJson<String>(e)).toList();
    }
    if (parentCategoryId != null) {
      json['parentCategoryId'] = nativeToJson<String?>(parentCategoryId);
    }
    return json;
  }

  GetAllParentCategoriesCategories({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.variationAttributes,
    this.specificationAttributes,
    this.parentCategoryId,
  });
}

class GetAllParentCategoriesData {
  List<GetAllParentCategoriesCategories> categories;
  GetAllParentCategoriesData.fromJson(dynamic json):
  categories = (json['categories'] as List<dynamic>)
        .map((e) => GetAllParentCategoriesCategories.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['categories'] = categories.map((e) => e.toJson()).toList();
    return json;
  }

  GetAllParentCategoriesData({
    required this.categories,
  });
}

