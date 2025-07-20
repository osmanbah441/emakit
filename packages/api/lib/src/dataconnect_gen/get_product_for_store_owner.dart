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

class GetProductForStoreOwnerListings {
  List<GetProductForStoreOwnerListingsProductVariationsOnProduct> productVariations_on_product;
  GetProductForStoreOwnerListings.fromJson(dynamic json):
  productVariations_on_product = (json['productVariations_on_product'] as List<dynamic>)
        .map((e) => GetProductForStoreOwnerListingsProductVariationsOnProduct.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['productVariations_on_product'] = productVariations_on_product.map((e) => e.toJson()).toList();
    return json;
  }

  GetProductForStoreOwnerListings({
    required this.productVariations_on_product,
  });
}

class GetProductForStoreOwnerListingsProductVariationsOnProduct {
  String id;
  double price;
  List<String> imageUrls;
  AnyValue attributes;
  int availabeStock;
  GetProductForStoreOwnerListingsProductVariationsOnProduct.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),price = nativeFromJson<double>(json['price']),imageUrls = (json['imageUrls'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),attributes = AnyValue.fromJson(json['attributes']),availabeStock = nativeFromJson<int>(json['availabeStock']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['price'] = nativeToJson<double>(price);
    json['imageUrls'] = imageUrls.map((e) => nativeToJson<String>(e)).toList();
    json['attributes'] = attributes.toJson();
    json['availabeStock'] = nativeToJson<int>(availabeStock);
    return json;
  }

  GetProductForStoreOwnerListingsProductVariationsOnProduct({
    required this.id,
    required this.price,
    required this.imageUrls,
    required this.attributes,
    required this.availabeStock,
  });
}

class GetProductForStoreOwnerData {
  List<GetProductForStoreOwnerListings> listings;
  GetProductForStoreOwnerData.fromJson(dynamic json):
  listings = (json['listings'] as List<dynamic>)
        .map((e) => GetProductForStoreOwnerListings.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['listings'] = listings.map((e) => e.toJson()).toList();
    return json;
  }

  GetProductForStoreOwnerData({
    required this.listings,
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

