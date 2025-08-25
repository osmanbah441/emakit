part of 'default.dart';

class GetProductForStoreOwnerVariablesBuilder {
  String storeId;

  final FirebaseDataConnect _dataConnect;
  GetProductForStoreOwnerVariablesBuilder(this._dataConnect, {required  this.storeId,});
  Deserializer<GetProductForStoreOwnerData> dataDeserializer = (dynamic json)  => GetProductForStoreOwnerData.fromJson(jsonDecode(json));
  Serializer<GetProductForStoreOwnerVariables> varsSerializer = (GetProductForStoreOwnerVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetProductForStoreOwnerData, GetProductForStoreOwnerVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetProductForStoreOwnerData, GetProductForStoreOwnerVariables> ref() {
    GetProductForStoreOwnerVariables vars= GetProductForStoreOwnerVariables(storeId: storeId,);
    return _dataConnect.query("getProductForStoreOwner", dataDeserializer, varsSerializer, vars);
  }
}

class GetProductForStoreOwnerProducts {
  String id;
  String name;
  String description;
  AnyValue specifications;
  List<GetProductForStoreOwnerProductsProductVariationsOnProduct> productVariations_on_product;
  GetProductForStoreOwnerProducts.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  description = nativeFromJson<String>(json['description']),
  specifications = AnyValue.fromJson(json['specifications']),
  productVariations_on_product = (json['productVariations_on_product'] as List<dynamic>)
        .map((e) => GetProductForStoreOwnerProductsProductVariationsOnProduct.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['description'] = nativeToJson<String>(description);
    json['specifications'] = specifications.toJson();
    json['productVariations_on_product'] = productVariations_on_product.map((e) => e.toJson()).toList();
    return json;
  }

  GetProductForStoreOwnerProducts({
    required this.id,
    required this.name,
    required this.description,
    required this.specifications,
    required this.productVariations_on_product,
  });
}

class GetProductForStoreOwnerProductsProductVariationsOnProduct {
  String id;
  double price;
  List<String> imageUrls;
  AnyValue attributes;
  int availableStock;
  GetProductForStoreOwnerProductsProductVariationsOnProduct.fromJson(dynamic json):
  
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

  GetProductForStoreOwnerProductsProductVariationsOnProduct({
    required this.id,
    required this.price,
    required this.imageUrls,
    required this.attributes,
    required this.availableStock,
  });
}

class GetProductForStoreOwnerData {
  List<GetProductForStoreOwnerProducts> products;
  GetProductForStoreOwnerData.fromJson(dynamic json):
  
  products = (json['products'] as List<dynamic>)
        .map((e) => GetProductForStoreOwnerProducts.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['products'] = products.map((e) => e.toJson()).toList();
    return json;
  }

  GetProductForStoreOwnerData({
    required this.products,
  });
}

class GetProductForStoreOwnerVariables {
  String storeId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetProductForStoreOwnerVariables.fromJson(Map<String, dynamic> json):
  
  storeId = nativeFromJson<String>(json['storeId']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['storeId'] = nativeToJson<String>(storeId);
    return json;
  }

  GetProductForStoreOwnerVariables({
    required this.storeId,
  });
}

