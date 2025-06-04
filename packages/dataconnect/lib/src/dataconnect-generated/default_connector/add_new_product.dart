part of 'default.dart';

class AddNewProductVariablesBuilder {
  String name;
  String description;
  String category;
  String brand;

  final FirebaseDataConnect _dataConnect;
  AddNewProductVariablesBuilder(this._dataConnect, {required  this.name,required  this.description,required  this.category,required  this.brand,});
  Deserializer<AddNewProductData> dataDeserializer = (dynamic json)  => AddNewProductData.fromJson(jsonDecode(json));
  Serializer<AddNewProductVariables> varsSerializer = (AddNewProductVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AddNewProductData, AddNewProductVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AddNewProductData, AddNewProductVariables> ref() {
    AddNewProductVariables vars= AddNewProductVariables(name: name,description: description,category: category,brand: brand,);
    return _dataConnect.mutation("addNewProduct", dataDeserializer, varsSerializer, vars);
  }
}

class AddNewProductProductInsert {
  String id;
  AddNewProductProductInsert.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AddNewProductProductInsert({
    required this.id,
  });
}

class AddNewProductData {
  AddNewProductProductInsert product_insert;
  AddNewProductData.fromJson(dynamic json):
  product_insert = AddNewProductProductInsert.fromJson(json['product_insert']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['product_insert'] = product_insert.toJson();
    return json;
  }

  AddNewProductData({
    required this.product_insert,
  });
}

class AddNewProductVariables {
  String name;
  String description;
  String category;
  String brand;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AddNewProductVariables.fromJson(Map<String, dynamic> json):
  name = nativeFromJson<String>(json['name']),description = nativeFromJson<String>(json['description']),category = nativeFromJson<String>(json['category']),brand = nativeFromJson<String>(json['brand']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['description'] = nativeToJson<String>(description);
    json['category'] = nativeToJson<String>(category);
    json['brand'] = nativeToJson<String>(brand);
    return json;
  }

  AddNewProductVariables({
    required this.name,
    required this.description,
    required this.category,
    required this.brand,
  });
}

