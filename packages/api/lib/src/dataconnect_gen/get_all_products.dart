part of 'default.dart';

class GetAllProductsVariablesBuilder {
  Optional<String> _category = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  GetAllProductsVariablesBuilder category(String? t) {
   _category.value = t;
   return this;
  }

  GetAllProductsVariablesBuilder(this._dataConnect, );
  Deserializer<GetAllProductsData> dataDeserializer = (dynamic json)  => GetAllProductsData.fromJson(jsonDecode(json));
  Serializer<GetAllProductsVariables> varsSerializer = (GetAllProductsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetAllProductsData, GetAllProductsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetAllProductsData, GetAllProductsVariables> ref() {
    GetAllProductsVariables vars= GetAllProductsVariables(category: _category,);
    return _dataConnect.query("getAllProducts", dataDeserializer, varsSerializer, vars);
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
  GetAllProductsProductsVariationsStore store;
  GetAllProductsProductsVariations.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  price = nativeFromJson<double>(json['price']),
  imageUrls = (json['imageUrls'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),
  attributes = AnyValue.fromJson(json['attributes']),
  availableStock = nativeFromJson<int>(json['availableStock']),
  store = GetAllProductsProductsVariationsStore.fromJson(json['store']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['price'] = nativeToJson<double>(price);
    json['imageUrls'] = imageUrls.map((e) => nativeToJson<String>(e)).toList();
    json['attributes'] = attributes.toJson();
    json['availableStock'] = nativeToJson<int>(availableStock);
    json['store'] = store.toJson();
    return json;
  }

  GetAllProductsProductsVariations({
    required this.id,
    required this.price,
    required this.imageUrls,
    required this.attributes,
    required this.availableStock,
    required this.store,
  });
}

class GetAllProductsProductsVariationsStore {
  String id;
  String name;
  GetAllProductsProductsVariationsStore.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  GetAllProductsProductsVariationsStore({
    required this.id,
    required this.name,
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

class GetAllProductsVariables {
  late Optional<String>category;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetAllProductsVariables.fromJson(Map<String, dynamic> json) {
  
  
    category = Optional.optional(nativeFromJson, nativeToJson);
    category.value = json['category'] == null ? null : nativeFromJson<String>(json['category']);
  
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if(category.state == OptionalState.set) {
      json['category'] = category.toJson();
    }
    return json;
  }

  GetAllProductsVariables({
    required this.category,
  });
}

