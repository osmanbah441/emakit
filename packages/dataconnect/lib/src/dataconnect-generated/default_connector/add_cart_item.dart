part of 'default.dart';

class AddCartItemVariablesBuilder {
  double unitPrice;
  int quantity;
  String variationId;

  final FirebaseDataConnect _dataConnect;
  AddCartItemVariablesBuilder(this._dataConnect, {required  this.unitPrice,required  this.quantity,required  this.variationId,});
  Deserializer<AddCartItemData> dataDeserializer = (dynamic json)  => AddCartItemData.fromJson(jsonDecode(json));
  Serializer<AddCartItemVariables> varsSerializer = (AddCartItemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AddCartItemData, AddCartItemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AddCartItemData, AddCartItemVariables> ref() {
    AddCartItemVariables vars= AddCartItemVariables(unitPrice: unitPrice,quantity: quantity,variationId: variationId,);
    return _dataConnect.mutation("addCartItem", dataDeserializer, varsSerializer, vars);
  }
}

class AddCartItemCartItemInsert {
  String id;
  AddCartItemCartItemInsert.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AddCartItemCartItemInsert({
    required this.id,
  });
}

class AddCartItemData {
  AddCartItemCartItemInsert cartItem_insert;
  AddCartItemData.fromJson(dynamic json):
  cartItem_insert = AddCartItemCartItemInsert.fromJson(json['cartItem_insert']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['cartItem_insert'] = cartItem_insert.toJson();
    return json;
  }

  AddCartItemData({
    required this.cartItem_insert,
  });
}

class AddCartItemVariables {
  double unitPrice;
  int quantity;
  String variationId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AddCartItemVariables.fromJson(Map<String, dynamic> json):
  unitPrice = nativeFromJson<double>(json['unitPrice']),quantity = nativeFromJson<int>(json['quantity']),variationId = nativeFromJson<String>(json['variationId']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['unitPrice'] = nativeToJson<double>(unitPrice);
    json['quantity'] = nativeToJson<int>(quantity);
    json['variationId'] = nativeToJson<String>(variationId);
    return json;
  }

  AddCartItemVariables({
    required this.unitPrice,
    required this.quantity,
    required this.variationId,
  });
}

