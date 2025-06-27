part of 'default.dart';

class ListProductsVariablesBuilder {
  Optional<String> _categoryId = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  ListProductsVariablesBuilder categoryId(String? t) {
   _categoryId.value = t;
   return this;
  }

  ListProductsVariablesBuilder(this._dataConnect, );
  Deserializer<ListProductsData> dataDeserializer = (dynamic json)  => ListProductsData.fromJson(jsonDecode(json));
  Serializer<ListProductsVariables> varsSerializer = (ListProductsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListProductsData, ListProductsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListProductsData, ListProductsVariables> ref() {
    ListProductsVariables vars= ListProductsVariables(categoryId: _categoryId,);
    return _dataConnect.query("listProducts", dataDeserializer, varsSerializer, vars);
  }
}

class ListProductsProducts {
  String id;
  String name;
  String description;
  String categoryId;
  AnyValue specifications;
  List<ListProductsProductsVariations> variations;
  ListProductsProducts.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),name = nativeFromJson<String>(json['name']),description = nativeFromJson<String>(json['description']),categoryId = nativeFromJson<String>(json['categoryId']),specifications = AnyValue.fromJson(json['specifications']),variations = (json['variations'] as List<dynamic>)
        .map((e) => ListProductsProductsVariations.fromJson(e))
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

  ListProductsProducts({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.specifications,
    required this.variations,
  });
}

class ListProductsProductsVariations {
  String id;
  double price;
  int stockQuantity;
  AnyValue attributes;
  List<String> imageUrls;
  ListProductsProductsVariations.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),price = nativeFromJson<double>(json['price']),stockQuantity = nativeFromJson<int>(json['stockQuantity']),attributes = AnyValue.fromJson(json['attributes']),imageUrls = (json['imageUrls'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['price'] = nativeToJson<double>(price);
    json['stockQuantity'] = nativeToJson<int>(stockQuantity);
    json['attributes'] = attributes.toJson();
    json['imageUrls'] = imageUrls.map((e) => nativeToJson<String>(e)).toList();
    return json;
  }

  ListProductsProductsVariations({
    required this.id,
    required this.price,
    required this.stockQuantity,
    required this.attributes,
    required this.imageUrls,
  });
}

class ListProductsData {
  List<ListProductsProducts> products;
  ListProductsData.fromJson(dynamic json):
  products = (json['products'] as List<dynamic>)
        .map((e) => ListProductsProducts.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['products'] = products.map((e) => e.toJson()).toList();
    return json;
  }

  ListProductsData({
    required this.products,
  });
}

class ListProductsVariables {
  late Optional<String>categoryId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListProductsVariables.fromJson(Map<String, dynamic> json) {
  
    categoryId = Optional.optional(nativeFromJson, nativeToJson);
    categoryId.value = json['categoryId'] == null ? null : nativeFromJson<String>(json['categoryId']);
  
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if(categoryId.state == OptionalState.set) {
      json['categoryId'] = categoryId.toJson();
    }
    return json;
  }

  ListProductsVariables({
    required this.categoryId,
  });
}

