part of 'default.dart';

class GetStoreProductDetailsForOwnerVariablesBuilder {
  String storeId;
  String productId;

  final FirebaseDataConnect _dataConnect;
  GetStoreProductDetailsForOwnerVariablesBuilder(this._dataConnect, {required  this.storeId,required  this.productId,});
  Deserializer<GetStoreProductDetailsForOwnerData> dataDeserializer = (dynamic json)  => GetStoreProductDetailsForOwnerData.fromJson(jsonDecode(json));
  Serializer<GetStoreProductDetailsForOwnerVariables> varsSerializer = (GetStoreProductDetailsForOwnerVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetStoreProductDetailsForOwnerData, GetStoreProductDetailsForOwnerVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetStoreProductDetailsForOwnerData, GetStoreProductDetailsForOwnerVariables> ref() {
    GetStoreProductDetailsForOwnerVariables vars= GetStoreProductDetailsForOwnerVariables(storeId: storeId,productId: productId,);
    return _dataConnect.query("getStoreProductDetailsForOwner", dataDeserializer, varsSerializer, vars);
  }
}

class GetStoreProductDetailsForOwnerProduct {
  String id;
  String name;
  String description;
  AnyValue specifications;
  GetStoreProductDetailsForOwnerProductCategory category;
  List<GetStoreProductDetailsForOwnerProductVariation> variation;
  GetStoreProductDetailsForOwnerProduct.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  description = nativeFromJson<String>(json['description']),
  specifications = AnyValue.fromJson(json['specifications']),
  category = GetStoreProductDetailsForOwnerProductCategory.fromJson(json['category']),
  variation = (json['variation'] as List<dynamic>)
        .map((e) => GetStoreProductDetailsForOwnerProductVariation.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['description'] = nativeToJson<String>(description);
    json['specifications'] = specifications.toJson();
    json['category'] = category.toJson();
    json['variation'] = variation.map((e) => e.toJson()).toList();
    return json;
  }

  GetStoreProductDetailsForOwnerProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.specifications,
    required this.category,
    required this.variation,
  });
}

class GetStoreProductDetailsForOwnerProductCategory {
  AnyValue? variationAttributes;
  GetStoreProductDetailsForOwnerProductCategory.fromJson(dynamic json):
  
  variationAttributes = json['variationAttributes'] == null ? null : AnyValue.fromJson(json['variationAttributes']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (variationAttributes != null) {
      json['variationAttributes'] = variationAttributes!.toJson();
    }
    return json;
  }

  GetStoreProductDetailsForOwnerProductCategory({
    this.variationAttributes,
  });
}

class GetStoreProductDetailsForOwnerProductVariation {
  String id;
  double price;
  List<String> imageUrls;
  AnyValue attributes;
  int availableStock;
  GetStoreProductDetailsForOwnerProductVariation.fromJson(dynamic json):
  
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

  GetStoreProductDetailsForOwnerProductVariation({
    required this.id,
    required this.price,
    required this.imageUrls,
    required this.attributes,
    required this.availableStock,
  });
}

class GetStoreProductDetailsForOwnerData {
  GetStoreProductDetailsForOwnerProduct? product;
  GetStoreProductDetailsForOwnerData.fromJson(dynamic json):
  
  product = json['product'] == null ? null : GetStoreProductDetailsForOwnerProduct.fromJson(json['product']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (product != null) {
      json['product'] = product!.toJson();
    }
    return json;
  }

  GetStoreProductDetailsForOwnerData({
    this.product,
  });
}

class GetStoreProductDetailsForOwnerVariables {
  String storeId;
  String productId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetStoreProductDetailsForOwnerVariables.fromJson(Map<String, dynamic> json):
  
  storeId = nativeFromJson<String>(json['storeId']),
  productId = nativeFromJson<String>(json['productId']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['storeId'] = nativeToJson<String>(storeId);
    json['productId'] = nativeToJson<String>(productId);
    return json;
  }

  GetStoreProductDetailsForOwnerVariables({
    required this.storeId,
    required this.productId,
  });
}

