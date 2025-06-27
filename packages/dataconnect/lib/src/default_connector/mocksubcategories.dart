part of 'default.dart';

class MocksubcategoriesVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  MocksubcategoriesVariablesBuilder(this._dataConnect, );
  Deserializer<MocksubcategoriesData> dataDeserializer = (dynamic json)  => MocksubcategoriesData.fromJson(jsonDecode(json));
  
  Future<OperationResult<MocksubcategoriesData, void>> execute() {
    return ref().execute();
  }

  MutationRef<MocksubcategoriesData, void> ref() {
    
    return _dataConnect.mutation("mocksubcategories", dataDeserializer, emptySerializer, null);
  }
}

class MocksubcategoriesCategoryInsertMany {
  String id;
  MocksubcategoriesCategoryInsertMany.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  MocksubcategoriesCategoryInsertMany({
    required this.id,
  });
}

class MocksubcategoriesData {
  List<MocksubcategoriesCategoryInsertMany> category_insertMany;
  MocksubcategoriesData.fromJson(dynamic json):
  category_insertMany = (json['category_insertMany'] as List<dynamic>)
        .map((e) => MocksubcategoriesCategoryInsertMany.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['category_insertMany'] = category_insertMany.map((e) => e.toJson()).toList();
    return json;
  }

  MocksubcategoriesData({
    required this.category_insertMany,
  });
}

