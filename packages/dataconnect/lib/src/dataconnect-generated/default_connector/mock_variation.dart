part of 'default.dart';

class MockVariationVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  MockVariationVariablesBuilder(this._dataConnect, );
  Deserializer<MockVariationData> dataDeserializer = (dynamic json)  => MockVariationData.fromJson(jsonDecode(json));
  
  Future<OperationResult<MockVariationData, void>> execute() {
    return ref().execute();
  }

  MutationRef<MockVariationData, void> ref() {
    
    return _dataConnect.mutation("mockVariation", dataDeserializer, emptySerializer, null);
  }
}

class MockVariationProductVariationInsertMany {
  String id;
  MockVariationProductVariationInsertMany.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  MockVariationProductVariationInsertMany({
    required this.id,
  });
}

class MockVariationData {
  List<MockVariationProductVariationInsertMany> productVariation_insertMany;
  MockVariationData.fromJson(dynamic json):
  productVariation_insertMany = (json['productVariation_insertMany'] as List<dynamic>)
        .map((e) => MockVariationProductVariationInsertMany.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['productVariation_insertMany'] = productVariation_insertMany.map((e) => e.toJson()).toList();
    return json;
  }

  MockVariationData({
    required this.productVariation_insertMany,
  });
}

