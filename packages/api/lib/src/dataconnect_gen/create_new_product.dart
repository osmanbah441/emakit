part of 'default.dart';

class CreateNewProductVariablesBuilder {
  String name;
  String description;
  String category;
  AnyValue specs;
  String storeId;
  AnyValue attributes;
  List<String> imageUrls;
  double price;
  int availableStock;
  String embeddingText;

  final FirebaseDataConnect _dataConnect;
  CreateNewProductVariablesBuilder(this._dataConnect, {required  this.name,required  this.description,required  this.category,required  this.specs,required  this.storeId,required  this.attributes,required  this.imageUrls,required  this.price,required  this.availableStock,required  this.embeddingText,});
  Deserializer<CreateNewProductData> dataDeserializer = (dynamic json)  => CreateNewProductData.fromJson(jsonDecode(json));
  Serializer<CreateNewProductVariables> varsSerializer = (CreateNewProductVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateNewProductData, CreateNewProductVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateNewProductData, CreateNewProductVariables> ref() {
    CreateNewProductVariables vars= CreateNewProductVariables(name: name,description: description,category: category,specs: specs,storeId: storeId,attributes: attributes,imageUrls: imageUrls,price: price,availableStock: availableStock,embeddingText: embeddingText,);
    return _dataConnect.mutation("createNewProduct", dataDeserializer, varsSerializer, vars);
  }
}

class CreateNewProductProductInsert {
  String id;
  CreateNewProductProductInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateNewProductProductInsert({
    required this.id,
  });
}

class CreateNewProductProductVariationInsert {
  String id;
  CreateNewProductProductVariationInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateNewProductProductVariationInsert({
    required this.id,
  });
}

class CreateNewProductData {
  CreateNewProductProductInsert product_insert;
  CreateNewProductProductVariationInsert productVariation_insert;
  CreateNewProductData.fromJson(dynamic json):
  
  product_insert = CreateNewProductProductInsert.fromJson(json['product_insert']),
  productVariation_insert = CreateNewProductProductVariationInsert.fromJson(json['productVariation_insert']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['product_insert'] = product_insert.toJson();
    json['productVariation_insert'] = productVariation_insert.toJson();
    return json;
  }

  CreateNewProductData({
    required this.product_insert,
    required this.productVariation_insert,
  });
}

class CreateNewProductVariables {
  String name;
  String description;
  String category;
  AnyValue specs;
  String storeId;
  AnyValue attributes;
  List<String> imageUrls;
  double price;
  int availableStock;
  String embeddingText;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateNewProductVariables.fromJson(Map<String, dynamic> json):
  
  name = nativeFromJson<String>(json['name']),
  description = nativeFromJson<String>(json['description']),
  category = nativeFromJson<String>(json['category']),
  specs = AnyValue.fromJson(json['specs']),
  storeId = nativeFromJson<String>(json['storeId']),
  attributes = AnyValue.fromJson(json['attributes']),
  imageUrls = (json['imageUrls'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),
  price = nativeFromJson<double>(json['price']),
  availableStock = nativeFromJson<int>(json['availableStock']),
  embeddingText = nativeFromJson<String>(json['embeddingText']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['description'] = nativeToJson<String>(description);
    json['category'] = nativeToJson<String>(category);
    json['specs'] = specs.toJson();
    json['storeId'] = nativeToJson<String>(storeId);
    json['attributes'] = attributes.toJson();
    json['imageUrls'] = imageUrls.map((e) => nativeToJson<String>(e)).toList();
    json['price'] = nativeToJson<double>(price);
    json['availableStock'] = nativeToJson<int>(availableStock);
    json['embeddingText'] = nativeToJson<String>(embeddingText);
    return json;
  }

  CreateNewProductVariables({
    required this.name,
    required this.description,
    required this.category,
    required this.specs,
    required this.storeId,
    required this.attributes,
    required this.imageUrls,
    required this.price,
    required this.availableStock,
    required this.embeddingText,
  });
}

