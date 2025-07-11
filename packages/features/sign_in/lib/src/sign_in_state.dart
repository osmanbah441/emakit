part of 'sign_in_cubit.dart';

enum SignInSubmissionStatus {
  idle,
  inprogress,
  awaitingOtp,
  success,
  invalidPhoneNumber,
  failedOtpVerification,
  networkError,
  newUser,
  googleSignInError;

  bool get isAwaitingOtp => this == SignInSubmissionStatus.awaitingOtp;
  bool get isSuccess => this == SignInSubmissionStatus.success;
  bool get isInProgress => this == SignInSubmissionStatus.inprogress;

  bool get hasError =>
      this == SignInSubmissionStatus.invalidPhoneNumber ||
      this == SignInSubmissionStatus.failedOtpVerification ||
      this == SignInSubmissionStatus.networkError ||
      this == SignInSubmissionStatus.googleSignInError;
}

class SignInState {
  final SignInSubmissionStatus status;
  final UserInfo? user;

  const SignInState({this.status = SignInSubmissionStatus.idle, this.user});

  SignInState copyWith({SignInSubmissionStatus? status, UserInfo? user}) {
    return SignInState(status: status ?? this.status, user: user ?? this.user);
  }
}
