part of 'default.dart';

class GetChildrenCategoriesVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetChildrenCategoriesVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetChildrenCategoriesData> dataDeserializer = (dynamic json)  => GetChildrenCategoriesData.fromJson(jsonDecode(json));
  Serializer<GetChildrenCategoriesVariables> varsSerializer = (GetChildrenCategoriesVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetChildrenCategoriesData, GetChildrenCategoriesVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetChildrenCategoriesData, GetChildrenCategoriesVariables> ref() {
    GetChildrenCategoriesVariables vars= GetChildrenCategoriesVariables(id: id,);
    return _dataConnect.query("getChildrenCategories", dataDeserializer, varsSerializer, vars);
  }
}

class GetChildrenCategoriesCategories {
  String id;
  String name;
  String description;
  String imageUrl;
  AnyValue? variationAttributes;
  List<String>? specificationAttributes;
  String? parentCategoryId;
  GetChildrenCategoriesCategories.fromJson(dynamic json):
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

  GetChildrenCategoriesCategories({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.variationAttributes,
    this.specificationAttributes,
    this.parentCategoryId,
  });
}

class GetChildrenCategoriesData {
  List<GetChildrenCategoriesCategories> categories;
  GetChildrenCategoriesData.fromJson(dynamic json):
  categories = (json['categories'] as List<dynamic>)
        .map((e) => GetChildrenCategoriesCategories.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['categories'] = categories.map((e) => e.toJson()).toList();
    return json;
  }

  GetChildrenCategoriesData({
    required this.categories,
  });
}

class GetChildrenCategoriesVariables {
  String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetChildrenCategoriesVariables.fromJson(Map<String, dynamic> json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetChildrenCategoriesVariables({
    required this.id,
  });
}

