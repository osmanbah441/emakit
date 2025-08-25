part of 'default.dart';

class MockVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  MockVariablesBuilder(this._dataConnect, );
  Deserializer<MockData> dataDeserializer = (dynamic json)  => MockData.fromJson(jsonDecode(json));
  
  Future<OperationResult<MockData, void>> execute() {
    return ref().execute();
  }

  MutationRef<MockData, void> ref() {
    
    return _dataConnect.mutation("mock", dataDeserializer, emptySerializer, null);
  }
}

class MockProductVariationInsertMany {
  String id;
  MockProductVariationInsertMany.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  MockProductVariationInsertMany({
    required this.id,
  });
}

class MockData {
  List<MockProductVariationInsertMany> productVariation_insertMany;
  MockData.fromJson(dynamic json):
  
  productVariation_insertMany = (json['productVariation_insertMany'] as List<dynamic>)
        .map((e) => MockProductVariationInsertMany.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['productVariation_insertMany'] = productVariation_insertMany.map((e) => e.toJson()).toList();
    return json;
  }

  MockData({
    required this.productVariation_insertMany,
  });
}

