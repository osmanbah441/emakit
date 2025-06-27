part of 'default.dart';

class InsertProductVariablesBuilder {
  String name;
  String description;
  String category;
  String brand;

  final FirebaseDataConnect _dataConnect;
  InsertProductVariablesBuilder(this._dataConnect, {required  this.name,required  this.description,required  this.category,required  this.brand,});
  Deserializer<InsertProductData> dataDeserializer = (dynamic json)  => InsertProductData.fromJson(jsonDecode(json));
  Serializer<InsertProductVariables> varsSerializer = (InsertProductVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertProductData, InsertProductVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertProductData, InsertProductVariables> ref() {
    InsertProductVariables vars= InsertProductVariables(name: name,description: description,category: category,brand: brand,);
    return _dataConnect.mutation("insertProduct", dataDeserializer, varsSerializer, vars);
  }
}

class InsertProductProductInsert {
  String id;
  InsertProductProductInsert.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InsertProductProductInsert({
    required this.id,
  });
}

class InsertProductData {
  InsertProductProductInsert product_insert;
  InsertProductData.fromJson(dynamic json):
  product_insert = InsertProductProductInsert.fromJson(json['product_insert']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['product_insert'] = product_insert.toJson();
    return json;
  }

  InsertProductData({
    required this.product_insert,
  });
}

class InsertProductVariables {
  String name;
  String description;
  String category;
  String brand;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertProductVariables.fromJson(Map<String, dynamic> json):
  name = nativeFromJson<String>(json['name']),description = nativeFromJson<String>(json['description']),category = nativeFromJson<String>(json['category']),brand = nativeFromJson<String>(json['brand']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['description'] = nativeToJson<String>(description);
    json['category'] = nativeToJson<String>(category);
    json['brand'] = nativeToJson<String>(brand);
    return json;
  }

  InsertProductVariables({
    required this.name,
    required this.description,
    required this.category,
    required this.brand,
  });
}

