import 'package:api/api.dart';

import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class SignInNotifier extends ChangeNotifier {
  SignInNotifier();

  final _userRepository = Api.instance.userRepository;

  SignInSubmissionStatus _submissionStatus = SignInSubmissionStatus.idle;
  SignInSubmissionStatus get submissionStatus => _submissionStatus;

  void _updateStatus({SignInSubmissionStatus? status}) {
    _submissionStatus = status ?? _submissionStatus;
    notifyListeners();
  }

  void continueWithMobile(String phoneNumber) async {
    _updateStatus(status: SignInSubmissionStatus.inprogress);
    try {
      await _userRepository.signInwithPhoneNumberWeb(phoneNumber);
      _updateStatus(status: SignInSubmissionStatus.success);
    } catch (_) {
      _updateStatus(status: SignInSubmissionStatus.networkError);
    }
  }

  void continueWithGoogle() async {
    _updateStatus(status: SignInSubmissionStatus.inprogress);
    try {
      await _userRepository.signInWithGoogleWeb();
      _updateStatus(status: SignInSubmissionStatus.success);
    } on GoogleSignInCancelByUser catch (_) {
      _updateStatus(status: SignInSubmissionStatus.googleSignInError);
    } catch (_) {
      _updateStatus(status: SignInSubmissionStatus.networkError);
    }
  }

  Future<void> verifyOtp(String otp) async {
    _updateStatus(status: SignInSubmissionStatus.inprogress);
    try {
      await _userRepository.verifyOtp(otp);
      _updateStatus(status: SignInSubmissionStatus.success);
    } on UserAuthenticationRequiredException catch (_) {
      _updateStatus(status: SignInSubmissionStatus.failedOtpVerification);
    } catch (_) {}
  }
}

enum SignInSubmissionStatus {
  idle,
  inprogress,
  success,
  invalidPhoneNumber,
  failedOtpVerification,
  networkError,
  googleSignInError;

  bool get isInvalidCredentialsError =>
      this == SignInSubmissionStatus.invalidPhoneNumber;

  bool get isNetworkError => this == SignInSubmissionStatus.networkError;

  bool get isGoogleSignError =>
      this == SignInSubmissionStatus.googleSignInError;

  bool get isInProgress => this == SignInSubmissionStatus.inprogress;

  bool get isSuccess => this == SignInSubmissionStatus.success;

  bool get hasFailedOtpVerification =>
      this == SignInSubmissionStatus.failedOtpVerification;

  bool get hasError =>
      isInvalidCredentialsError ||
      isNetworkError ||
      isGoogleSignError ||
      hasFailedOtpVerification;
}
