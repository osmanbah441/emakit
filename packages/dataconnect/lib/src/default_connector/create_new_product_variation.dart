part of 'default.dart';

class CreateNewProductVariationVariablesBuilder {
  String storeId;
  String productId;
  AnyValue attributes;
  List<String> imageUrls;
  double price;
  int stockQuantity;

  final FirebaseDataConnect _dataConnect;
  CreateNewProductVariationVariablesBuilder(this._dataConnect, {required  this.storeId,required  this.productId,required  this.attributes,required  this.imageUrls,required  this.price,required  this.stockQuantity,});
  Deserializer<CreateNewProductVariationData> dataDeserializer = (dynamic json)  => CreateNewProductVariationData.fromJson(jsonDecode(json));
  Serializer<CreateNewProductVariationVariables> varsSerializer = (CreateNewProductVariationVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateNewProductVariationData, CreateNewProductVariationVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateNewProductVariationData, CreateNewProductVariationVariables> ref() {
    CreateNewProductVariationVariables vars= CreateNewProductVariationVariables(storeId: storeId,productId: productId,attributes: attributes,imageUrls: imageUrls,price: price,stockQuantity: stockQuantity,);
    return _dataConnect.mutation("createNewProductVariation", dataDeserializer, varsSerializer, vars);
  }
}

class CreateNewProductVariationProductVariationInsert {
  String id;
  CreateNewProductVariationProductVariationInsert.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateNewProductVariationProductVariationInsert({
    required this.id,
  });
}

class CreateNewProductVariationData {
  CreateNewProductVariationProductVariationInsert productVariation_insert;
  CreateNewProductVariationData.fromJson(dynamic json):
  productVariation_insert = CreateNewProductVariationProductVariationInsert.fromJson(json['productVariation_insert']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['productVariation_insert'] = productVariation_insert.toJson();
    return json;
  }

  CreateNewProductVariationData({
    required this.productVariation_insert,
  });
}

class CreateNewProductVariationVariables {
  String storeId;
  String productId;
  AnyValue attributes;
  List<String> imageUrls;
  double price;
  int stockQuantity;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateNewProductVariationVariables.fromJson(Map<String, dynamic> json):
  storeId = nativeFromJson<String>(json['storeId']),productId = nativeFromJson<String>(json['productId']),attributes = AnyValue.fromJson(json['attributes']),imageUrls = (json['imageUrls'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),price = nativeFromJson<double>(json['price']),stockQuantity = nativeFromJson<int>(json['stockQuantity']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['storeId'] = nativeToJson<String>(storeId);
    json['productId'] = nativeToJson<String>(productId);
    json['attributes'] = attributes.toJson();
    json['imageUrls'] = imageUrls.map((e) => nativeToJson<String>(e)).toList();
    json['price'] = nativeToJson<double>(price);
    json['stockQuantity'] = nativeToJson<int>(stockQuantity);
    return json;
  }

  CreateNewProductVariationVariables({
    required this.storeId,
    required this.productId,
    required this.attributes,
    required this.imageUrls,
    required this.price,
    required this.stockQuantity,
  });
}

