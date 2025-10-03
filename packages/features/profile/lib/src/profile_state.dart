part of 'profile_cubit.dart';

enum PhoneLinkingStatus { initial, loading, codeSent, success, failure }

enum ProfileStatus {
  initial,
  loading,
  success,
  failure,
  authenticationRequired,
}

enum UpdateStatus { initial, inProgress, success, failure }

class ProfileState extends Equatable {
  const ProfileState({
    this.status = ProfileStatus.initial,
    this.updateStatus = UpdateStatus.initial,
    this.user,
    this.store,
    this.error,
    this.phoneLinkingStatus = PhoneLinkingStatus.initial,
    this.linkingPhoneNumber,
    this.linkingError,
  });

  final ProfileStatus status;
  final UpdateStatus updateStatus;
  final UserInfo? user;
  final Store? store;
  final String? error;
  final PhoneLinkingStatus phoneLinkingStatus;
  final String? linkingPhoneNumber;
  final String? linkingError;

  ProfileState copyWith({
    ProfileStatus? status,
    UpdateStatus? updateStatus,
    UserInfo? user,
    Store? store,
    Object? error,
    PhoneLinkingStatus? phoneLinkingStatus,
    String? linkingPhoneNumber,
    String? linkingError,
    bool clearLinkingError = false,
  }) {
    return ProfileState(
      status: status ?? this.status,
      updateStatus: updateStatus ?? this.updateStatus,
      user: user ?? this.user,
      store: store ?? this.store,
      error: error == null ? null : (error as String?) ?? this.error,
      phoneLinkingStatus: phoneLinkingStatus ?? this.phoneLinkingStatus,
      linkingPhoneNumber: linkingPhoneNumber ?? this.linkingPhoneNumber,
      linkingError: clearLinkingError
          ? null
          : linkingError ?? this.linkingError,
    );
  }

  @override
  List<Object?> get props => [
    status,
    updateStatus,
    user,
    store,
    error,
    phoneLinkingStatus,
    linkingPhoneNumber,
    linkingError,
  ];
}
