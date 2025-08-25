part of 'sign_in_cubit.dart';

enum SignInMethod { none, phone, google }

enum SignInSubmissionStatus {
  initial,
  inProgress,
  awaitingOtp,
  success,
  invalidPhoneNumber,
  failedOtpVerification,
  googleSignInError,
  networkError,
  unknownError;

  bool get isInProgress => this == SignInSubmissionStatus.inProgress;
  bool get isAwaitingOtp => this == SignInSubmissionStatus.awaitingOtp;
  bool get isSuccess => this == SignInSubmissionStatus.success;

  bool get hasError =>
      this == SignInSubmissionStatus.invalidPhoneNumber ||
      this == SignInSubmissionStatus.failedOtpVerification ||
      this == SignInSubmissionStatus.googleSignInError ||
      this == SignInSubmissionStatus.networkError ||
      this == SignInSubmissionStatus.unknownError;
}

class SignInState extends Equatable {
  const SignInState({
    this.status = SignInSubmissionStatus.initial,
    this.method = SignInMethod.none,
  });

  final SignInSubmissionStatus status;
  final SignInMethod method;

  SignInState copyWith({SignInSubmissionStatus? status, SignInMethod? method}) {
    return SignInState(
      status: status ?? this.status,
      method: method ?? this.method,
    );
  }

  @override
  List<Object> get props => [status, method];
}
