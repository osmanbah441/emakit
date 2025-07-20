part of 'default.dart';

class MockChildrenCategoryVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  MockChildrenCategoryVariablesBuilder(this._dataConnect, );
  Deserializer<MockChildrenCategoryData> dataDeserializer = (dynamic json)  => MockChildrenCategoryData.fromJson(jsonDecode(json));
  
  Future<OperationResult<MockChildrenCategoryData, void>> execute() {
    return ref().execute();
  }

  MutationRef<MockChildrenCategoryData, void> ref() {
    
    return _dataConnect.mutation("mockChildrenCategory", dataDeserializer, emptySerializer, null);
  }
}

class MockChildrenCategoryCategoryInsertMany {
  String id;
  MockChildrenCategoryCategoryInsertMany.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  MockChildrenCategoryCategoryInsertMany({
    required this.id,
  });
}

class MockChildrenCategoryData {
  List<MockChildrenCategoryCategoryInsertMany> category_insertMany;
  MockChildrenCategoryData.fromJson(dynamic json):
  category_insertMany = (json['category_insertMany'] as List<dynamic>)
        .map((e) => MockChildrenCategoryCategoryInsertMany.fromJson(e))
        .toList();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['category_insertMany'] = category_insertMany.map((e) => e.toJson()).toList();
    return json;
  }

  MockChildrenCategoryData({
    required this.category_insertMany,
  });
}

