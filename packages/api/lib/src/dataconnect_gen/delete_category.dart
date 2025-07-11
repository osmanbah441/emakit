part of 'default.dart';

class DeleteCategoryVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteCategoryVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteCategoryData> dataDeserializer = (dynamic json)  => DeleteCategoryData.fromJson(jsonDecode(json));
  Serializer<DeleteCategoryVariables> varsSerializer = (DeleteCategoryVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteCategoryData, DeleteCategoryVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteCategoryData, DeleteCategoryVariables> ref() {
    DeleteCategoryVariables vars= DeleteCategoryVariables(id: id,);
    return _dataConnect.mutation("deleteCategory", dataDeserializer, varsSerializer, vars);
  }
}

class DeleteCategoryCategoryDelete {
  String id;
  DeleteCategoryCategoryDelete.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteCategoryCategoryDelete({
    required this.id,
  });
}

class DeleteCategoryData {
  DeleteCategoryCategoryDelete? category_delete;
  DeleteCategoryData.fromJson(dynamic json):
  category_delete = json['category_delete'] == null ? null : DeleteCategoryCategoryDelete.fromJson(json['category_delete']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (category_delete != null) {
      json['category_delete'] = category_delete!.toJson();
    }
    return json;
  }

  DeleteCategoryData({
    this.category_delete,
  });
}

class DeleteCategoryVariables {
  String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteCategoryVariables.fromJson(Map<String, dynamic> json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteCategoryVariables({
    required this.id,
  });
}

