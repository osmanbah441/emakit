part of 'default.dart';

class AddNewProductVariationVariablesBuilder {
  String productId;
  Optional<AnyValue> _attributes = Optional.optional(AnyValue.fromJson, defaultSerializer);
  List<String> imageUrls;
  double price;
  int stockQuantity;

  final FirebaseDataConnect _dataConnect;  AddNewProductVariationVariablesBuilder attributes(AnyValue? t) {
   _attributes.value = t;
   return this;
  }

  AddNewProductVariationVariablesBuilder(this._dataConnect, {required  this.productId,required  this.imageUrls,required  this.price,required  this.stockQuantity,});
  Deserializer<AddNewProductVariationData> dataDeserializer = (dynamic json)  => AddNewProductVariationData.fromJson(jsonDecode(json));
  Serializer<AddNewProductVariationVariables> varsSerializer = (AddNewProductVariationVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AddNewProductVariationData, AddNewProductVariationVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AddNewProductVariationData, AddNewProductVariationVariables> ref() {
    AddNewProductVariationVariables vars= AddNewProductVariationVariables(productId: productId,attributes: _attributes,imageUrls: imageUrls,price: price,stockQuantity: stockQuantity,);
    return _dataConnect.mutation("addNewProductVariation", dataDeserializer, varsSerializer, vars);
  }
}

class AddNewProductVariationProductVariationInsert {
  String id;
  AddNewProductVariationProductVariationInsert.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AddNewProductVariationProductVariationInsert({
    required this.id,
  });
}

class AddNewProductVariationData {
  AddNewProductVariationProductVariationInsert productVariation_insert;
  AddNewProductVariationData.fromJson(dynamic json):
  productVariation_insert = AddNewProductVariationProductVariationInsert.fromJson(json['productVariation_insert']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['productVariation_insert'] = productVariation_insert.toJson();
    return json;
  }

  AddNewProductVariationData({
    required this.productVariation_insert,
  });
}

class AddNewProductVariationVariables {
  String productId;
  late Optional<AnyValue>attributes;
  List<String> imageUrls;
  double price;
  int stockQuantity;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AddNewProductVariationVariables.fromJson(Map<String, dynamic> json):
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

  AddNewProductVariationVariables({
    required this.productId,
    required this.attributes,
    required this.imageUrls,
    required this.price,
    required this.stockQuantity,
  });
}

