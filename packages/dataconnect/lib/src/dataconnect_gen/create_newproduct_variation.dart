part of 'default.dart';

class CreateNewproductVariationVariablesBuilder {
  String productId;
  String storeId;
  AnyValue attributes;
  List<String> imageUrls;
  double price;
  int availableStock;

  final FirebaseDataConnect _dataConnect;
  CreateNewproductVariationVariablesBuilder(this._dataConnect, {required  this.productId,required  this.storeId,required  this.attributes,required  this.imageUrls,required  this.price,required  this.availableStock,});
  Deserializer<CreateNewproductVariationData> dataDeserializer = (dynamic json)  => CreateNewproductVariationData.fromJson(jsonDecode(json));
  Serializer<CreateNewproductVariationVariables> varsSerializer = (CreateNewproductVariationVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateNewproductVariationData, CreateNewproductVariationVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateNewproductVariationData, CreateNewproductVariationVariables> ref() {
    CreateNewproductVariationVariables vars= CreateNewproductVariationVariables(productId: productId,storeId: storeId,attributes: attributes,imageUrls: imageUrls,price: price,availableStock: availableStock,);
    return _dataConnect.mutation("createNewproductVariation", dataDeserializer, varsSerializer, vars);
  }
}

class CreateNewproductVariationProductVariationInsert {
  String id;
  CreateNewproductVariationProductVariationInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateNewproductVariationProductVariationInsert({
    required this.id,
  });
}

class CreateNewproductVariationData {
  CreateNewproductVariationProductVariationInsert productVariation_insert;
  CreateNewproductVariationData.fromJson(dynamic json):
  
  productVariation_insert = CreateNewproductVariationProductVariationInsert.fromJson(json['productVariation_insert']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['productVariation_insert'] = productVariation_insert.toJson();
    return json;
  }

  CreateNewproductVariationData({
    required this.productVariation_insert,
  });
}

class CreateNewproductVariationVariables {
  String productId;
  String storeId;
  AnyValue attributes;
  List<String> imageUrls;
  double price;
  int availableStock;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateNewproductVariationVariables.fromJson(Map<String, dynamic> json):
  
  productId = nativeFromJson<String>(json['productId']),
  storeId = nativeFromJson<String>(json['storeId']),
  attributes = AnyValue.fromJson(json['attributes']),
  imageUrls = (json['imageUrls'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),
  price = nativeFromJson<double>(json['price']),
  availableStock = nativeFromJson<int>(json['availableStock']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['productId'] = nativeToJson<String>(productId);
    json['storeId'] = nativeToJson<String>(storeId);
    json['attributes'] = attributes.toJson();
    json['imageUrls'] = imageUrls.map((e) => nativeToJson<String>(e)).toList();
    json['price'] = nativeToJson<double>(price);
    json['availableStock'] = nativeToJson<int>(availableStock);
    return json;
  }

  CreateNewproductVariationVariables({
    required this.productId,
    required this.storeId,
    required this.attributes,
    required this.imageUrls,
    required this.price,
    required this.availableStock,
  });
}

