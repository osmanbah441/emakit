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

### fetchCategories
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.fetchCategories().execute();
```



#### Return Type
`execute()` returns a `QueryResult<fetchCategoriesData, void>`
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

final result = await DefaultConnector.instance.fetchCategories();
fetchCategoriesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.fetchCategories().ref();
ref.execute();

ref.subscribe(...);
```


### fetchSubCategories
#### Required Arguments
```dart
String parentId = ...;
DefaultConnector.instance.fetchSubCategories(
  parentId: parentId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<fetchSubCategoriesData, fetchSubCategoriesVariables>`
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

final result = await DefaultConnector.instance.fetchSubCategories(
  parentId: parentId,
);
fetchSubCategoriesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String parentId = ...;

final ref = DefaultConnector.instance.fetchSubCategories(
  parentId: parentId,
).ref();
ref.execute();

ref.subscribe(...);
```


### fetchProducts
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.fetchProducts().execute();
```



#### Return Type
`execute()` returns a `QueryResult<fetchProductsData, void>`
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

final result = await DefaultConnector.instance.fetchProducts();
fetchProductsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.fetchProducts().ref();
ref.execute();

ref.subscribe(...);
```


### fetchProduct
#### Required Arguments
```dart
String id = ...;
DefaultConnector.instance.fetchProduct(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<fetchProductData, fetchProductVariables>`
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

final result = await DefaultConnector.instance.fetchProduct(
  id: id,
);
fetchProductData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = DefaultConnector.instance.fetchProduct(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


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

## Mutations

### mockCategories
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.mockCategories().execute();
```



#### Return Type
`execute()` returns a `OperationResult<mockCategoriesData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.mockCategories();
mockCategoriesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.mockCategories().ref();
ref.execute();
```


### mockSubcategories
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.mockSubcategories().execute();
```



#### Return Type
`execute()` returns a `OperationResult<mockSubcategoriesData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.mockSubcategories();
mockSubcategoriesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.mockSubcategories().ref();
ref.execute();
```


### mockProducts
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.mockProducts().execute();
```



#### Return Type
`execute()` returns a `OperationResult<mockProductsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.mockProducts();
mockProductsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.mockProducts().ref();
ref.execute();
```


### mockVariation
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.mockVariation().execute();
```



#### Return Type
`execute()` returns a `OperationResult<mockVariationData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.mockVariation();
mockVariationData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.mockVariation().ref();
ref.execute();
```


### addNewCategory
#### Required Arguments
```dart
String name = ...;
DefaultConnector.instance.addNewCategory(
  name: name,
).execute();
```

#### Optional Arguments
We return a builder for each query. For addNewCategory, we created `addNewCategoryBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class AddNewCategoryVariablesBuilder {
  ...
   AddNewCategoryVariablesBuilder description(String? t) {
   _description.value = t;
   return this;
  }
  AddNewCategoryVariablesBuilder parentId(String? t) {
   _parentId.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.addNewCategory(
  name: name,
)
.description(description)
.parentId(parentId)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<addNewCategoryData, addNewCategoryVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.addNewCategory(
  name: name,
);
addNewCategoryData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;

final ref = DefaultConnector.instance.addNewCategory(
  name: name,
).ref();
ref.execute();
```


### addNewProduct
#### Required Arguments
```dart
String name = ...;
String description = ...;
String category = ...;
String brand = ...;
DefaultConnector.instance.addNewProduct(
  name: name,
  description: description,
  category: category,
  brand: brand,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<addNewProductData, addNewProductVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.addNewProduct(
  name: name,
  description: description,
  category: category,
  brand: brand,
);
addNewProductData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;
String description = ...;
String category = ...;
String brand = ...;

final ref = DefaultConnector.instance.addNewProduct(
  name: name,
  description: description,
  category: category,
  brand: brand,
).ref();
ref.execute();
```


### addNewProductVariation
#### Required Arguments
```dart
String productId = ...;
String imageUrls = ...;
double price = ...;
int stockQuantity = ...;
DefaultConnector.instance.addNewProductVariation(
  productId: productId,
  imageUrls: imageUrls,
  price: price,
  stockQuantity: stockQuantity,
).execute();
```

#### Optional Arguments
We return a builder for each query. For addNewProductVariation, we created `addNewProductVariationBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class AddNewProductVariationVariablesBuilder {
  ...
   AddNewProductVariationVariablesBuilder attributes(AnyValue? t) {
   _attributes.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.addNewProductVariation(
  productId: productId,
  imageUrls: imageUrls,
  price: price,
  stockQuantity: stockQuantity,
)
.attributes(attributes)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<addNewProductVariationData, addNewProductVariationVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.addNewProductVariation(
  productId: productId,
  imageUrls: imageUrls,
  price: price,
  stockQuantity: stockQuantity,
);
addNewProductVariationData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String productId = ...;
String imageUrls = ...;
double price = ...;
int stockQuantity = ...;

final ref = DefaultConnector.instance.addNewProductVariation(
  productId: productId,
  imageUrls: imageUrls,
  price: price,
  stockQuantity: stockQuantity,
).ref();
ref.execute();
```


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

