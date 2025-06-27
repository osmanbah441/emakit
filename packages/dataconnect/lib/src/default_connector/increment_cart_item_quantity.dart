part of 'default.dart';

class IncrementCartItemQuantityVariablesBuilder {
  String cartItemId;
  int quantity;

  final FirebaseDataConnect _dataConnect;
  IncrementCartItemQuantityVariablesBuilder(this._dataConnect, {required  this.cartItemId,required  this.quantity,});
  Deserializer<IncrementCartItemQuantityData> dataDeserializer = (dynamic json)  => IncrementCartItemQuantityData.fromJson(jsonDecode(json));
  Serializer<IncrementCartItemQuantityVariables> varsSerializer = (IncrementCartItemQuantityVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<IncrementCartItemQuantityData, IncrementCartItemQuantityVariables>> execute() {
    return ref().execute();
  }

  MutationRef<IncrementCartItemQuantityData, IncrementCartItemQuantityVariables> ref() {
    IncrementCartItemQuantityVariables vars= IncrementCartItemQuantityVariables(cartItemId: cartItemId,quantity: quantity,);
    return _dataConnect.mutation("incrementCartItemQuantity", dataDeserializer, varsSerializer, vars);
  }
}

class IncrementCartItemQuantityCartItemUpdate {
  String id;
  IncrementCartItemQuantityCartItemUpdate.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  IncrementCartItemQuantityCartItemUpdate({
    required this.id,
  });
}

class IncrementCartItemQuantityData {
  IncrementCartItemQuantityCartItemUpdate? cartItem_update;
  IncrementCartItemQuantityData.fromJson(dynamic json):
  cartItem_update = json['cartItem_update'] == null ? null : IncrementCartItemQuantityCartItemUpdate.fromJson(json['cartItem_update']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (cartItem_update != null) {
      json['cartItem_update'] = cartItem_update!.toJson();
    }
    return json;
  }

  IncrementCartItemQuantityData({
    this.cartItem_update,
  });
}

class IncrementCartItemQuantityVariables {
  String cartItemId;
  int quantity;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  IncrementCartItemQuantityVariables.fromJson(Map<String, dynamic> json):
  cartItemId = nativeFromJson<String>(json['cartItemId']),quantity = nativeFromJson<int>(json['quantity']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['cartItemId'] = nativeToJson<String>(cartItemId);
    json['quantity'] = nativeToJson<int>(quantity);
    return json;
  }

  IncrementCartItemQuantityVariables({
    required this.cartItemId,
    required this.quantity,
  });
}

