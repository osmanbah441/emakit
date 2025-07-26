part of 'default.dart';

class GetCategoryByIdVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetCategoryByIdVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetCategoryByIdData> dataDeserializer = (dynamic json)  => GetCategoryByIdData.fromJson(jsonDecode(json));
  Serializer<GetCategoryByIdVariables> varsSerializer = (GetCategoryByIdVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetCategoryByIdData, GetCategoryByIdVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetCategoryByIdData, GetCategoryByIdVariables> ref() {
    GetCategoryByIdVariables vars= GetCategoryByIdVariables(id: id,);
    return _dataConnect.query("getCategoryById", dataDeserializer, varsSerializer, vars);
  }
}

class GetCategoryByIdCategory {
  String id;
  String name;
  String description;
  String imageUrl;
  AnyValue? variationAttributes;
  List<String>? specificationAttributes;
  String? parentCategoryId;
  GetCategoryByIdCategory.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  description = nativeFromJson<String>(json['description']),
  imageUrl = nativeFromJson<String>(json['imageUrl']),
  variationAttributes = json['variationAttributes'] == null ? null : AnyValue.fromJson(json['variationAttributes']),
  specificationAttributes = json['specificationAttributes'] == null ? null : (json['specificationAttributes'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),
  parentCategoryId = json['parentCategoryId'] == null ? null : nativeFromJson<String>(json['parentCategoryId']);

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

  GetCategoryByIdCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.variationAttributes,
    this.specificationAttributes,
    this.parentCategoryId,
  });
}

class GetCategoryByIdData {
  GetCategoryByIdCategory? category;
  GetCategoryByIdData.fromJson(dynamic json):
  
  category = json['category'] == null ? null : GetCategoryByIdCategory.fromJson(json['category']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (category != null) {
      json['category'] = category!.toJson();
    }
    return json;
  }

  GetCategoryByIdData({
    this.category,
  });
}

class GetCategoryByIdVariables {
  String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetCategoryByIdVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetCategoryByIdVariables({
    required this.id,
  });
}

