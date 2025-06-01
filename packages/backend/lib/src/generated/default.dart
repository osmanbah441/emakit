library default_connector;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'dart:convert';

part 'mock_categories.dart';

part 'mock_subcategories.dart';

part 'mock_products.dart';

part 'mock_variation.dart';

part 'add_new_category.dart';

part 'add_new_product.dart';

part 'add_new_product_variation.dart';

part 'fetch_categories.dart';

part 'fetch_products.dart';

part 'fetch_product.dart';







class DefaultConnector {
  
  
  MockCategoriesVariablesBuilder mockCategories () {
    return MockCategoriesVariablesBuilder(dataConnect, );
  }
  
  
  MockSubcategoriesVariablesBuilder mockSubcategories () {
    return MockSubcategoriesVariablesBuilder(dataConnect, );
  }
  
  
  MockProductsVariablesBuilder mockProducts () {
    return MockProductsVariablesBuilder(dataConnect, );
  }
  
  
  MockVariationVariablesBuilder mockVariation () {
    return MockVariationVariablesBuilder(dataConnect, );
  }
  
  
  AddNewCategoryVariablesBuilder addNewCategory ({required String name, }) {
    return AddNewCategoryVariablesBuilder(dataConnect, name: name,);
  }
  
  
  AddNewProductVariablesBuilder addNewProduct ({required String name, required String description, required String category, required String brand, }) {
    return AddNewProductVariablesBuilder(dataConnect, name: name,description: description,category: category,brand: brand,);
  }
  
  
  AddNewProductVariationVariablesBuilder addNewProductVariation ({required String productId, required List<String> imageUrls, required double price, required int stockQuantity, }) {
    return AddNewProductVariationVariablesBuilder(dataConnect, productId: productId,imageUrls: imageUrls,price: price,stockQuantity: stockQuantity,);
  }
  
  
  FetchCategoriesVariablesBuilder fetchCategories () {
    return FetchCategoriesVariablesBuilder(dataConnect, );
  }
  
  
  FetchProductsVariablesBuilder fetchProducts () {
    return FetchProductsVariablesBuilder(dataConnect, );
  }
  
  
  FetchProductVariablesBuilder fetchProduct ({required String id, }) {
    return FetchProductVariablesBuilder(dataConnect, id: id,);
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

