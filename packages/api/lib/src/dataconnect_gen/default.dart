library default_connector;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'dart:convert';

part 'get_user.dart';

part 'get_all_users.dart';

part 'get_all_addresses.dart';

part 'create_new_category.dart';

part 'set_category_attributes.dart';

part 'delete_category.dart';

part 'mock_parent_category.dart';

part 'mock_children_category.dart';

part 'get_all_categories.dart';

part 'get_all_parent_categories.dart';

part 'get_category_by_id.dart';

part 'get_children_categories.dart';

part 'create_new_product.dart';

part 'create_new_product_variation.dart';

part 'get_all_products.dart';

part 'get_product_by_id.dart';

part 'get_product_for_store_owner.dart';

part 'create_store.dart';

part 'get_all_stores.dart';

part 'create_new_user.dart';

part 'create_new_address_for_user.dart';







class DefaultConnector {
  
  
  GetUserVariablesBuilder getUser ({required String id, }) {
    return GetUserVariablesBuilder(dataConnect, id: id,);
  }
  
  
  GetAllUsersVariablesBuilder getAllUsers () {
    return GetAllUsersVariablesBuilder(dataConnect, );
  }
  
  
  GetAllAddressesVariablesBuilder getAllAddresses () {
    return GetAllAddressesVariablesBuilder(dataConnect, );
  }
  
  
  CreateNewCategoryVariablesBuilder createNewCategory ({required String name, required String description, required String imageUrl, }) {
    return CreateNewCategoryVariablesBuilder(dataConnect, name: name,description: description,imageUrl: imageUrl,);
  }
  
  
  SetCategoryAttributesVariablesBuilder setCategoryAttributes ({required String id, }) {
    return SetCategoryAttributesVariablesBuilder(dataConnect, id: id,);
  }
  
  
  DeleteCategoryVariablesBuilder deleteCategory ({required String id, }) {
    return DeleteCategoryVariablesBuilder(dataConnect, id: id,);
  }
  
  
  MockParentCategoryVariablesBuilder mockParentCategory () {
    return MockParentCategoryVariablesBuilder(dataConnect, );
  }
  
  
  MockChildrenCategoryVariablesBuilder mockChildrenCategory () {
    return MockChildrenCategoryVariablesBuilder(dataConnect, );
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
  
  
  CreateNewProductVariablesBuilder createNewProduct ({required String name, required String description, required String category, required String mainImage, required dynamic specs, }) {
    return CreateNewProductVariablesBuilder(dataConnect, name: name,description: description,category: category,mainImage: mainImage,specs: specs,);
  }
  
  
  CreateNewProductVariationVariablesBuilder createNewProductVariation ({required String storeId, required dynamic attributes, required String productId, required List<String> imageUrls, required double price, required int availabeStock, }) {
    return CreateNewProductVariationVariablesBuilder(dataConnect, storeId: storeId,attributes: attributes,productId: productId,imageUrls: imageUrls,price: price,availabeStock: availabeStock,);
  }
  
  
  GetAllProductsVariablesBuilder getAllProducts () {
    return GetAllProductsVariablesBuilder(dataConnect, );
  }
  
  
  GetProductByIdVariablesBuilder getProductById ({required String id, }) {
    return GetProductByIdVariablesBuilder(dataConnect, id: id,);
  }
  
  
  GetProductForStoreOwnerVariablesBuilder getProductForStoreOwner ({required String storeId, }) {
    return GetProductForStoreOwnerVariablesBuilder(dataConnect, storeId: storeId,);
  }
  
  
  CreateStoreVariablesBuilder createStore ({required String name, required String description, required String ownerId, required String addressId, required String logoUrl, required String phoneNumber, }) {
    return CreateStoreVariablesBuilder(dataConnect, name: name,description: description,ownerId: ownerId,addressId: addressId,logoUrl: logoUrl,phoneNumber: phoneNumber,);
  }
  
  
  GetAllStoresVariablesBuilder getAllStores () {
    return GetAllStoresVariablesBuilder(dataConnect, );
  }
  
  
  CreateNewUserVariablesBuilder createNewUser () {
    return CreateNewUserVariablesBuilder(dataConnect, );
  }
  
  
  CreateNewAddressForUserVariablesBuilder createNewAddressForUser ({required String label, }) {
    return CreateNewAddressForUserVariablesBuilder(dataConnect, label: label,);
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

