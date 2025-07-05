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

### fetchCart
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.fetchCart().execute();
```



#### Return Type
`execute()` returns a `QueryResult<fetchCartData, void>`
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

final result = await DefaultConnector.instance.fetchCart();
fetchCartData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.fetchCart().ref();
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


### getAllUser
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.getAllUser().execute();
```



#### Return Type
`execute()` returns a `QueryResult<getAllUserData, void>`
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

final result = await DefaultConnector.instance.getAllUser();
getAllUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.getAllUser().ref();
ref.execute();

ref.subscribe(...);
```


### getAllStore
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.getAllStore().execute();
```



#### Return Type
`execute()` returns a `QueryResult<getAllStoreData, void>`
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

final result = await DefaultConnector.instance.getAllStore();
getAllStoreData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.getAllStore().ref();
ref.execute();

ref.subscribe(...);
```


### getStoreById
#### Required Arguments
```dart
String id = ...;
DefaultConnector.instance.getStoreById(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<getStoreByIdData, getStoreByIdVariables>`
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

final result = await DefaultConnector.instance.getStoreById(
  id: id,
);
getStoreByIdData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = DefaultConnector.instance.getStoreById(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```

## Mutations

### addCartItem
#### Required Arguments
```dart
double unitPrice = ...;
int quantity = ...;
String variationId = ...;
DefaultConnector.instance.addCartItem(
  unitPrice: unitPrice,
  quantity: quantity,
  variationId: variationId,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<addCartItemData, addCartItemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.addCartItem(
  unitPrice: unitPrice,
  quantity: quantity,
  variationId: variationId,
);
addCartItemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
double unitPrice = ...;
int quantity = ...;
String variationId = ...;

final ref = DefaultConnector.instance.addCartItem(
  unitPrice: unitPrice,
  quantity: quantity,
  variationId: variationId,
).ref();
ref.execute();
```


### createCart
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.createCart().execute();
```



#### Return Type
`execute()` returns a `OperationResult<createCartData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createCart();
createCartData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.createCart().ref();
ref.execute();
```


### incrementCartItemQuantity
#### Required Arguments
```dart
String cartItemId = ...;
int quantity = ...;
DefaultConnector.instance.incrementCartItemQuantity(
  cartItemId: cartItemId,
  quantity: quantity,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<incrementCartItemQuantityData, incrementCartItemQuantityVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.incrementCartItemQuantity(
  cartItemId: cartItemId,
  quantity: quantity,
);
incrementCartItemQuantityData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String cartItemId = ...;
int quantity = ...;

final ref = DefaultConnector.instance.incrementCartItemQuantity(
  cartItemId: cartItemId,
  quantity: quantity,
).ref();
ref.execute();
```


### decrementCartItemQuantity
#### Required Arguments
```dart
String cartItemId = ...;
int quantity = ...;
DefaultConnector.instance.decrementCartItemQuantity(
  cartItemId: cartItemId,
  quantity: quantity,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<decrementCartItemQuantityData, decrementCartItemQuantityVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.decrementCartItemQuantity(
  cartItemId: cartItemId,
  quantity: quantity,
);
decrementCartItemQuantityData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String cartItemId = ...;
int quantity = ...;

final ref = DefaultConnector.instance.decrementCartItemQuantity(
  cartItemId: cartItemId,
  quantity: quantity,
).ref();
ref.execute();
```


### removeCartItem
#### Required Arguments
```dart
String id = ...;
DefaultConnector.instance.removeCartItem(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<removeCartItemData, removeCartItemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.removeCartItem(
  id: id,
);
removeCartItemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = DefaultConnector.instance.removeCartItem(
  id: id,
).ref();
ref.execute();
```


### clearCart
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.clearCart().execute();
```



#### Return Type
`execute()` returns a `OperationResult<clearCartData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.clearCart();
clearCartData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.clearCart().ref();
ref.execute();
```


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
   CreateNewCategoryVariablesBuilder parentId(String? t) {
   _parentId.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.createNewCategory(
  name: name,
  description: description,
  imageUrl: imageUrl,
)
.parentId(parentId)
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


### updateCategoryAttributes
#### Required Arguments
```dart
String id = ...;
DefaultConnector.instance.updateCategoryAttributes(
  id: id,
).execute();
```

#### Optional Arguments
We return a builder for each query. For updateCategoryAttributes, we created `updateCategoryAttributesBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class UpdateCategoryAttributesVariablesBuilder {
  ...
   UpdateCategoryAttributesVariablesBuilder varition(AnyValue? t) {
   _varition.value = t;
   return this;
  }
  UpdateCategoryAttributesVariablesBuilder specification(List<String>? t) {
   _specification.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.updateCategoryAttributes(
  id: id,
)
.varition(varition)
.specification(specification)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<updateCategoryAttributesData, updateCategoryAttributesVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.updateCategoryAttributes(
  id: id,
);
updateCategoryAttributesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = DefaultConnector.instance.updateCategoryAttributes(
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
String productId = ...;
AnyValue attributes = ...;
String imageUrls = ...;
double price = ...;
int stockQuantity = ...;
DefaultConnector.instance.createNewProductVariation(
  storeId: storeId,
  productId: productId,
  attributes: attributes,
  imageUrls: imageUrls,
  price: price,
  stockQuantity: stockQuantity,
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
  productId: productId,
  attributes: attributes,
  imageUrls: imageUrls,
  price: price,
  stockQuantity: stockQuantity,
);
createNewProductVariationData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String storeId = ...;
String productId = ...;
AnyValue attributes = ...;
String imageUrls = ...;
double price = ...;
int stockQuantity = ...;

final ref = DefaultConnector.instance.createNewProductVariation(
  storeId: storeId,
  productId: productId,
  attributes: attributes,
  imageUrls: imageUrls,
  price: price,
  stockQuantity: stockQuantity,
).ref();
ref.execute();
```


### createNewUser
#### Required Arguments
```dart
String id = ...;
DefaultConnector.instance.createNewUser(
  id: id,
).execute();
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
  CreateNewUserVariablesBuilder phoneNumber(String? t) {
   _phoneNumber.value = t;
   return this;
  }
  CreateNewUserVariablesBuilder email(String? t) {
   _email.value = t;
   return this;
  }
  CreateNewUserVariablesBuilder photoURL(String? t) {
   _photoURL.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.createNewUser(
  id: id,
)
.displayName(displayName)
.phoneNumber(phoneNumber)
.email(email)
.photoURL(photoURL)
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

final result = await DefaultConnector.instance.createNewUser(
  id: id,
);
createNewUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = DefaultConnector.instance.createNewUser(
  id: id,
).ref();
ref.execute();
```


### createStoreForUser
#### Required Arguments
```dart
String ownerId = ...;
String name = ...;
String description = ...;
String logoUrl = ...;
String phoneNumber = ...;
DefaultConnector.instance.createStoreForUser(
  ownerId: ownerId,
  name: name,
  description: description,
  logoUrl: logoUrl,
  phoneNumber: phoneNumber,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<createStoreForUserData, createStoreForUserVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createStoreForUser(
  ownerId: ownerId,
  name: name,
  description: description,
  logoUrl: logoUrl,
  phoneNumber: phoneNumber,
);
createStoreForUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String ownerId = ...;
String name = ...;
String description = ...;
String logoUrl = ...;
String phoneNumber = ...;

final ref = DefaultConnector.instance.createStoreForUser(
  ownerId: ownerId,
  name: name,
  description: description,
  logoUrl: logoUrl,
  phoneNumber: phoneNumber,
).ref();
ref.execute();
```

