part of 'default.dart';

class FetchProductsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  FetchProductsVariablesBuilder(this._dataConnect, );
  Deserializer<FetchProductsData> dataDeserializer = (dynamic json)  => FetchProductsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<FetchProductsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<FetchProductsData, void> ref() {
    
    return _dataConnect.query("fetchProducts", dataDeserializer, emptySerializer, null);
  }
}

class FetchProductsProducts {
  String id;
  String name;
  String description;
  String categoryId;
  AnyValue specifications;
  List<FetchProductsProductsVariations> variations;
  FetchProductsProducts.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),name = nativeFromJson<String>(json['name']),description = nativeFromJson<String>(json['description']),categoryId = nativeFromJson<String>(json['categoryId']),specifications = AnyValue.fromJson(json['specifications']),variations = (json['variations'] as List<dynamic>)
        .map((e) => FetchProductsProductsVariations.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['description'] = nativeToJson<String>(description);
    json['categoryId'] = nativeToJson<String>(categoryId);
    json['specifications'] = specifications.toJson();
    json['variations'] = variations.map((e) => e.toJson()).toList();
    return json;
  }

  FetchProductsProducts({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.specifications,
    required this.variations,
  });
}

class FetchProductsProductsVariations {
  String id;
  List<String> imageUrls;
  double price;
  AnyValue attributes;
  int stockQuantity;
  FetchProductsProductsVariations.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),imageUrls = (json['imageUrls'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),price = nativeFromJson<double>(json['price']),attributes = AnyValue.fromJson(json['attributes']),stockQuantity = nativeFromJson<int>(json['stockQuantity']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['imageUrls'] = imageUrls.map((e) => nativeToJson<String>(e)).toList();
    json['price'] = nativeToJson<double>(price);
    json['attributes'] = attributes.toJson();
    json['stockQuantity'] = nativeToJson<int>(stockQuantity);
    return json;
  }

  FetchProductsProductsVariations({
    required this.id,
    required this.imageUrls,
    required this.price,
    required this.attributes,
    required this.stockQuantity,
  });
}

class FetchProductsData {
  List<FetchProductsProducts> products;
  FetchProductsData.fromJson(dynamic json):
  products = (json['products'] as List<dynamic>)
        .map((e) => FetchProductsProducts.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['products'] = products.map((e) => e.toJson()).toList();
    return json;
  }

  FetchProductsData({
    required this.products,
  });
}

