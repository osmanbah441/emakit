part of 'default.dart';

class ClearCartVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ClearCartVariablesBuilder(this._dataConnect, );
  Deserializer<ClearCartData> dataDeserializer = (dynamic json)  => ClearCartData.fromJson(jsonDecode(json));
  
  Future<OperationResult<ClearCartData, void>> execute() {
    return ref().execute();
  }

  MutationRef<ClearCartData, void> ref() {
    
    return _dataConnect.mutation("clearCart", dataDeserializer, emptySerializer, null);
  }
}

class ClearCartData {
  int cartItem_deleteMany;
  ClearCartData.fromJson(dynamic json):
  cartItem_deleteMany = nativeFromJson<int>(json['cartItem_deleteMany']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['cartItem_deleteMany'] = nativeToJson<int>(cartItem_deleteMany);
    return json;
  }

  ClearCartData({
    required this.cartItem_deleteMany,
  });
}

