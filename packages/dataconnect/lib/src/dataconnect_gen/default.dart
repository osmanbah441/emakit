library default_connector;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'dart:convert';

part 'mock.dart';

part 'create_new_category.dart';

part 'set_category_attributes.dart';

part 'delete_category.dart';

part 'create_new_product.dart';

part 'create_newproduct_variation.dart';

part 'create_new_user.dart';

part 'apply_for_store.dart';

part 'update_display_name.dart';

part 'approve_store.dart';

part 'create_cart_item.dart';

part 'get_user_store.dart';

part 'get_all_pending_approval_stores.dart';

part 'get_all_active_stores.dart';

part 'get_all_suspended_stores.dart';

part 'get_user_cart.dart';

part 'get_all_products.dart';

part 'get_product_by_id.dart';

part 'get_product_for_store_owner.dart';

part 'get_store_product_details_for_owner.dart';

part 'get_all_parent_categories.dart';

part 'get_category_by_id.dart';

part 'get_children_categories.dart';







class DefaultConnector {
  
  
  MockVariablesBuilder mock () {
    return MockVariablesBuilder(dataConnect, );
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
  
  
  CreateNewProductVariablesBuilder createNewProduct ({required String name, required String description, required String category, required dynamic specs, required String storeId, required dynamic attributes, required List<String> imageUrls, required double price, required int availableStock, }) {
    return CreateNewProductVariablesBuilder(dataConnect, name: name,description: description,category: category,specs: specs,storeId: storeId,attributes: attributes,imageUrls: imageUrls,price: price,availableStock: availableStock,);
  }
  
  
  CreateNewproductVariationVariablesBuilder createNewproductVariation ({required String productId, required String storeId, required dynamic attributes, required List<String> imageUrls, required double price, required int availableStock, }) {
    return CreateNewproductVariationVariablesBuilder(dataConnect, productId: productId,storeId: storeId,attributes: attributes,imageUrls: imageUrls,price: price,availableStock: availableStock,);
  }
  
  
  CreateNewUserVariablesBuilder createNewUser () {
    return CreateNewUserVariablesBuilder(dataConnect, );
  }
  
  
  ApplyForStoreVariablesBuilder applyForStore ({required String name, required String phoneNumber, }) {
    return ApplyForStoreVariablesBuilder(dataConnect, name: name,phoneNumber: phoneNumber,);
  }
  
  
  UpdateDisplayNameVariablesBuilder updateDisplayName ({required String displayName, }) {
    return UpdateDisplayNameVariablesBuilder(dataConnect, displayName: displayName,);
  }
  
  
  ApproveStoreVariablesBuilder approveStore ({required String storeId, }) {
    return ApproveStoreVariablesBuilder(dataConnect, storeId: storeId,);
  }
  
  
  CreateCartItemVariablesBuilder createCartItem ({required String productVariationId, required String cartId, }) {
    return CreateCartItemVariablesBuilder(dataConnect, productVariationId: productVariationId,cartId: cartId,);
  }
  
  
  GetUserStoreVariablesBuilder getUserStore () {
    return GetUserStoreVariablesBuilder(dataConnect, );
  }
  
  
  GetAllPendingApprovalStoresVariablesBuilder getAllPendingApprovalStores () {
    return GetAllPendingApprovalStoresVariablesBuilder(dataConnect, );
  }
  
  
  GetAllActiveStoresVariablesBuilder getAllActiveStores () {
    return GetAllActiveStoresVariablesBuilder(dataConnect, );
  }
  
  
  GetAllSuspendedStoresVariablesBuilder getAllSuspendedStores () {
    return GetAllSuspendedStoresVariablesBuilder(dataConnect, );
  }
  
  
  GetUserCartVariablesBuilder getUserCart () {
    return GetUserCartVariablesBuilder(dataConnect, );
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
  
  
  GetStoreProductDetailsForOwnerVariablesBuilder getStoreProductDetailsForOwner ({required String storeId, required String productId, }) {
    return GetStoreProductDetailsForOwnerVariablesBuilder(dataConnect, storeId: storeId,productId: productId,);
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
    'sl-baz-service',
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

