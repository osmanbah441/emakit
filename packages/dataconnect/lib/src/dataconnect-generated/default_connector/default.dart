library default_connector;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'dart:convert';

part 'add_new_category.dart';

part 'add_new_product.dart';

part 'add_new_product_variation.dart';

part 'add_cart_item.dart';

part 'create_cart.dart';

part 'increment_cart_item_quantity.dart';

part 'decrement_cart_item_quantity.dart';

part 'remove_cart_item.dart';

part 'clear_cart.dart';

part 'fetch_categories.dart';

part 'fetch_sub_categories.dart';

part 'fetch_category_by_name.dart';

part 'fetch_products.dart';

part 'fetch_product.dart';

part 'fetch_cart.dart';

part 'mock_categories.dart';

part 'mocksubcategories.dart';







class DefaultConnector {
  
  
  AddNewCategoryVariablesBuilder addNewCategory ({required String name, }) {
    return AddNewCategoryVariablesBuilder(dataConnect, name: name,);
  }
  
  
  AddNewProductVariablesBuilder addNewProduct ({required String name, required String description, required String category, required String brand, }) {
    return AddNewProductVariablesBuilder(dataConnect, name: name,description: description,category: category,brand: brand,);
  }
  
  
  AddNewProductVariationVariablesBuilder addNewProductVariation ({required String productId, required List<String> imageUrls, required double price, required int stockQuantity, }) {
    return AddNewProductVariationVariablesBuilder(dataConnect, productId: productId,imageUrls: imageUrls,price: price,stockQuantity: stockQuantity,);
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
  
  
  FetchCategoriesVariablesBuilder fetchCategories () {
    return FetchCategoriesVariablesBuilder(dataConnect, );
  }
  
  
  FetchSubCategoriesVariablesBuilder fetchSubCategories ({required String parentId, }) {
    return FetchSubCategoriesVariablesBuilder(dataConnect, parentId: parentId,);
  }
  
  
  FetchCategoryByNameVariablesBuilder fetchCategoryByName ({required String name, }) {
    return FetchCategoryByNameVariablesBuilder(dataConnect, name: name,);
  }
  
  
  FetchProductsVariablesBuilder fetchProducts () {
    return FetchProductsVariablesBuilder(dataConnect, );
  }
  
  
  FetchProductVariablesBuilder fetchProduct ({required String id, }) {
    return FetchProductVariablesBuilder(dataConnect, id: id,);
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

