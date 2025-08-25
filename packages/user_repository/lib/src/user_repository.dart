import 'dart:async';

import 'package:domain_models/domain_models.dart' as domain;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'extensions.dart';

part 'user_repository_impl.dart';

abstract class UserRepository {
  static const UserRepository instance = UserRepositoryImpl();

  static void useEmulator({String host = 'localhost', int port = 9099}) async =>
      await FirebaseAuth.instance.useAuthEmulator(host, port);

  Stream<domain.UserInfo?> get onAuthStateChanged;
  domain.UserInfo? get currentUser;

  Future<void> signInwithPhoneNumberWeb(String phoneNumber);

  /// return true if new user
  Future<void> verifyOtpWeb(String code);

  /// return true if new user
  Future<void> signInWithGoogleWeb();

  /// return true if new user
  Future<void> signInWithGoogleMobile();

  /// return true if new user
  Future<void> signInWithPhoneNumberMobile();

  Future<void> signOut();

  Future<void> completeUserProfileSetup({
    required String fullName,
    required DateTime dateOfBirth,
  });
  Future<void> deleteUserAccount(String uid);
}
