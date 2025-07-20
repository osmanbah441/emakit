part of 'default.dart';

class CreateNewProductVariablesBuilder {
  String name;
  String description;
  String category;
  String mainImage;
  AnyValue specs;

  final FirebaseDataConnect _dataConnect;
  CreateNewProductVariablesBuilder(this._dataConnect, {required  this.name,required  this.description,required  this.category,required  this.mainImage,required  this.specs,});
  Deserializer<CreateNewProductData> dataDeserializer = (dynamic json)  => CreateNewProductData.fromJson(jsonDecode(json));
  Serializer<CreateNewProductVariables> varsSerializer = (CreateNewProductVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateNewProductData, CreateNewProductVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateNewProductData, CreateNewProductVariables> ref() {
    CreateNewProductVariables vars= CreateNewProductVariables(name: name,description: description,category: category,mainImage: mainImage,specs: specs,);
    return _dataConnect.mutation("createNewProduct", dataDeserializer, varsSerializer, vars);
  }
}

class CreateNewProductListingInsert {
  String id;
  CreateNewProductListingInsert.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateNewProductListingInsert({
    required this.id,
  });
}

class CreateNewProductData {
  CreateNewProductListingInsert listing_insert;
  CreateNewProductData.fromJson(dynamic json):
  listing_insert = CreateNewProductListingInsert.fromJson(json['listing_insert']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['listing_insert'] = listing_insert.toJson();
    return json;
  }

  CreateNewProductData({
    required this.listing_insert,
  });
}

class CreateNewProductVariables {
  String name;
  String description;
  String category;
  String mainImage;
  AnyValue specs;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateNewProductVariables.fromJson(Map<String, dynamic> json):
  name = nativeFromJson<String>(json['name']),description = nativeFromJson<String>(json['description']),category = nativeFromJson<String>(json['category']),mainImage = nativeFromJson<String>(json['mainImage']),specs = AnyValue.fromJson(json['specs']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['description'] = nativeToJson<String>(description);
    json['category'] = nativeToJson<String>(category);
    json['mainImage'] = nativeToJson<String>(mainImage);
    json['specs'] = specs.toJson();
    return json;
  }

  CreateNewProductVariables({
    required this.name,
    required this.description,
    required this.category,
    required this.mainImage,
    required this.specs,
  });
}

