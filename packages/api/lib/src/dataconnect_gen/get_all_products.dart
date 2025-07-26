part of 'default.dart';

class GetAllProductsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetAllProductsVariablesBuilder(this._dataConnect, );
  Deserializer<GetAllProductsData> dataDeserializer = (dynamic json)  => GetAllProductsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetAllProductsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<GetAllProductsData, void> ref() {
    
    return _dataConnect.query("getAllProducts", dataDeserializer, emptySerializer, null);
  }
}

class GetAllProductsProducts {
  String id;
  String name;
  String description;
  AnyValue specifications;
  List<GetAllProductsProductsVariations> variations;
  GetAllProductsProducts.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  description = nativeFromJson<String>(json['description']),
  specifications = AnyValue.fromJson(json['specifications']),
  variations = (json['variations'] as List<dynamic>)
        .map((e) => GetAllProductsProductsVariations.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['description'] = nativeToJson<String>(description);
    json['specifications'] = specifications.toJson();
    json['variations'] = variations.map((e) => e.toJson()).toList();
    return json;
  }

  GetAllProductsProducts({
    required this.id,
    required this.name,
    required this.description,
    required this.specifications,
    required this.variations,
  });
}

class GetAllProductsProductsVariations {
  String id;
  double price;
  List<String> imageUrls;
  AnyValue attributes;
  int availableStock;
  GetAllProductsProductsVariations.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  price = nativeFromJson<double>(json['price']),
  imageUrls = (json['imageUrls'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),
  attributes = AnyValue.fromJson(json['attributes']),
  availableStock = nativeFromJson<int>(json['availableStock']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['price'] = nativeToJson<double>(price);
    json['imageUrls'] = imageUrls.map((e) => nativeToJson<String>(e)).toList();
    json['attributes'] = attributes.toJson();
    json['availableStock'] = nativeToJson<int>(availableStock);
    return json;
  }

  GetAllProductsProductsVariations({
    required this.id,
    required this.price,
    required this.imageUrls,
    required this.attributes,
    required this.availableStock,
  });
}

class GetAllProductsData {
  List<GetAllProductsProducts> products;
  GetAllProductsData.fromJson(dynamic json):
  
  products = (json['products'] as List<dynamic>)
        .map((e) => GetAllProductsProducts.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['products'] = products.map((e) => e.toJson()).toList();
    return json;
  }

  GetAllProductsData({
    required this.products,
  });
}

