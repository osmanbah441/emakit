library default_connector;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'dart:convert';

part 'add_cart_item.dart';

part 'create_cart.dart';

part 'increment_cart_item_quantity.dart';

part 'decrement_cart_item_quantity.dart';

part 'remove_cart_item.dart';

part 'clear_cart.dart';

part 'fetch_cart.dart';

part 'mock_categories.dart';

part 'mocksubcategories.dart';

part 'mock_products.dart';

part 'add_new_category.dart';

part 'insert_product.dart';

part 'insert_product_variation.dart';

part 'get_product_by_id.dart';

part 'list_products.dart';

part 'fetch_category_by_name.dart';

part 'fetch_categories.dart';

part 'fetch_sub_categories.dart';







class DefaultConnector {
  
  
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
  
  
  FetchCartVariablesBuilder fetchCart () {
    return FetchCartVariablesBuilder(dataConnect, );
  }
  
  
  MockCategoriesVariablesBuilder mockCategories () {
    return MockCategoriesVariablesBuilder(dataConnect, );
  }
  
  
  MocksubcategoriesVariablesBuilder mocksubcategories () {
    return MocksubcategoriesVariablesBuilder(dataConnect, );
  }
  
  
  MockProductsVariablesBuilder mockProducts () {
    return MockProductsVariablesBuilder(dataConnect, );
  }
  
  
  AddNewCategoryVariablesBuilder addNewCategory ({required String name, }) {
    return AddNewCategoryVariablesBuilder(dataConnect, name: name,);
  }
  
  
  InsertProductVariablesBuilder insertProduct ({required String name, required String description, required String category, required String brand, }) {
    return InsertProductVariablesBuilder(dataConnect, name: name,description: description,category: category,brand: brand,);
  }
  
  
  InsertProductVariationVariablesBuilder insertProductVariation ({required String productId, required List<String> imageUrls, required double price, required int stockQuantity, }) {
    return InsertProductVariationVariablesBuilder(dataConnect, productId: productId,imageUrls: imageUrls,price: price,stockQuantity: stockQuantity,);
  }
  
  
  GetProductByIdVariablesBuilder getProductById ({required String id, }) {
    return GetProductByIdVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListProductsVariablesBuilder listProducts () {
    return ListProductsVariablesBuilder(dataConnect, );
  }
  
  
  FetchCategoryByNameVariablesBuilder fetchCategoryByName ({required String name, }) {
    return FetchCategoryByNameVariablesBuilder(dataConnect, name: name,);
  }
  
  
  FetchCategoriesVariablesBuilder fetchCategories () {
    return FetchCategoriesVariablesBuilder(dataConnect, );
  }
  
  
  FetchSubCategoriesVariablesBuilder fetchSubCategories ({required String parentId, }) {
    return FetchSubCategoriesVariablesBuilder(dataConnect, parentId: parentId,);
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

