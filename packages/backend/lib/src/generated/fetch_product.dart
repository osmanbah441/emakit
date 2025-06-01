part of 'default.dart';

class FetchProductVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  FetchProductVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<FetchProductData> dataDeserializer = (dynamic json)  => FetchProductData.fromJson(jsonDecode(json));
  Serializer<FetchProductVariables> varsSerializer = (FetchProductVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<FetchProductData, FetchProductVariables>> execute() {
    return ref().execute();
  }

  QueryRef<FetchProductData, FetchProductVariables> ref() {
    FetchProductVariables vars= FetchProductVariables(id: id,);
    return _dataConnect.query("fetchProduct", dataDeserializer, varsSerializer, vars);
  }
}

class FetchProductProduct {
  String id;
  String name;
  String description;
  String categoryId;
  AnyValue specifications;
  List<FetchProductProductVariations> variations;
  FetchProductProduct.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),name = nativeFromJson<String>(json['name']),description = nativeFromJson<String>(json['description']),categoryId = nativeFromJson<String>(json['categoryId']),specifications = AnyValue.fromJson(json['specifications']),variations = (json['variations'] as List<dynamic>)
        .map((e) => FetchProductProductVariations.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['description'] = nativeToJson<String>(description);
    json['categoryId'] = nativeToJson<String>(categoryId);
    json['specifications'] = specifications.toJson();
    json['variations'] = variations.map((e) => e.toJson()).toList();
    return json;
  }

  FetchProductProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.specifications,
    required this.variations,
  });
}

class FetchProductProductVariations {
  String id;
  List<String> imageUrls;
  double price;
  AnyValue attributes;
  int stockQuantity;
  FetchProductProductVariations.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),imageUrls = (json['imageUrls'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),price = nativeFromJson<double>(json['price']),attributes = AnyValue.fromJson(json['attributes']),stockQuantity = nativeFromJson<int>(json['stockQuantity']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['imageUrls'] = imageUrls.map((e) => nativeToJson<String>(e)).toList();
    json['price'] = nativeToJson<double>(price);
    json['attributes'] = attributes.toJson();
    json['stockQuantity'] = nativeToJson<int>(stockQuantity);
    return json;
  }

  FetchProductProductVariations({
    required this.id,
    required this.imageUrls,
    required this.price,
    required this.attributes,
    required this.stockQuantity,
  });
}

class FetchProductData {
  FetchProductProduct? product;
  FetchProductData.fromJson(dynamic json):
  product = json['product'] == null ? null : FetchProductProduct.fromJson(json['product']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (product != null) {
      json['product'] = product!.toJson();
    }
    return json;
  }

  FetchProductData({
    this.product,
  });
}

class FetchProductVariables {
  String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  FetchProductVariables.fromJson(Map<String, dynamic> json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  FetchProductVariables({
    required this.id,
  });
}

