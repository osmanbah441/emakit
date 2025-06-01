part of 'default.dart';

class MockCategoriesVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  MockCategoriesVariablesBuilder(this._dataConnect, );
  Deserializer<MockCategoriesData> dataDeserializer = (dynamic json)  => MockCategoriesData.fromJson(jsonDecode(json));
  
  Future<OperationResult<MockCategoriesData, void>> execute() {
    return ref().execute();
  }

  MutationRef<MockCategoriesData, void> ref() {
    
    return _dataConnect.mutation("mockCategories", dataDeserializer, emptySerializer, null);
  }
}

class MockCategoriesCategoryInsertMany {
  String id;
  MockCategoriesCategoryInsertMany.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  MockCategoriesCategoryInsertMany({
    required this.id,
  });
}

class MockCategoriesData {
  List<MockCategoriesCategoryInsertMany> category_insertMany;
  MockCategoriesData.fromJson(dynamic json):
  category_insertMany = (json['category_insertMany'] as List<dynamic>)
        .map((e) => MockCategoriesCategoryInsertMany.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['category_insertMany'] = category_insertMany.map((e) => e.toJson()).toList();
    return json;
  }

  MockCategoriesData({
    required this.category_insertMany,
  });
}

