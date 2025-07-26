part of 'default.dart';

class CreateCartItemVariablesBuilder {
  String productVariationId;
  String cartId;

  final FirebaseDataConnect _dataConnect;
  CreateCartItemVariablesBuilder(this._dataConnect, {required  this.productVariationId,required  this.cartId,});
  Deserializer<CreateCartItemData> dataDeserializer = (dynamic json)  => CreateCartItemData.fromJson(jsonDecode(json));
  Serializer<CreateCartItemVariables> varsSerializer = (CreateCartItemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateCartItemData, CreateCartItemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateCartItemData, CreateCartItemVariables> ref() {
    CreateCartItemVariables vars= CreateCartItemVariables(productVariationId: productVariationId,cartId: cartId,);
    return _dataConnect.mutation("createCartItem", dataDeserializer, varsSerializer, vars);
  }
}

class CreateCartItemCartItemInsert {
  String id;
  CreateCartItemCartItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateCartItemCartItemInsert({
    required this.id,
  });
}

class CreateCartItemData {
  CreateCartItemCartItemInsert cartItem_insert;
  CreateCartItemData.fromJson(dynamic json):
  
  cartItem_insert = CreateCartItemCartItemInsert.fromJson(json['cartItem_insert']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['cartItem_insert'] = cartItem_insert.toJson();
    return json;
  }

  CreateCartItemData({
    required this.cartItem_insert,
  });
}

class CreateCartItemVariables {
  String productVariationId;
  String cartId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateCartItemVariables.fromJson(Map<String, dynamic> json):
  
  productVariationId = nativeFromJson<String>(json['productVariationId']),
  cartId = nativeFromJson<String>(json['cartId']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['productVariationId'] = nativeToJson<String>(productVariationId);
    json['cartId'] = nativeToJson<String>(cartId);
    return json;
  }

  CreateCartItemVariables({
    required this.productVariationId,
    required this.cartId,
  });
}

