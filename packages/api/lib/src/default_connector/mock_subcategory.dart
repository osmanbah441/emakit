part of 'default.dart';

class MockSubcategoryVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  MockSubcategoryVariablesBuilder(this._dataConnect, );
  Deserializer<MockSubcategoryData> dataDeserializer = (dynamic json)  => MockSubcategoryData.fromJson(jsonDecode(json));
  
  Future<OperationResult<MockSubcategoryData, void>> execute() {
    return ref().execute();
  }

  MutationRef<MockSubcategoryData, void> ref() {
    
    return _dataConnect.mutation("mockSubcategory", dataDeserializer, emptySerializer, null);
  }
}

class MockSubcategoryCategoryInsertMany {
  String id;
  MockSubcategoryCategoryInsertMany.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  MockSubcategoryCategoryInsertMany({
    required this.id,
  });
}

class MockSubcategoryData {
  List<MockSubcategoryCategoryInsertMany> category_insertMany;
  MockSubcategoryData.fromJson(dynamic json):
  category_insertMany = (json['category_insertMany'] as List<dynamic>)
        .map((e) => MockSubcategoryCategoryInsertMany.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['category_insertMany'] = category_insertMany.map((e) => e.toJson()).toList();
    return json;
  }

  MockSubcategoryData({
    required this.category_insertMany,
  });
}

