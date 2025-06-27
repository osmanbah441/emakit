part of 'default.dart';

class RemoveCartItemVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  RemoveCartItemVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<RemoveCartItemData> dataDeserializer = (dynamic json)  => RemoveCartItemData.fromJson(jsonDecode(json));
  Serializer<RemoveCartItemVariables> varsSerializer = (RemoveCartItemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<RemoveCartItemData, RemoveCartItemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<RemoveCartItemData, RemoveCartItemVariables> ref() {
    RemoveCartItemVariables vars= RemoveCartItemVariables(id: id,);
    return _dataConnect.mutation("removeCartItem", dataDeserializer, varsSerializer, vars);
  }
}

class RemoveCartItemCartItemDelete {
  String id;
  RemoveCartItemCartItemDelete.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  RemoveCartItemCartItemDelete({
    required this.id,
  });
}

class RemoveCartItemData {
  RemoveCartItemCartItemDelete? cartItem_delete;
  RemoveCartItemData.fromJson(dynamic json):
  cartItem_delete = json['cartItem_delete'] == null ? null : RemoveCartItemCartItemDelete.fromJson(json['cartItem_delete']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (cartItem_delete != null) {
      json['cartItem_delete'] = cartItem_delete!.toJson();
    }
    return json;
  }

  RemoveCartItemData({
    this.cartItem_delete,
  });
}

class RemoveCartItemVariables {
  String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  RemoveCartItemVariables.fromJson(Map<String, dynamic> json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  RemoveCartItemVariables({
    required this.id,
  });
}

