part of 'default.dart';

class CreateNewProductVariationVariablesBuilder {
  String storeId;
  AnyValue attributes;
  String productId;
  List<String> imageUrls;
  double price;
  int availabeStock;

  final FirebaseDataConnect _dataConnect;
  CreateNewProductVariationVariablesBuilder(this._dataConnect, {required  this.storeId,required  this.attributes,required  this.productId,required  this.imageUrls,required  this.price,required  this.availabeStock,});
  Deserializer<CreateNewProductVariationData> dataDeserializer = (dynamic json)  => CreateNewProductVariationData.fromJson(jsonDecode(json));
  Serializer<CreateNewProductVariationVariables> varsSerializer = (CreateNewProductVariationVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateNewProductVariationData, CreateNewProductVariationVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateNewProductVariationData, CreateNewProductVariationVariables> ref() {
    CreateNewProductVariationVariables vars= CreateNewProductVariationVariables(storeId: storeId,attributes: attributes,productId: productId,imageUrls: imageUrls,price: price,availabeStock: availabeStock,);
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
  AnyValue attributes;
  String productId;
  List<String> imageUrls;
  double price;
  int availabeStock;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateNewProductVariationVariables.fromJson(Map<String, dynamic> json):
  storeId = nativeFromJson<String>(json['storeId']),attributes = AnyValue.fromJson(json['attributes']),productId = nativeFromJson<String>(json['productId']),imageUrls = (json['imageUrls'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),price = nativeFromJson<double>(json['price']),availabeStock = nativeFromJson<int>(json['availabeStock']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['storeId'] = nativeToJson<String>(storeId);
    json['attributes'] = attributes.toJson();
    json['productId'] = nativeToJson<String>(productId);
    json['imageUrls'] = imageUrls.map((e) => nativeToJson<String>(e)).toList();
    json['price'] = nativeToJson<double>(price);
    json['availabeStock'] = nativeToJson<int>(availabeStock);
    return json;
  }

  CreateNewProductVariationVariables({
    required this.storeId,
    required this.attributes,
    required this.productId,
    required this.imageUrls,
    required this.price,
    required this.availabeStock,
  });
}

