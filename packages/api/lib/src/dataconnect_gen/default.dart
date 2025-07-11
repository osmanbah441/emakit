library default_connector;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'dart:convert';

part 'create_new_category.dart';

part 'set_category_attributes.dart';

part 'delete_category.dart';

part 'get_all_categories.dart';

part 'get_all_parent_categories.dart';

part 'get_category_by_id.dart';

part 'get_children_categories.dart';







class DefaultConnector {
  
  
  CreateNewCategoryVariablesBuilder createNewCategory ({required String name, required String description, required String imageUrl, }) {
    return CreateNewCategoryVariablesBuilder(dataConnect, name: name,description: description,imageUrl: imageUrl,);
  }
  
  
  SetCategoryAttributesVariablesBuilder setCategoryAttributes ({required String id, }) {
    return SetCategoryAttributesVariablesBuilder(dataConnect, id: id,);
  }
  
  
  DeleteCategoryVariablesBuilder deleteCategory ({required String id, }) {
    return DeleteCategoryVariablesBuilder(dataConnect, id: id,);
  }
  
  
  GetAllCategoriesVariablesBuilder getAllCategories () {
    return GetAllCategoriesVariablesBuilder(dataConnect, );
  }
  
  
  GetAllParentCategoriesVariablesBuilder getAllParentCategories () {
    return GetAllParentCategoriesVariablesBuilder(dataConnect, );
  }
  
  
  GetCategoryByIdVariablesBuilder getCategoryById ({required String id, }) {
    return GetCategoryByIdVariablesBuilder(dataConnect, id: id,);
  }
  
  
  GetChildrenCategoriesVariablesBuilder getChildrenCategories ({required String id, }) {
    return GetChildrenCategoriesVariablesBuilder(dataConnect, id: id,);
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'us-central1',
    'default',
    'e-makit-1-service',
  );

  DefaultConnector({required this.dataConnect});
  static DefaultConnector get instance {
    return DefaultConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}

