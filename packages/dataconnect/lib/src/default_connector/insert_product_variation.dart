part of 'default.dart';

class InsertProductVariationVariablesBuilder {
  String productId;
  Optional<AnyValue> _attributes = Optional.optional(AnyValue.fromJson, defaultSerializer);
  List<String> imageUrls;
  double price;
  int stockQuantity;

  final FirebaseDataConnect _dataConnect;  InsertProductVariationVariablesBuilder attributes(AnyValue? t) {
   _attributes.value = t;
   return this;
  }

  InsertProductVariationVariablesBuilder(this._dataConnect, {required  this.productId,required  this.imageUrls,required  this.price,required  this.stockQuantity,});
  Deserializer<InsertProductVariationData> dataDeserializer = (dynamic json)  => InsertProductVariationData.fromJson(jsonDecode(json));
  Serializer<InsertProductVariationVariables> varsSerializer = (InsertProductVariationVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertProductVariationData, InsertProductVariationVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertProductVariationData, InsertProductVariationVariables> ref() {
    InsertProductVariationVariables vars= InsertProductVariationVariables(productId: productId,attributes: _attributes,imageUrls: imageUrls,price: price,stockQuantity: stockQuantity,);
    return _dataConnect.mutation("insertProductVariation", dataDeserializer, varsSerializer, vars);
  }
}

class InsertProductVariationProductVariationInsert {
  String id;
  InsertProductVariationProductVariationInsert.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InsertProductVariationProductVariationInsert({
    required this.id,
  });
}

class InsertProductVariationData {
  InsertProductVariationProductVariationInsert productVariation_insert;
  InsertProductVariationData.fromJson(dynamic json):
  productVariation_insert = InsertProductVariationProductVariationInsert.fromJson(json['productVariation_insert']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['productVariation_insert'] = productVariation_insert.toJson();
    return json;
  }

  InsertProductVariationData({
    required this.productVariation_insert,
  });
}

class InsertProductVariationVariables {
  String productId;
  late Optional<AnyValue>attributes;
  List<String> imageUrls;
  double price;
  int stockQuantity;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertProductVariationVariables.fromJson(Map<String, dynamic> json):
  productId = nativeFromJson<String>(json['productId']),imageUrls = (json['imageUrls'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),price = nativeFromJson<double>(json['price']),stockQuantity = nativeFromJson<int>(json['stockQuantity']) {
  
    attributes = Optional.optional(AnyValue.fromJson, defaultSerializer);
    attributes.value = json['attributes'] == null ? null : AnyValue.fromJson(json['attributes']);
  
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['productId'] = nativeToJson<String>(productId);
    if(attributes.state == OptionalState.set) {
      json['attributes'] = attributes.toJson();
    }
    json['imageUrls'] = imageUrls.map((e) => nativeToJson<String>(e)).toList();
    json['price'] = nativeToJson<double>(price);
    json['stockQuantity'] = nativeToJson<int>(stockQuantity);
    return json;
  }

  InsertProductVariationVariables({
    required this.productId,
    required this.attributes,
    required this.imageUrls,
    required this.price,
    required this.stockQuantity,
  });
}

