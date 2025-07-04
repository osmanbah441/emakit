library default_connector;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'dart:convert';

part 'get_all_user.dart';

part 'get_all_store.dart';

part 'get_store_by_id.dart';

part 'fetch_cart.dart';

part 'add_cart_item.dart';

part 'create_cart.dart';

part 'increment_cart_item_quantity.dart';

part 'decrement_cart_item_quantity.dart';

part 'remove_cart_item.dart';

part 'clear_cart.dart';

part 'create_new_category.dart';

part 'update_category_attributes.dart';

part 'get_category_by_id.dart';

part 'get_all_categories.dart';

part 'create_new_product.dart';

part 'create_new_product_variation.dart';

part 'get_all_products.dart';

part 'get_product_by_id.dart';

part 'create_new_user.dart';

part 'create_store_for_user.dart';







class DefaultConnector {
  
  
  GetAllUserVariablesBuilder getAllUser () {
    return GetAllUserVariablesBuilder(dataConnect, );
  }
  
  
  GetAllStoreVariablesBuilder getAllStore () {
    return GetAllStoreVariablesBuilder(dataConnect, );
  }
  
  
  GetStoreByIdVariablesBuilder getStoreById ({required String id, }) {
    return GetStoreByIdVariablesBuilder(dataConnect, id: id,);
  }
  
  
  FetchCartVariablesBuilder fetchCart () {
    return FetchCartVariablesBuilder(dataConnect, );
  }
  
  
  AddCartItemVariablesBuilder addCartItem ({required double unitPrice, required int quantity, required String variationId, }) {
    return AddCartItemVariablesBuilder(dataConnect, unitPrice: unitPrice,quantity: quantity,variationId: variationId,);
  }
  
  
  CreateCartVariablesBuilder createCart () {
    return CreateCartVariablesBuilder(dataConnect, );
  }
  
  
  IncrementCartItemQuantityVariablesBuilder incrementCartItemQuantity ({required String cartItemId, required int quantity, }) {
    return IncrementCartItemQuantityVariablesBuilder(dataConnect, cartItemId: cartItemId,quantity: quantity,);
  }
  
  
  DecrementCartItemQuantityVariablesBuilder decrementCartItemQuantity ({required String cartItemId, required int quantity, }) {
    return DecrementCartItemQuantityVariablesBuilder(dataConnect, cartItemId: cartItemId,quantity: quantity,);
  }
  
  
  RemoveCartItemVariablesBuilder removeCartItem ({required String id, }) {
    return RemoveCartItemVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ClearCartVariablesBuilder clearCart () {
    return ClearCartVariablesBuilder(dataConnect, );
  }
  
  
  CreateNewCategoryVariablesBuilder createNewCategory ({required String name, required String description, required String imageUrl, }) {
    return CreateNewCategoryVariablesBuilder(dataConnect, name: name,description: description,imageUrl: imageUrl,);
  }
  
  
  UpdateCategoryAttributesVariablesBuilder updateCategoryAttributes ({required String id, }) {
    return UpdateCategoryAttributesVariablesBuilder(dataConnect, id: id,);
  }
  
  
  GetCategoryByIdVariablesBuilder getCategoryById ({required String id, }) {
    return GetCategoryByIdVariablesBuilder(dataConnect, id: id,);
  }
  
  
  GetAllCategoriesVariablesBuilder getAllCategories () {
    return GetAllCategoriesVariablesBuilder(dataConnect, );
  }
  
  
  CreateNewProductVariablesBuilder createNewProduct ({required String name, required String description, required String category, required String mainImage, required dynamic specs, }) {
    return CreateNewProductVariablesBuilder(dataConnect, name: name,description: description,category: category,mainImage: mainImage,specs: specs,);
  }
  
  
  CreateNewProductVariationVariablesBuilder createNewProductVariation ({required String storeId, required String productId, required dynamic attributes, required List<String> imageUrls, required double price, required int stockQuantity, }) {
    return CreateNewProductVariationVariablesBuilder(dataConnect, storeId: storeId,productId: productId,attributes: attributes,imageUrls: imageUrls,price: price,stockQuantity: stockQuantity,);
  }
  
  
  GetAllProductsVariablesBuilder getAllProducts () {
    return GetAllProductsVariablesBuilder(dataConnect, );
  }
  
  
  GetProductByIdVariablesBuilder getProductById ({required String id, }) {
    return GetProductByIdVariablesBuilder(dataConnect, id: id,);
  }
  
  
  CreateNewUserVariablesBuilder createNewUser ({required String displayName, required String phoneNumber, }) {
    return CreateNewUserVariablesBuilder(dataConnect, displayName: displayName,phoneNumber: phoneNumber,);
  }
  
  
  CreateStoreForUserVariablesBuilder createStoreForUser ({required String ownerId, required String name, required String description, required String logoUrl, required String phoneNumber, }) {
    return CreateStoreForUserVariablesBuilder(dataConnect, ownerId: ownerId,name: name,description: description,logoUrl: logoUrl,phoneNumber: phoneNumber,);
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'us-central1',
    'default',
    'e-makit-service',
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

