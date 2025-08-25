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
  AnyValue specifications;
  String categoryId;
  List<GetProductByIdProductVariations> variations;
  GetProductByIdProduct.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  description = nativeFromJson<String>(json['description']),
  specifications = AnyValue.fromJson(json['specifications']),
  categoryId = nativeFromJson<String>(json['categoryId']),
  variations = (json['variations'] as List<dynamic>)
        .map((e) => GetProductByIdProductVariations.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['description'] = nativeToJson<String>(description);
    json['specifications'] = specifications.toJson();
    json['categoryId'] = nativeToJson<String>(categoryId);
    json['variations'] = variations.map((e) => e.toJson()).toList();
    return json;
  }

  GetProductByIdProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.specifications,
    required this.categoryId,
    required this.variations,
  });
}

class GetProductByIdProductVariations {
  String id;
  double price;
  List<String> imageUrls;
  AnyValue attributes;
  int availableStock;
  GetProductByIdProductVariations.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  price = nativeFromJson<double>(json['price']),
  imageUrls = (json['imageUrls'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),
  attributes = AnyValue.fromJson(json['attributes']),
  availableStock = nativeFromJson<int>(json['availableStock']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['price'] = nativeToJson<double>(price);
    json['imageUrls'] = imageUrls.map((e) => nativeToJson<String>(e)).toList();
    json['attributes'] = attributes.toJson();
    json['availableStock'] = nativeToJson<int>(availableStock);
    return json;
  }

  GetProductByIdProductVariations({
    required this.id,
    required this.price,
    required this.imageUrls,
    required this.attributes,
    required this.availableStock,
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

