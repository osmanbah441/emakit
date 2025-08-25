part of 'complete_profile_cubit.dart';

enum CompleteProfileStatus { initial, loading, success, error }

class CompleteProfileState extends Equatable {
  const CompleteProfileState({
    this.status = CompleteProfileStatus.initial,
    this.currentUser,
    this.errorMessage,
  });

  final CompleteProfileStatus status;
  final UserInfo? currentUser;
  final String? errorMessage;

  CompleteProfileState copyWith({
    CompleteProfileStatus? status,
    UserInfo? currentUser,
    String? errorMessage,
  }) {
    return CompleteProfileState(
      status: status ?? this.status,
      currentUser: currentUser ?? this.currentUser,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, currentUser, errorMessage];
}
