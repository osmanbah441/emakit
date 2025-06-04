part of 'default.dart';

class DecrementCartItemQuantityVariablesBuilder {
  String cartItemId;
  int quantity;

  final FirebaseDataConnect _dataConnect;
  DecrementCartItemQuantityVariablesBuilder(this._dataConnect, {required  this.cartItemId,required  this.quantity,});
  Deserializer<DecrementCartItemQuantityData> dataDeserializer = (dynamic json)  => DecrementCartItemQuantityData.fromJson(jsonDecode(json));
  Serializer<DecrementCartItemQuantityVariables> varsSerializer = (DecrementCartItemQuantityVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DecrementCartItemQuantityData, DecrementCartItemQuantityVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DecrementCartItemQuantityData, DecrementCartItemQuantityVariables> ref() {
    DecrementCartItemQuantityVariables vars= DecrementCartItemQuantityVariables(cartItemId: cartItemId,quantity: quantity,);
    return _dataConnect.mutation("decrementCartItemQuantity", dataDeserializer, varsSerializer, vars);
  }
}

class DecrementCartItemQuantityCartItemUpdate {
  String id;
  DecrementCartItemQuantityCartItemUpdate.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DecrementCartItemQuantityCartItemUpdate({
    required this.id,
  });
}

class DecrementCartItemQuantityData {
  DecrementCartItemQuantityCartItemUpdate? cartItem_update;
  DecrementCartItemQuantityData.fromJson(dynamic json):
  cartItem_update = json['cartItem_update'] == null ? null : DecrementCartItemQuantityCartItemUpdate.fromJson(json['cartItem_update']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (cartItem_update != null) {
      json['cartItem_update'] = cartItem_update!.toJson();
    }
    return json;
  }

  DecrementCartItemQuantityData({
    this.cartItem_update,
  });
}

class DecrementCartItemQuantityVariables {
  String cartItemId;
  int quantity;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DecrementCartItemQuantityVariables.fromJson(Map<String, dynamic> json):
  cartItemId = nativeFromJson<String>(json['cartItemId']),quantity = nativeFromJson<int>(json['quantity']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['cartItemId'] = nativeToJson<String>(cartItemId);
    json['quantity'] = nativeToJson<int>(quantity);
    return json;
  }

  DecrementCartItemQuantityVariables({
    required this.cartItemId,
    required this.quantity,
  });
}

