part of 'default.dart';

class GetUserCartVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetUserCartVariablesBuilder(this._dataConnect, );
  Deserializer<GetUserCartData> dataDeserializer = (dynamic json)  => GetUserCartData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetUserCartData, void>> execute() {
    return ref().execute();
  }

  QueryRef<GetUserCartData, void> ref() {
    
    return _dataConnect.query("getUserCart", dataDeserializer, emptySerializer, null);
  }
}

class GetUserCartCart {
  String id;
  List<GetUserCartCartItems> items;
  GetUserCartCart.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  items = (json['items'] as List<dynamic>)
        .map((e) => GetUserCartCartItems.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['items'] = items.map((e) => e.toJson()).toList();
    return json;
  }

  GetUserCartCart({
    required this.id,
    required this.items,
  });
}

class GetUserCartCartItems {
  String id;
  GetUserCartCartItemsProductVariation productVariation;
  int quantity;
  GetUserCartCartItems.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  productVariation = GetUserCartCartItemsProductVariation.fromJson(json['productVariation']),
  quantity = nativeFromJson<int>(json['quantity']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['productVariation'] = productVariation.toJson();
    json['quantity'] = nativeToJson<int>(quantity);
    return json;
  }

  GetUserCartCartItems({
    required this.id,
    required this.productVariation,
    required this.quantity,
  });
}

class GetUserCartCartItemsProductVariation {
  String id;
  GetUserCartCartItemsProductVariationProduct product;
  double price;
  List<String> imageUrls;
  AnyValue attributes;
  int availableStock;
  GetUserCartCartItemsProductVariation.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  product = GetUserCartCartItemsProductVariationProduct.fromJson(json['product']),
  price = nativeFromJson<double>(json['price']),
  imageUrls = (json['imageUrls'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),
  attributes = AnyValue.fromJson(json['attributes']),
  availableStock = nativeFromJson<int>(json['availableStock']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['product'] = product.toJson();
    json['price'] = nativeToJson<double>(price);
    json['imageUrls'] = imageUrls.map((e) => nativeToJson<String>(e)).toList();
    json['attributes'] = attributes.toJson();
    json['availableStock'] = nativeToJson<int>(availableStock);
    return json;
  }

  GetUserCartCartItemsProductVariation({
    required this.id,
    required this.product,
    required this.price,
    required this.imageUrls,
    required this.attributes,
    required this.availableStock,
  });
}

class GetUserCartCartItemsProductVariationProduct {
  String id;
  String name;
  GetUserCartCartItemsProductVariationProduct.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  GetUserCartCartItemsProductVariationProduct({
    required this.id,
    required this.name,
  });
}

class GetUserCartData {
  GetUserCartCart? cart;
  GetUserCartData.fromJson(dynamic json):
  
  cart = json['cart'] == null ? null : GetUserCartCart.fromJson(json['cart']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (cart != null) {
      json['cart'] = cart!.toJson();
    }
    return json;
  }

  GetUserCartData({
    this.cart,
  });
}

