part of 'default.dart';

class CreateCartVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  CreateCartVariablesBuilder(this._dataConnect, );
  Deserializer<CreateCartData> dataDeserializer = (dynamic json)  => CreateCartData.fromJson(jsonDecode(json));
  
  Future<OperationResult<CreateCartData, void>> execute() {
    return ref().execute();
  }

  MutationRef<CreateCartData, void> ref() {
    
    return _dataConnect.mutation("createCart", dataDeserializer, emptySerializer, null);
  }
}

class CreateCartCartInsert {
  String id;
  CreateCartCartInsert.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateCartCartInsert({
    required this.id,
  });
}

class CreateCartData {
  CreateCartCartInsert cart_insert;
  CreateCartData.fromJson(dynamic json):
  cart_insert = CreateCartCartInsert.fromJson(json['cart_insert']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['cart_insert'] = cart_insert.toJson();
    return json;
  }

  CreateCartData({
    required this.cart_insert,
  });
}

