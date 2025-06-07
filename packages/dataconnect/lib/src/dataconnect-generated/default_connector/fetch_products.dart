part of 'default.dart';

class FetchProductsVariablesBuilder {
  Optional<String> _categoryId = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _mainCategoryId = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  FetchProductsVariablesBuilder categoryId(String? t) {
   _categoryId.value = t;
   return this;
  }
  FetchProductsVariablesBuilder mainCategoryId(String? t) {
   _mainCategoryId.value = t;
   return this;
  }

  FetchProductsVariablesBuilder(this._dataConnect, );
  Deserializer<FetchProductsData> dataDeserializer = (dynamic json)  => FetchProductsData.fromJson(jsonDecode(json));
  Serializer<FetchProductsVariables> varsSerializer = (FetchProductsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<FetchProductsData, FetchProductsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<FetchProductsData, FetchProductsVariables> ref() {
    FetchProductsVariables vars= FetchProductsVariables(categoryId: _categoryId,mainCategoryId: _mainCategoryId,);
    return _dataConnect.query("fetchProducts", dataDeserializer, varsSerializer, vars);
  }
}

class FetchProductsProducts {
  String id;
  String name;
  String description;
  String categoryId;
  AnyValue specifications;
  FetchProductsProductsMainCategory mainCategory;
  List<FetchProductsProductsVariations> variations;
  FetchProductsProducts.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),name = nativeFromJson<String>(json['name']),description = nativeFromJson<String>(json['description']),categoryId = nativeFromJson<String>(json['categoryId']),specifications = AnyValue.fromJson(json['specifications']),mainCategory = FetchProductsProductsMainCategory.fromJson(json['mainCategory']),variations = (json['variations'] as List<dynamic>)
        .map((e) => FetchProductsProductsVariations.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['description'] = nativeToJson<String>(description);
    json['categoryId'] = nativeToJson<String>(categoryId);
    json['specifications'] = specifications.toJson();
    json['mainCategory'] = mainCategory.toJson();
    json['variations'] = variations.map((e) => e.toJson()).toList();
    return json;
  }

  FetchProductsProducts({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.specifications,
    required this.mainCategory,
    required this.variations,
  });
}

class FetchProductsProductsMainCategory {
  String name;
  FetchProductsProductsMainCategory.fromJson(dynamic json):
  name = nativeFromJson<String>(json['name']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  FetchProductsProductsMainCategory({
    required this.name,
  });
}

class FetchProductsProductsVariations {
  String id;
  double price;
  int stockQuantity;
  AnyValue attributes;
  List<String> imageUrls;
  FetchProductsProductsVariations.fromJson(dynamic json):
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

  FetchProductsProductsVariations({
    required this.id,
    required this.price,
    required this.stockQuantity,
    required this.attributes,
    required this.imageUrls,
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

class FetchProductsVariables {
  late Optional<String>categoryId;
  late Optional<String>mainCategoryId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  FetchProductsVariables.fromJson(Map<String, dynamic> json) {
  
    categoryId = Optional.optional(nativeFromJson, nativeToJson);
    categoryId.value = json['categoryId'] == null ? null : nativeFromJson<String>(json['categoryId']);
  
    mainCategoryId = Optional.optional(nativeFromJson, nativeToJson);
    mainCategoryId.value = json['mainCategoryId'] == null ? null : nativeFromJson<String>(json['mainCategoryId']);
  
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if(categoryId.state == OptionalState.set) {
      json['categoryId'] = categoryId.toJson();
    }
    if(mainCategoryId.state == OptionalState.set) {
      json['mainCategoryId'] = mainCategoryId.toJson();
    }
    return json;
  }

  FetchProductsVariables({
    required this.categoryId,
    required this.mainCategoryId,
  });
}

