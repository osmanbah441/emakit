part of 'default.dart';

class FetchCartVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  FetchCartVariablesBuilder(this._dataConnect, );
  Deserializer<FetchCartData> dataDeserializer = (dynamic json)  => FetchCartData.fromJson(jsonDecode(json));
  
  Future<QueryResult<FetchCartData, void>> execute() {
    return ref().execute();
  }

  QueryRef<FetchCartData, void> ref() {
    
    return _dataConnect.query("fetchCart", dataDeserializer, emptySerializer, null);
  }
}

class FetchCartCart {
  String id;
  List<FetchCartCartItems> items;
  FetchCartCart.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),items = (json['items'] as List<dynamic>)
        .map((e) => FetchCartCartItems.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['items'] = items.map((e) => e.toJson()).toList();
    return json;
  }

  FetchCartCart({
    required this.id,
    required this.items,
  });
}

class FetchCartCartItems {
  String id;
  int quantity;
  FetchCartCartItemsVariation variation;
  FetchCartCartItems.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),quantity = nativeFromJson<int>(json['quantity']),variation = FetchCartCartItemsVariation.fromJson(json['variation']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['quantity'] = nativeToJson<int>(quantity);
    json['variation'] = variation.toJson();
    return json;
  }

  FetchCartCartItems({
    required this.id,
    required this.quantity,
    required this.variation,
  });
}

class FetchCartCartItemsVariation {
  FetchCartCartItemsVariationProduct product;
  String id;
  double price;
  int stockQuantity;
  AnyValue attributes;
  List<String> imageUrls;
  FetchCartCartItemsVariation.fromJson(dynamic json):
  product = FetchCartCartItemsVariationProduct.fromJson(json['product']),id = nativeFromJson<String>(json['id']),price = nativeFromJson<double>(json['price']),stockQuantity = nativeFromJson<int>(json['stockQuantity']),attributes = AnyValue.fromJson(json['attributes']),imageUrls = (json['imageUrls'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['product'] = product.toJson();
    json['id'] = nativeToJson<String>(id);
    json['price'] = nativeToJson<double>(price);
    json['stockQuantity'] = nativeToJson<int>(stockQuantity);
    json['attributes'] = attributes.toJson();
    json['imageUrls'] = imageUrls.map((e) => nativeToJson<String>(e)).toList();
    return json;
  }

  FetchCartCartItemsVariation({
    required this.product,
    required this.id,
    required this.price,
    required this.stockQuantity,
    required this.attributes,
    required this.imageUrls,
  });
}

class FetchCartCartItemsVariationProduct {
  String name;
  FetchCartCartItemsVariationProduct.fromJson(dynamic json):
  name = nativeFromJson<String>(json['name']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  FetchCartCartItemsVariationProduct({
    required this.name,
  });
}

class FetchCartData {
  FetchCartCart? cart;
  FetchCartData.fromJson(dynamic json):
  cart = json['cart'] == null ? null : FetchCartCart.fromJson(json['cart']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (cart != null) {
      json['cart'] = cart!.toJson();
    }
    return json;
  }

  FetchCartData({
    this.cart,
  });
}

