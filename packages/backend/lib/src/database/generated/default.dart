library default_connector;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'dart:convert';

part 'create_movie.dart';

part 'upsert_user.dart';

part 'add_review.dart';

part 'delete_review.dart';







class DefaultConnector {
  
  
  CreateMovieVariablesBuilder createMovie ({required String title, required String genre, required String imageUrl, }) {
    return CreateMovieVariablesBuilder(dataConnect, title: title,genre: genre,imageUrl: imageUrl,);
  }
  
  
  UpsertUserVariablesBuilder upsertUser ({required String username, }) {
    return UpsertUserVariablesBuilder(dataConnect, username: username,);
  }
  
  
  AddReviewVariablesBuilder addReview ({required String movieId, required int rating, required String reviewText, }) {
    return AddReviewVariablesBuilder(dataConnect, movieId: movieId,rating: rating,reviewText: reviewText,);
  }
  
  
  DeleteReviewVariablesBuilder deleteReview ({required String movieId, }) {
    return DeleteReviewVariablesBuilder(dataConnect, movieId: movieId,);
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

