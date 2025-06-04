part of 'default.dart';

class MockProductsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  MockProductsVariablesBuilder(this._dataConnect, );
  Deserializer<MockProductsData> dataDeserializer = (dynamic json)  => MockProductsData.fromJson(jsonDecode(json));
  
  Future<OperationResult<MockProductsData, void>> execute() {
    return ref().execute();
  }

  MutationRef<MockProductsData, void> ref() {
    
    return _dataConnect.mutation("mockProducts", dataDeserializer, emptySerializer, null);
  }
}

class MockProductsProductInsertMany {
  String id;
  MockProductsProductInsertMany.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  MockProductsProductInsertMany({
    required this.id,
  });
}

class MockProductsData {
  List<MockProductsProductInsertMany> product_insertMany;
  MockProductsData.fromJson(dynamic json):
  product_insertMany = (json['product_insertMany'] as List<dynamic>)
        .map((e) => MockProductsProductInsertMany.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['product_insertMany'] = product_insertMany.map((e) => e.toJson()).toList();
    return json;
  }

  MockProductsData({
    required this.product_insertMany,
  });
}

