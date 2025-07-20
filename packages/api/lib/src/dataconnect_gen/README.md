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

### GetUser
#### Required Arguments
```dart
String id = ...;
DefaultConnector.instance.getUser(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetUserData, GetUserVariables>`
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

final result = await DefaultConnector.instance.getUser(
  id: id,
);
GetUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = DefaultConnector.instance.getUser(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### getAllUsers
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.getAllUsers().execute();
```



#### Return Type
`execute()` returns a `QueryResult<getAllUsersData, void>`
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

final result = await DefaultConnector.instance.getAllUsers();
getAllUsersData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.getAllUsers().ref();
ref.execute();

ref.subscribe(...);
```


### getAllAddresses
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.getAllAddresses().execute();
```



#### Return Type
`execute()` returns a `QueryResult<getAllAddressesData, void>`
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

final result = await DefaultConnector.instance.getAllAddresses();
getAllAddressesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.getAllAddresses().ref();
ref.execute();

ref.subscribe(...);
```


### getAllCategories
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.getAllCategories().execute();
```



#### Return Type
`execute()` returns a `QueryResult<getAllCategoriesData, void>`
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

final result = await DefaultConnector.instance.getAllCategories();
getAllCategoriesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.getAllCategories().ref();
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


### getAllProducts
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.getAllProducts().execute();
```



#### Return Type
`execute()` returns a `QueryResult<getAllProductsData, void>`
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


### getAllStores
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.getAllStores().execute();
```



#### Return Type
`execute()` returns a `QueryResult<getAllStoresData, void>`
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

final result = await DefaultConnector.instance.getAllStores();
getAllStoresData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.getAllStores().ref();
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


### mockParentCategory
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.mockParentCategory().execute();
```



#### Return Type
`execute()` returns a `OperationResult<mockParentCategoryData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.mockParentCategory();
mockParentCategoryData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.mockParentCategory().ref();
ref.execute();
```


### mockChildrenCategory
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.mockChildrenCategory().execute();
```



#### Return Type
`execute()` returns a `OperationResult<mockChildrenCategoryData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.mockChildrenCategory();
mockChildrenCategoryData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.mockChildrenCategory().ref();
ref.execute();
```


### createNewProduct
#### Required Arguments
```dart
String name = ...;
String description = ...;
String category = ...;
String mainImage = ...;
AnyValue specs = ...;
DefaultConnector.instance.createNewProduct(
  name: name,
  description: description,
  category: category,
  mainImage: mainImage,
  specs: specs,
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
  mainImage: mainImage,
  specs: specs,
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
String mainImage = ...;
AnyValue specs = ...;

final ref = DefaultConnector.instance.createNewProduct(
  name: name,
  description: description,
  category: category,
  mainImage: mainImage,
  specs: specs,
).ref();
ref.execute();
```


### createNewProductVariation
#### Required Arguments
```dart
String storeId = ...;
AnyValue attributes = ...;
String productId = ...;
String imageUrls = ...;
double price = ...;
int availabeStock = ...;
DefaultConnector.instance.createNewProductVariation(
  storeId: storeId,
  attributes: attributes,
  productId: productId,
  imageUrls: imageUrls,
  price: price,
  availabeStock: availabeStock,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<createNewProductVariationData, createNewProductVariationVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createNewProductVariation(
  storeId: storeId,
  attributes: attributes,
  productId: productId,
  imageUrls: imageUrls,
  price: price,
  availabeStock: availabeStock,
);
createNewProductVariationData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String storeId = ...;
AnyValue attributes = ...;
String productId = ...;
String imageUrls = ...;
double price = ...;
int availabeStock = ...;

final ref = DefaultConnector.instance.createNewProductVariation(
  storeId: storeId,
  attributes: attributes,
  productId: productId,
  imageUrls: imageUrls,
  price: price,
  availabeStock: availabeStock,
).ref();
ref.execute();
```


### createStore
#### Required Arguments
```dart
String name = ...;
String description = ...;
String ownerId = ...;
String addressId = ...;
String logoUrl = ...;
String phoneNumber = ...;
DefaultConnector.instance.createStore(
  name: name,
  description: description,
  ownerId: ownerId,
  addressId: addressId,
  logoUrl: logoUrl,
  phoneNumber: phoneNumber,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<createStoreData, createStoreVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createStore(
  name: name,
  description: description,
  ownerId: ownerId,
  addressId: addressId,
  logoUrl: logoUrl,
  phoneNumber: phoneNumber,
);
createStoreData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;
String description = ...;
String ownerId = ...;
String addressId = ...;
String logoUrl = ...;
String phoneNumber = ...;

final ref = DefaultConnector.instance.createStore(
  name: name,
  description: description,
  ownerId: ownerId,
  addressId: addressId,
  logoUrl: logoUrl,
  phoneNumber: phoneNumber,
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


### createNewAddressForUser
#### Required Arguments
```dart
String label = ...;
DefaultConnector.instance.createNewAddressForUser(
  label: label,
).execute();
```

#### Optional Arguments
We return a builder for each query. For createNewAddressForUser, we created `createNewAddressForUserBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateNewAddressForUserVariablesBuilder {
  ...
   CreateNewAddressForUserVariablesBuilder addressLine(String? t) {
   _addressLine.value = t;
   return this;
  }
  CreateNewAddressForUserVariablesBuilder district(String? t) {
   _district.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.createNewAddressForUser(
  label: label,
)
.addressLine(addressLine)
.district(district)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<createNewAddressForUserData, createNewAddressForUserVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createNewAddressForUser(
  label: label,
);
createNewAddressForUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String label = ...;

final ref = DefaultConnector.instance.createNewAddressForUser(
  label: label,
).ref();
ref.execute();
```

