# default_connector SDK

## Installation
```sh
flutter pub get firebase_data_connect
flutterfire configure
```
For more information, see [Flutter for Firebase installation documentation](https://firebase.google.com/docs/data-connect/flutter-sdk#use-core).

## Data Connect instance
Each connector creates a static class, with an instance of the `DataConnect` class that can be used to connect to your Data Connect backend and call operations.

### Connecting to the emulator

```dart
String host = 'localhost'; // or your host name
int port = 9399; // or your port number
DefaultConnector.instance.dataConnect.useDataConnectEmulator(host, port);
```

You can also call queries and mutations by using the connector class.
## Queries

### getUserStore
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.getUserStore().execute();
```



#### Return Type
`execute()` returns a `QueryResult<getUserStoreData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getUserStore();
getUserStoreData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.getUserStore().ref();
ref.execute();

ref.subscribe(...);
```


### getAllPendingApprovalStores
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.getAllPendingApprovalStores().execute();
```



#### Return Type
`execute()` returns a `QueryResult<getAllPendingApprovalStoresData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getAllPendingApprovalStores();
getAllPendingApprovalStoresData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.getAllPendingApprovalStores().ref();
ref.execute();

ref.subscribe(...);
```


### getAllActiveStores
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.getAllActiveStores().execute();
```



#### Return Type
`execute()` returns a `QueryResult<getAllActiveStoresData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getAllActiveStores();
getAllActiveStoresData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.getAllActiveStores().ref();
ref.execute();

ref.subscribe(...);
```


### getAllSuspendedStores
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.getAllSuspendedStores().execute();
```



#### Return Type
`execute()` returns a `QueryResult<getAllSuspendedStoresData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getAllSuspendedStores();
getAllSuspendedStoresData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.getAllSuspendedStores().ref();
ref.execute();

ref.subscribe(...);
```


### getUserCart
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.getUserCart().execute();
```



#### Return Type
`execute()` returns a `QueryResult<getUserCartData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getUserCart();
getUserCartData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.getUserCart().ref();
ref.execute();

ref.subscribe(...);
```


### getAllProducts
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.getAllProducts().execute();
```

#### Optional Arguments
We return a builder for each query. For getAllProducts, we created `getAllProductsBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class GetAllProductsVariablesBuilder {
  ...
 
  GetAllProductsVariablesBuilder category(String? t) {
   _category.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.getAllProducts()
.category(category)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<getAllProductsData, getAllProductsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getAllProducts();
getAllProductsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.getAllProducts().ref();
ref.execute();

ref.subscribe(...);
```


### getProductById
#### Required Arguments
```dart
String id = ...;
DefaultConnector.instance.getProductById(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<getProductByIdData, getProductByIdVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getProductById(
  id: id,
);
getProductByIdData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = DefaultConnector.instance.getProductById(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### getProductForStoreOwner
#### Required Arguments
```dart
String storeId = ...;
DefaultConnector.instance.getProductForStoreOwner(
  storeId: storeId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<getProductForStoreOwnerData, getProductForStoreOwnerVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getProductForStoreOwner(
  storeId: storeId,
);
getProductForStoreOwnerData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String storeId = ...;

final ref = DefaultConnector.instance.getProductForStoreOwner(
  storeId: storeId,
).ref();
ref.execute();

ref.subscribe(...);
```


### getStoreProductDetailsForOwner
#### Required Arguments
```dart
String storeId = ...;
String productId = ...;
DefaultConnector.instance.getStoreProductDetailsForOwner(
  storeId: storeId,
  productId: productId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<getStoreProductDetailsForOwnerData, getStoreProductDetailsForOwnerVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getStoreProductDetailsForOwner(
  storeId: storeId,
  productId: productId,
);
getStoreProductDetailsForOwnerData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String storeId = ...;
String productId = ...;

final ref = DefaultConnector.instance.getStoreProductDetailsForOwner(
  storeId: storeId,
  productId: productId,
).ref();
ref.execute();

ref.subscribe(...);
```


### getAllParentCategories
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.getAllParentCategories().execute();
```



#### Return Type
`execute()` returns a `QueryResult<getAllParentCategoriesData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getAllParentCategories();
getAllParentCategoriesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.getAllParentCategories().ref();
ref.execute();

ref.subscribe(...);
```


### getCategoryById
#### Required Arguments
```dart
String id = ...;
DefaultConnector.instance.getCategoryById(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<getCategoryByIdData, getCategoryByIdVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getCategoryById(
  id: id,
);
getCategoryByIdData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = DefaultConnector.instance.getCategoryById(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### getChildrenCategories
#### Required Arguments
```dart
String id = ...;
DefaultConnector.instance.getChildrenCategories(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<getChildrenCategoriesData, getChildrenCategoriesVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getChildrenCategories(
  id: id,
);
getChildrenCategoriesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = DefaultConnector.instance.getChildrenCategories(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```

## Mutations

### createNewCategory
#### Required Arguments
```dart
String name = ...;
String description = ...;
String imageUrl = ...;
DefaultConnector.instance.createNewCategory(
  name: name,
  description: description,
  imageUrl: imageUrl,
).execute();
```

#### Optional Arguments
We return a builder for each query. For createNewCategory, we created `createNewCategoryBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateNewCategoryVariablesBuilder {
  ...
   CreateNewCategoryVariablesBuilder parentCategory(String? t) {
   _parentCategory.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.createNewCategory(
  name: name,
  description: description,
  imageUrl: imageUrl,
)
.parentCategory(parentCategory)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<createNewCategoryData, createNewCategoryVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createNewCategory(
  name: name,
  description: description,
  imageUrl: imageUrl,
);
createNewCategoryData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;
String description = ...;
String imageUrl = ...;

final ref = DefaultConnector.instance.createNewCategory(
  name: name,
  description: description,
  imageUrl: imageUrl,
).ref();
ref.execute();
```


### setCategoryAttributes
#### Required Arguments
```dart
String id = ...;
DefaultConnector.instance.setCategoryAttributes(
  id: id,
).execute();
```

#### Optional Arguments
We return a builder for each query. For setCategoryAttributes, we created `setCategoryAttributesBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class SetCategoryAttributesVariablesBuilder {
  ...
   SetCategoryAttributesVariablesBuilder specificationAttributes(List<String>? t) {
   _specificationAttributes.value = t;
   return this;
  }
  SetCategoryAttributesVariablesBuilder variationAttributes(AnyValue? t) {
   _variationAttributes.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.setCategoryAttributes(
  id: id,
)
.specificationAttributes(specificationAttributes)
.variationAttributes(variationAttributes)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<setCategoryAttributesData, setCategoryAttributesVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.setCategoryAttributes(
  id: id,
);
setCategoryAttributesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = DefaultConnector.instance.setCategoryAttributes(
  id: id,
).ref();
ref.execute();
```


### deleteCategory
#### Required Arguments
```dart
String id = ...;
DefaultConnector.instance.deleteCategory(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<deleteCategoryData, deleteCategoryVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.deleteCategory(
  id: id,
);
deleteCategoryData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = DefaultConnector.instance.deleteCategory(
  id: id,
).ref();
ref.execute();
```


### createNewProduct
#### Required Arguments
```dart
String name = ...;
String description = ...;
String category = ...;
AnyValue specs = ...;
String storeId = ...;
AnyValue attributes = ...;
String imageUrls = ...;
double price = ...;
int availableStock = ...;
DefaultConnector.instance.createNewProduct(
  name: name,
  description: description,
  category: category,
  specs: specs,
  storeId: storeId,
  attributes: attributes,
  imageUrls: imageUrls,
  price: price,
  availableStock: availableStock,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<createNewProductData, createNewProductVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createNewProduct(
  name: name,
  description: description,
  category: category,
  specs: specs,
  storeId: storeId,
  attributes: attributes,
  imageUrls: imageUrls,
  price: price,
  availableStock: availableStock,
);
createNewProductData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;
String description = ...;
String category = ...;
AnyValue specs = ...;
String storeId = ...;
AnyValue attributes = ...;
String imageUrls = ...;
double price = ...;
int availableStock = ...;

final ref = DefaultConnector.instance.createNewProduct(
  name: name,
  description: description,
  category: category,
  specs: specs,
  storeId: storeId,
  attributes: attributes,
  imageUrls: imageUrls,
  price: price,
  availableStock: availableStock,
).ref();
ref.execute();
```


### createNewproductVariation
#### Required Arguments
```dart
String productId = ...;
String storeId = ...;
AnyValue attributes = ...;
String imageUrls = ...;
double price = ...;
int availableStock = ...;
DefaultConnector.instance.createNewproductVariation(
  productId: productId,
  storeId: storeId,
  attributes: attributes,
  imageUrls: imageUrls,
  price: price,
  availableStock: availableStock,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<createNewproductVariationData, createNewproductVariationVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createNewproductVariation(
  productId: productId,
  storeId: storeId,
  attributes: attributes,
  imageUrls: imageUrls,
  price: price,
  availableStock: availableStock,
);
createNewproductVariationData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String productId = ...;
String storeId = ...;
AnyValue attributes = ...;
String imageUrls = ...;
double price = ...;
int availableStock = ...;

final ref = DefaultConnector.instance.createNewproductVariation(
  productId: productId,
  storeId: storeId,
  attributes: attributes,
  imageUrls: imageUrls,
  price: price,
  availableStock: availableStock,
).ref();
ref.execute();
```


### createNewUser
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.createNewUser().execute();
```

#### Optional Arguments
We return a builder for each query. For createNewUser, we created `createNewUserBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateNewUserVariablesBuilder {
  ...
 
  CreateNewUserVariablesBuilder displayName(String? t) {
   _displayName.value = t;
   return this;
  }
  CreateNewUserVariablesBuilder email(String? t) {
   _email.value = t;
   return this;
  }
  CreateNewUserVariablesBuilder phoneNumber(String? t) {
   _phoneNumber.value = t;
   return this;
  }
  CreateNewUserVariablesBuilder photoUrl(String? t) {
   _photoUrl.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.createNewUser()
.displayName(displayName)
.email(email)
.phoneNumber(phoneNumber)
.photoUrl(photoUrl)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<createNewUserData, createNewUserVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createNewUser();
createNewUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.createNewUser().ref();
ref.execute();
```


### applyForStore
#### Required Arguments
```dart
String name = ...;
String phoneNumber = ...;
DefaultConnector.instance.applyForStore(
  name: name,
  phoneNumber: phoneNumber,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<applyForStoreData, applyForStoreVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.applyForStore(
  name: name,
  phoneNumber: phoneNumber,
);
applyForStoreData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;
String phoneNumber = ...;

final ref = DefaultConnector.instance.applyForStore(
  name: name,
  phoneNumber: phoneNumber,
).ref();
ref.execute();
```


### updateDisplayName
#### Required Arguments
```dart
String displayName = ...;
DefaultConnector.instance.updateDisplayName(
  displayName: displayName,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<updateDisplayNameData, updateDisplayNameVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.updateDisplayName(
  displayName: displayName,
);
updateDisplayNameData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String displayName = ...;

final ref = DefaultConnector.instance.updateDisplayName(
  displayName: displayName,
).ref();
ref.execute();
```


### approveStore
#### Required Arguments
```dart
String storeId = ...;
DefaultConnector.instance.approveStore(
  storeId: storeId,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<approveStoreData, approveStoreVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.approveStore(
  storeId: storeId,
);
approveStoreData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String storeId = ...;

final ref = DefaultConnector.instance.approveStore(
  storeId: storeId,
).ref();
ref.execute();
```


### createCartItem
#### Required Arguments
```dart
String productVariationId = ...;
String cartId = ...;
DefaultConnector.instance.createCartItem(
  productVariationId: productVariationId,
  cartId: cartId,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<createCartItemData, createCartItemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createCartItem(
  productVariationId: productVariationId,
  cartId: cartId,
);
createCartItemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String productVariationId = ...;
String cartId = ...;

final ref = DefaultConnector.instance.createCartItem(
  productVariationId: productVariationId,
  cartId: cartId,
).ref();
ref.execute();
```


### mock
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.mock().execute();
```



#### Return Type
`execute()` returns a `OperationResult<mockData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.mock();
mockData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.mock().ref();
ref.execute();
```

