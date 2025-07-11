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

