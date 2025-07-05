part of 'default.dart';

class GetProductByIdVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetProductByIdVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetProductByIdData> dataDeserializer = (dynamic json)  => GetProductByIdData.fromJson(jsonDecode(json));
  Serializer<GetProductByIdVariables> varsSerializer = (GetProductByIdVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetProductByIdData, GetProductByIdVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetProductByIdData, GetProductByIdVariables> ref() {
    GetProductByIdVariables vars= GetProductByIdVariables(id: id,);
    return _dataConnect.query("getProductById", dataDeserializer, varsSerializer, vars);
  }
}

class GetProductByIdProduct {
  String id;
  String name;
  String description;
  String categoryId;
  AnyValue specifications;
  List<GetProductByIdProductVariations> variations;
  GetProductByIdProduct.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),name = nativeFromJson<String>(json['name']),description = nativeFromJson<String>(json['description']),categoryId = nativeFromJson<String>(json['categoryId']),specifications = AnyValue.fromJson(json['specifications']),variations = (json['variations'] as List<dynamic>)
        .map((e) => GetProductByIdProductVariations.fromJson(e))
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

  GetProductByIdProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.specifications,
    required this.variations,
  });
}

class GetProductByIdProductVariations {
  String id;
  double price;
  String storeId;
  int stockQuantity;
  AnyValue attributes;
  List<String> imageUrls;
  GetProductByIdProductVariations.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),price = nativeFromJson<double>(json['price']),storeId = nativeFromJson<String>(json['storeId']),stockQuantity = nativeFromJson<int>(json['stockQuantity']),attributes = AnyValue.fromJson(json['attributes']),imageUrls = (json['imageUrls'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['price'] = nativeToJson<double>(price);
    json['storeId'] = nativeToJson<String>(storeId);
    json['stockQuantity'] = nativeToJson<int>(stockQuantity);
    json['attributes'] = attributes.toJson();
    json['imageUrls'] = imageUrls.map((e) => nativeToJson<String>(e)).toList();
    return json;
  }

  GetProductByIdProductVariations({
    required this.id,
    required this.price,
    required this.storeId,
    required this.stockQuantity,
    required this.attributes,
    required this.imageUrls,
  });
}

class GetProductByIdData {
  GetProductByIdProduct? product;
  GetProductByIdData.fromJson(dynamic json):
  product = json['product'] == null ? null : GetProductByIdProduct.fromJson(json['product']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (product != null) {
      json['product'] = product!.toJson();
    }
    return json;
  }

  GetProductByIdData({
    this.product,
  });
}

class GetProductByIdVariables {
  String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetProductByIdVariables.fromJson(Map<String, dynamic> json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetProductByIdVariables({
    required this.id,
  });
}

