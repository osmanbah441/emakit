import 'dart:async';

import 'package:domain_models/domain_models.dart' as domain;
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'extensions.dart';

part 'user_repository_impl.dart';

/// An abstract interface for managing user authentication and profile data.
///
/// This repository provides a platform-agnostic API for common authentication flows,
/// hiding the implementation details of Firebase Auth for web and mobile.
abstract class UserRepository {
  /// The singleton instance of the repository.
  static UserRepository instance = UserRepositoryImpl();

  // static void useEmulator({String host = 'localhost', int port = 9099}) async {
  //   await FirebaseAuth.instance.useAuthEmulator(host, port);
  // }

  /// A stream that notifies listeners of changes to the user's sign-in state.
  Stream<domain.UserInfo?> get onUserChanges;

  /// Gets the currently signed-in user, or null if no user is signed in.
  domain.UserInfo? get currentUser;

  /// Signs out the current user.
  Future<void> signOut();

  /// Signs in the user with their Google account.
  Future<void> signInWithGoogle();

  Future<void> signInWithApple();
}
