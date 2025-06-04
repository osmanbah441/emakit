part of 'default.dart';

class MockSubcategoriesVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  MockSubcategoriesVariablesBuilder(this._dataConnect, );
  Deserializer<MockSubcategoriesData> dataDeserializer = (dynamic json)  => MockSubcategoriesData.fromJson(jsonDecode(json));
  
  Future<OperationResult<MockSubcategoriesData, void>> execute() {
    return ref().execute();
  }

  MutationRef<MockSubcategoriesData, void> ref() {
    
    return _dataConnect.mutation("mockSubcategories", dataDeserializer, emptySerializer, null);
  }
}

class MockSubcategoriesCategoryInsertMany {
  String id;
  MockSubcategoriesCategoryInsertMany.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  MockSubcategoriesCategoryInsertMany({
    required this.id,
  });
}

class MockSubcategoriesData {
  List<MockSubcategoriesCategoryInsertMany> category_insertMany;
  MockSubcategoriesData.fromJson(dynamic json):
  category_insertMany = (json['category_insertMany'] as List<dynamic>)
        .map((e) => MockSubcategoriesCategoryInsertMany.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['category_insertMany'] = category_insertMany.map((e) => e.toJson()).toList();
    return json;
  }

  MockSubcategoriesData({
    required this.category_insertMany,
  });
}

