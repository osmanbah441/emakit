part of 'sign_in_cubit.dart';

enum SignInSubmissionStatus {
  initial,
  loading,
  codeSent,
  success,
  failure,
  usernameRequired,
}

class SignInState extends Equatable {
  const SignInState({
    this.phoneNumber,
    this.status = SignInSubmissionStatus.initial,
    this.error,
  });

  final String? phoneNumber;
  final SignInSubmissionStatus status;
  final String? error;

  SignInState copyWith({
    String? phoneNumber,
    SignInSubmissionStatus? status,
    String? error,
  }) => SignInState(
    phoneNumber: phoneNumber ?? this.phoneNumber,
    status: status ?? this.status,
    error: error,
  );

  @override
  List<Object?> get props => [phoneNumber, status, error];
}
