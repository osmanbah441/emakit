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
This connector does not contain any queries.
## Mutations

### CreateMovie
#### Required Arguments
```dart
String title = ...;
String genre = ...;
String imageUrl = ...;
DefaultConnector.instance.createMovie(
  title: title,
  genre: genre,
  imageUrl: imageUrl,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateMovieData, CreateMovieVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createMovie(
  title: title,
  genre: genre,
  imageUrl: imageUrl,
);
CreateMovieData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String title = ...;
String genre = ...;
String imageUrl = ...;

final ref = DefaultConnector.instance.createMovie(
  title: title,
  genre: genre,
  imageUrl: imageUrl,
).ref();
ref.execute();
```


### UpsertUser
#### Required Arguments
```dart
String username = ...;
DefaultConnector.instance.upsertUser(
  username: username,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpsertUserData, UpsertUserVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.upsertUser(
  username: username,
);
UpsertUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String username = ...;

final ref = DefaultConnector.instance.upsertUser(
  username: username,
).ref();
ref.execute();
```


### AddReview
#### Required Arguments
```dart
String movieId = ...;
int rating = ...;
String reviewText = ...;
DefaultConnector.instance.addReview(
  movieId: movieId,
  rating: rating,
  reviewText: reviewText,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<AddReviewData, AddReviewVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.addReview(
  movieId: movieId,
  rating: rating,
  reviewText: reviewText,
);
AddReviewData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String movieId = ...;
int rating = ...;
String reviewText = ...;

final ref = DefaultConnector.instance.addReview(
  movieId: movieId,
  rating: rating,
  reviewText: reviewText,
).ref();
ref.execute();
```


### DeleteReview
#### Required Arguments
```dart
String movieId = ...;
DefaultConnector.instance.deleteReview(
  movieId: movieId,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteReviewData, DeleteReviewVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.deleteReview(
  movieId: movieId,
);
DeleteReviewData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String movieId = ...;

final ref = DefaultConnector.instance.deleteReview(
  movieId: movieId,
).ref();
ref.execute();
```

