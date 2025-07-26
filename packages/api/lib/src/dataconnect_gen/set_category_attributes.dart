part of 'default.dart';

class SetCategoryAttributesVariablesBuilder {
  String id;
  Optional<List<String>> _specificationAttributes = Optional.optional(listDeserializer(nativeFromJson), listSerializer(nativeToJson));
  Optional<AnyValue> _variationAttributes = Optional.optional(AnyValue.fromJson, defaultSerializer);

  final FirebaseDataConnect _dataConnect;  SetCategoryAttributesVariablesBuilder specificationAttributes(List<String>? t) {
   _specificationAttributes.value = t;
   return this;
  }
  SetCategoryAttributesVariablesBuilder variationAttributes(AnyValue? t) {
   _variationAttributes.value = t;
   return this;
  }

  SetCategoryAttributesVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<SetCategoryAttributesData> dataDeserializer = (dynamic json)  => SetCategoryAttributesData.fromJson(jsonDecode(json));
  Serializer<SetCategoryAttributesVariables> varsSerializer = (SetCategoryAttributesVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<SetCategoryAttributesData, SetCategoryAttributesVariables>> execute() {
    return ref().execute();
  }

  MutationRef<SetCategoryAttributesData, SetCategoryAttributesVariables> ref() {
    SetCategoryAttributesVariables vars= SetCategoryAttributesVariables(id: id,specificationAttributes: _specificationAttributes,variationAttributes: _variationAttributes,);
    return _dataConnect.mutation("setCategoryAttributes", dataDeserializer, varsSerializer, vars);
  }
}

class SetCategoryAttributesCategoryUpdate {
  String id;
  SetCategoryAttributesCategoryUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SetCategoryAttributesCategoryUpdate({
    required this.id,
  });
}

class SetCategoryAttributesData {
  SetCategoryAttributesCategoryUpdate? category_update;
  SetCategoryAttributesData.fromJson(dynamic json):
  
  category_update = json['category_update'] == null ? null : SetCategoryAttributesCategoryUpdate.fromJson(json['category_update']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (category_update != null) {
      json['category_update'] = category_update!.toJson();
    }
    return json;
  }

  SetCategoryAttributesData({
    this.category_update,
  });
}

class SetCategoryAttributesVariables {
  String id;
  late Optional<List<String>>specificationAttributes;
  late Optional<AnyValue>variationAttributes;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  SetCategoryAttributesVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']) {
  
  
  
    specificationAttributes = Optional.optional(listDeserializer(nativeFromJson), listSerializer(nativeToJson));
    specificationAttributes.value = json['specificationAttributes'] == null ? null : (json['specificationAttributes'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList();
  
  
    variationAttributes = Optional.optional(AnyValue.fromJson, defaultSerializer);
    variationAttributes.value = json['variationAttributes'] == null ? null : AnyValue.fromJson(json['variationAttributes']);
  
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if(specificationAttributes.state == OptionalState.set) {
      json['specificationAttributes'] = specificationAttributes.toJson();
    }
    if(variationAttributes.state == OptionalState.set) {
      json['variationAttributes'] = variationAttributes.toJson();
    }
    return json;
  }

  SetCategoryAttributesVariables({
    required this.id,
    required this.specificationAttributes,
    required this.variationAttributes,
  });
}

