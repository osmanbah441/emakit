part of 'default.dart';

class UpdateCategoryAttributesVariablesBuilder {
  String id;
  Optional<AnyValue> _varition = Optional.optional(AnyValue.fromJson, defaultSerializer);
  Optional<List<String>> _specification = Optional.optional(listDeserializer(nativeFromJson), listSerializer(nativeToJson));

  final FirebaseDataConnect _dataConnect;  UpdateCategoryAttributesVariablesBuilder varition(AnyValue? t) {
   _varition.value = t;
   return this;
  }
  UpdateCategoryAttributesVariablesBuilder specification(List<String>? t) {
   _specification.value = t;
   return this;
  }

  UpdateCategoryAttributesVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<UpdateCategoryAttributesData> dataDeserializer = (dynamic json)  => UpdateCategoryAttributesData.fromJson(jsonDecode(json));
  Serializer<UpdateCategoryAttributesVariables> varsSerializer = (UpdateCategoryAttributesVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateCategoryAttributesData, UpdateCategoryAttributesVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateCategoryAttributesData, UpdateCategoryAttributesVariables> ref() {
    UpdateCategoryAttributesVariables vars= UpdateCategoryAttributesVariables(id: id,varition: _varition,specification: _specification,);
    return _dataConnect.mutation("updateCategoryAttributes", dataDeserializer, varsSerializer, vars);
  }
}

class UpdateCategoryAttributesCategoryUpdate {
  String id;
  UpdateCategoryAttributesCategoryUpdate.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateCategoryAttributesCategoryUpdate({
    required this.id,
  });
}

class UpdateCategoryAttributesData {
  UpdateCategoryAttributesCategoryUpdate? category_update;
  UpdateCategoryAttributesData.fromJson(dynamic json):
  category_update = json['category_update'] == null ? null : UpdateCategoryAttributesCategoryUpdate.fromJson(json['category_update']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (category_update != null) {
      json['category_update'] = category_update!.toJson();
    }
    return json;
  }

  UpdateCategoryAttributesData({
    this.category_update,
  });
}

class UpdateCategoryAttributesVariables {
  String id;
  late Optional<AnyValue>varition;
  late Optional<List<String>>specification;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateCategoryAttributesVariables.fromJson(Map<String, dynamic> json):
  id = nativeFromJson<String>(json['id']) {
  
    varition = Optional.optional(AnyValue.fromJson, defaultSerializer);
    varition.value = json['varition'] == null ? null : AnyValue.fromJson(json['varition']);
  
    specification = Optional.optional(listDeserializer(nativeFromJson), listSerializer(nativeToJson));
    specification.value = json['specification'] == null ? null : (json['specification'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList();
  
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if(varition.state == OptionalState.set) {
      json['varition'] = varition.toJson();
    }
    if(specification.state == OptionalState.set) {
      json['specification'] = specification.toJson();
    }
    return json;
  }

  UpdateCategoryAttributesVariables({
    required this.id,
    required this.varition,
    required this.specification,
  });
}

