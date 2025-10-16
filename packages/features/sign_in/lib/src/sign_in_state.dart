part of 'sign_in_cubit.dart';

enum SignInSubmissionStatus {
  initial,
  googleSignInLoading,
  appleSignInLoading,
  success,
  failure,
}

class SignInState extends Equatable {
  const SignInState({this.status = SignInSubmissionStatus.initial, this.error});

  final SignInSubmissionStatus status;
  final String? error;

  SignInState copyWith({SignInSubmissionStatus? status, String? error}) =>
      SignInState(status: status ?? this.status, error: error);

  @override
  List<Object?> get props => [status, error];
}
