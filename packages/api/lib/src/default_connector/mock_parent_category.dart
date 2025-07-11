part of 'default.dart';

class MockParentCategoryVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  MockParentCategoryVariablesBuilder(this._dataConnect, );
  Deserializer<MockParentCategoryData> dataDeserializer = (dynamic json)  => MockParentCategoryData.fromJson(jsonDecode(json));
  
  Future<OperationResult<MockParentCategoryData, void>> execute() {
    return ref().execute();
  }

  MutationRef<MockParentCategoryData, void> ref() {
    
    return _dataConnect.mutation("mockParentCategory", dataDeserializer, emptySerializer, null);
  }
}

class MockParentCategoryCategoryInsertMany {
  String id;
  MockParentCategoryCategoryInsertMany.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  MockParentCategoryCategoryInsertMany({
    required this.id,
  });
}

class MockParentCategoryData {
  List<MockParentCategoryCategoryInsertMany> category_insertMany;
  MockParentCategoryData.fromJson(dynamic json):
  category_insertMany = (json['category_insertMany'] as List<dynamic>)
        .map((e) => MockParentCategoryCategoryInsertMany.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['category_insertMany'] = category_insertMany.map((e) => e.toJson()).toList();
    return json;
  }

  MockParentCategoryData({
    required this.category_insertMany,
  });
}

